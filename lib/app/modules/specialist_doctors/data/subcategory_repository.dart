import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../services/api_service.dart';
import '../models/subcategory.dart';

class SubcategoryRepository {
  final AppApiService _apiService = AppApiService();

  Future<List<Subcategory>> fetchSubcategories() async {
    try {
      final response = await _apiService.get(
        path: '/api/v1/popular-service/subcategories/',
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('Subcategories API failed => ${response.statusCode}');
        return [];
      }

      final decoded = jsonDecode(response.body);
      final rawList = _extractList(decoded);
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => Subcategory.fromJson(e))
          .toList();
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
      for (final c in candidates) if (c is List) return c;
      final nested = decoded['results'] ?? decoded['data'] ?? decoded['items'];
      if (nested is List) return nested;
    }
    return const [];
  }
}
