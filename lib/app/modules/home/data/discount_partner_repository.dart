import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../services/api_service.dart';
import '../models/discount_partner.dart';
import '../models/medical_accessory_category.dart';

class DiscountPartnerRepository {
  final AppApiService _apiService = AppApiService();

  Future<DiscountPartner?> fetchDiscountPartner() async {
    try {
      debugPrint('Discount Partner => GET ${AppApiService.baseUrl}/api/v1/package/collaborations/');
      final response = await _apiService.get(
        path: '/api/v1/package/collaborations/',
      );

      debugPrint('Discount Partner => status: ${response.statusCode}');
      debugPrint('Discount Partner => body: ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('DiscountPartner API failed => ${response.statusCode}');
        return null;
      }

      final decoded = await compute(_decodeJson, response.body);
      final rawList = _extractList(decoded);
      final DiscountPartner discountPartner = DiscountPartner.fromJson(decoded);

      /*return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => DiscountPartner.fromJson(e))
          .toList();*/
      return discountPartner;
    } catch (e) {
      debugPrint('DiscountPartner API error => $e');
      return null;
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