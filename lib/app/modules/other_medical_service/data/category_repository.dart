import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../services/api_service.dart';
import '../models/category.dart';

class OtherMedicalRepository {
  final AppApiService _apiService = AppApiService();

  Future<List<OtherMedicalCategory>> fetchCategories() async {
    try {
      final response = await _apiService.get(
        path: '/api/v1/other-medical-service/categories/',
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint(
            'Other medical categories API failed => ${response.statusCode}');
        return [];
      }

      final decoded = jsonDecode(response.body);
      final rawList = _extractList(decoded);
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => OtherMedicalCategory.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Other medical categories API error => $e');
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
