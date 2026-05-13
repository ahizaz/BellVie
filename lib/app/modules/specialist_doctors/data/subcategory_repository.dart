import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../models/subcategory.dart';

class SubcategoryRepository {
  final AppApiService _apiService = AppApiService();

  static const String _cachePrefix = 'popular_service_subcategories_cache_v1_';
  static const String _hiddenSubcategoryName = 'General Physician';

  String _cacheKey(int? categoryId) {
    return '$_cachePrefix${categoryId?.toString() ?? 'all'}';
  }

  Future<List<Subcategory>> loadCachedSubcategories({int? categoryId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey(categoryId));

      if (cachedJson == null || cachedJson.isEmpty) {
        return [];
      }

      final decoded = jsonDecode(cachedJson);
      if (decoded is! List) {
        return [];
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map((e) => Subcategory.fromJson(e))
          .where((item) => !_shouldHide(item))
          .toList();
    } catch (e) {
      debugPrint('Subcategories cache read error => $e');
      return [];
    }
  }

  Future<void> saveCachedSubcategories(
    List<Subcategory> items, {
    int? categoryId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final visibleItems = items.where((item) => !_shouldHide(item)).toList();
      final encoded = jsonEncode(visibleItems.map((e) => e.toJson()).toList());
      await prefs.setString(_cacheKey(categoryId), encoded);
    } catch (e) {
      debugPrint('Subcategories cache write error => $e');
    }
  }

  Future<List<Subcategory>> fetchSubcategories({int? categoryId}) async {
    try {
      // build path with optional category query param
      var path = '/api/v1/popular-service/subcategories/';
      if (categoryId != null) {
        final encoded = Uri.encodeQueryComponent(categoryId.toString());
        path = '/api/v1/popular-service/subcategories/?category=$encoded';
      }

      final response = await _apiService.get(path: path);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('Subcategories API failed => ${response.statusCode}');
        return [];
      }

      // offload JSON decode to background isolate
      final decoded =
          await compute((String body) => jsonDecode(body), response.body);
      final rawList = _extractList(decoded);
      final items = rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => Subcategory.fromJson(e))
          .where((item) => !_shouldHide(item))
          .toList();

      if (items.isNotEmpty) {
        await saveCachedSubcategories(items, categoryId: categoryId);
      }

      return items;
    } catch (e) {
      debugPrint('Subcategories API error => $e');
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

  bool _shouldHide(Subcategory item) {
    return item.name.trim().toLowerCase() ==
        _hiddenSubcategoryName.toLowerCase();
  }
}
