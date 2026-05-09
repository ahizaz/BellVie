import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../models/popular_service.dart';

class PopularServiceRepository {
  final AppApiService _apiService = AppApiService();

  static const String _cacheKey = 'popular_services_cache_v1';

  Future<List<PopularService>> loadCachedCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey);

      if (cachedJson == null || cachedJson.isEmpty) {
        return [];
      }

      final decoded = jsonDecode(cachedJson);
      if (decoded is! List) {
        return [];
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map((e) => PopularService.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Popular services cache read error => $e');
      return [];
    }
  }

  Future<void> saveCachedCategories(List<PopularService> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
      await prefs.setString(_cacheKey, encoded);
    } catch (e) {
      debugPrint('Popular services cache write error => $e');
    }
  }

  Future<List<PopularService>> fetchCategories() async {
    try {
      debugPrint(
          'Popular services => GET ${AppApiService.baseUrl}/api/v1/popular-service/categories/');
      final response = await _apiService.get(
        path: '/api/v1/popular-service/categories/',
      );

      debugPrint('Popular services => status: ${response.statusCode}');
      debugPrint('Popular services => body: ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('Popular services API failed => ${response.statusCode}');
        return [];
      }

      final decoded = await compute(_decodeJson, response.body);
      final rawList = _extractList(decoded);
      final items = rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => PopularService.fromJson(e))
          .toList();

      if (items.isNotEmpty) {
        await saveCachedCategories(items);
      }

      return items;
    } catch (e) {
      debugPrint('Popular services API error => $e');
      return [];
    }
  }

  List<dynamic> _extractList(dynamic decoded) {
    if (decoded is List) return decoded;
    if (decoded is Map<String, dynamic>) {
      final candidates = <dynamic>[
        decoded['results'],
        decoded['data'],
        decoded['items']
      ];
      for (final c in candidates) {
        if (c is List) return c;
      }
      final nested = decoded['results'] ?? decoded['data'] ?? decoded['items'];
      if (nested is List) return nested;
    }
    return const [];
  }
}

// helper for background decoding
dynamic _decodeJson(String body) => jsonDecode(body);
