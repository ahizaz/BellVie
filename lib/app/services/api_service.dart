import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AppApiService {
  static const String baseUrl = 'http://192.168.0.245:5000';

  Uri buildUrl(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$normalizedPath');
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
}
