import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class _CacheEntry {
  final String body;
  final DateTime expiry;
  _CacheEntry(this.body, this.expiry);
  bool get isExpired => DateTime.now().isAfter(expiry);
}

class AppApiService {
  //static const String baseUrl = 'http://192.168.0.246:5000';
  static const String baseUrl = 'https://api.dmatechno.com';
  static Future<bool>? _ongoingRefresh;
  // Simple in-memory cache for GET responses (path -> body + expiry)
  static final Map<String, _CacheEntry> _getCache = {};

  // Deduplicate concurrent GET requests for the same path
  static final Map<String, Future<http.Response>> _ongoingGetRequests = {};

  // Default cache TTL for GET in seconds. Keep small to favor freshness.
  static const int _getCacheTtlSeconds = 30;

  Uri buildUrl(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final normalizedBaseUrl = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return Uri.parse('$normalizedBaseUrl$normalizedPath');
  }

  Future<http.Response> post({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = buildUrl(path);
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    debugPrint('POST => $uri');
    debugPrint('POST body => ${jsonEncode(body ?? <String, dynamic>{})}');

    final response = await http
        .post(
          uri,
          headers: requestHeaders,
          body: jsonEncode(body ?? <String, dynamic>{}),
        )
        .timeout(const Duration(seconds: 30));

    debugPrint('POST status <= ${response.statusCode}');
    debugPrint('POST response <= ${response.body}');

    return response;
  }

  Future<http.Response> get({
    required String path,
    Map<String, String>? headers,
  }) async {
    final uri = buildUrl(path);
    final requestHeaders = <String, String>{
      'Accept': 'application/json',
      ...?headers,
    };

    final key = uri.toString();

    debugPrint('GET => $uri');
    debugPrint('GET headers => $requestHeaders');

    // Return cached response if present and not expired
    final cached = _getCache[key];
    if (cached != null && !cached.isExpired) {
      debugPrint('GET cache hit => $key');
      return http.Response(cached.body, 200,
          headers: {'content-type': 'application/json'});
    }

    // If there's an ongoing identical GET request, await it (dedupe)
    if (_ongoingGetRequests.containsKey(key)) {
      debugPrint('Awaiting ongoing GET for $key');
      try {
        return await _ongoingGetRequests[key]!;
      } catch (e) {
        // fall through to issuing a fresh request
      }
    }

    final futureResponse = http
        .get(
          uri,
          headers: requestHeaders,
        )
        .timeout(const Duration(seconds: 30));

    _ongoingGetRequests[key] = futureResponse;

    try {
      final response = await futureResponse;
      debugPrint('GET status <= ${response.statusCode}');
      debugPrint('GET response <= ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          // cache the raw body with a short TTL to improve perceived speed
          _getCache[key] = _CacheEntry(response.body,
              DateTime.now().add(const Duration(seconds: _getCacheTtlSeconds)));
        } catch (_) {}
      }

      return response;
    } finally {
      _ongoingGetRequests.remove(key);
    }
  }

  Future<http.Response> getWithAuthRetry({
    required String path,
    Map<String, String>? headers,
  }) async {
    final accessToken = AuthService.to.accessToken.value.trim();
    if (accessToken.isEmpty) {
      return get(path: path, headers: headers);
    }

    final initialResponse = await get(
      path: path,
      headers: {
        ...?headers,
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (initialResponse.statusCode != 401) {
      return initialResponse;
    }

    final refreshed = await _refreshAccessToken();
    if (!refreshed) {
      return initialResponse;
    }

    final newAccessToken = AuthService.to.accessToken.value.trim();
    if (newAccessToken.isEmpty) {
      return initialResponse;
    }

    return get(
      path: path,
      headers: {
        ...?headers,
        'Authorization': 'Bearer $newAccessToken',
      },
    );
  }

  Future<bool> _refreshAccessToken() async {
    final ongoingRefresh = _ongoingRefresh;
    if (ongoingRefresh != null) {
      return ongoingRefresh;
    }

    final refreshFuture = _performRefreshAccessToken();
    _ongoingRefresh = refreshFuture;

    try {
      return await refreshFuture;
    } finally {
      _ongoingRefresh = null;
    }
  }

  Future<bool> _performRefreshAccessToken() async {
    final currentRefresh = AuthService.to.refreshToken.value.trim();
    if (currentRefresh.isEmpty) {
      await AuthService.to.logout();
      return false;
    }

    const refreshPaths = <String>[
      '/api/v1/auth/token/refresh/',
      '/api/v1/auth/refresh/',
      '/api/v1/token/refresh/',
    ];

    bool shouldLogout = false;

    for (final path in refreshPaths) {
      try {
        final response = await post(
          path: path,
          body: {'refresh': currentRefresh},
        );

        if (response.statusCode < 200 || response.statusCode >= 300) {
          if (response.statusCode == 400 || response.statusCode == 401) {
            shouldLogout = true;
          }
          continue;
        }

        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          continue;
        }

        final newAccess = _extractToken(decoded, [
          'access',
          'access_token',
          'token',
        ]);
        final newRefresh = _extractToken(decoded, [
          'refresh',
          'refresh_token',
        ]);

        if (newAccess.isEmpty) {
          continue;
        }

        await AuthService.to.login(
          access: newAccess,
          refresh: newRefresh.isEmpty ? currentRefresh : newRefresh,
        );

        debugPrint('Token refresh success => new access token saved');
        return true;
      } catch (e) {
        debugPrint('Token refresh failed on $path => $e');
      }
    }

    if (shouldLogout) {
      await AuthService.to.logout();
    }

    return false;
  }

  String _extractToken(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return '';
  }

  Future<http.Response> putMultipart({
    required String path,
    required String fileField,
    required String filePath,
    Map<String, String>? headers,
  }) async {
    final uri = buildUrl(path);
    final request = http.MultipartRequest('PUT', uri);

    request.headers.addAll({
      'Accept': 'application/json',
      ...?headers,
    });

    request.files.add(await http.MultipartFile.fromPath(fileField, filePath));

    debugPrint('PUT multipart => $uri');
    debugPrint('PUT multipart headers => ${request.headers}');
    debugPrint('PUT multipart file => $fileField: $filePath');

    final streamedResponse =
        await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint('PUT multipart status <= ${response.statusCode}');
    debugPrint('PUT multipart response <= ${response.body}');

    return response;
  }
}
