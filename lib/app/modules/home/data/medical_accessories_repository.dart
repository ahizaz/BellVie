import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../services/api_service.dart';
import '../models/discount_partner.dart';
import '../models/medical_accessory_category.dart';

class MedicalAccessoriesRepository {
  final AppApiService _apiService = AppApiService();

  Future<List<MedicalAccessoryCategory>> fetchCategories() async {
    try {
      debugPrint(
          'Medical accessories => GET ${AppApiService.baseUrl}/api/v1/medical-accessories/categories/');
      final response = await _apiService.get(
        path: '/api/v1/medical-accessories/categories/',
      );

      debugPrint('Medical accessories => status: ${response.statusCode}');
      debugPrint('Medical accessories => body: ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('Medical accessories API failed => ${response.statusCode}');
        return [];
      }

      final decoded = await compute(_decodeJson, response.body);
      final rawList = _extractList(decoded);
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => MedicalAccessoryCategory.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Medical accessories API error => $e');
      return [];
    }
  }

  Future<List<Object>> fetchDiscountPartner() async {
    try {
      debugPrint('Discount Partner => GET ${AppApiService.baseUrl}/api/v1/package/collaborations/');
      final response = await _apiService.get(
        path: '/api/v1/package/collaborations/',
      );

      debugPrint('Discount Partner => status: ${response.statusCode}');
      debugPrint('Discount Partner => body: ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('DiscountPartner API failed => ${response.statusCode}');
        return [];
      }

      final decoded = await compute(_decodeJson, response.body);
      debugPrint('Discount Partner => decoded: $decoded');
      final rawList = _extractList(decoded);
      debugPrint('Discount Partner => rawList: ${rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => DiscountPartner.fromJson(e))
          .toList()}');
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => DiscountPartner.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('DiscountPartner API error => $e');
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
