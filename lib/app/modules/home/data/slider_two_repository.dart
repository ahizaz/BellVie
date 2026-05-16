import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../services/api_service.dart';
import '../models/discount_partner.dart';
import '../models/medical_accessory_category.dart';
import '../models/slider_two.dart';

class SliderTwoRepository {
  final AppApiService _apiService = AppApiService();

  Future<SliderTwo?> fetchSliderTwo() async {
    try {
      debugPrint('slider-two => GET ${AppApiService.baseUrl}/api/v1/slider/slider-two/');
      final response = await _apiService.get(
        path: '/api/v1/slider/slider-two/',
      );

      debugPrint('slider-two => status: ${response.statusCode}');
      debugPrint('slider-two => body: ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('slider-two API failed => ${response.statusCode}');
        return null;
      }

      final decoded = await compute(_decodeJson, response.body);
      final rawList = _extractList(decoded);
      final SliderTwo sliderTwo = SliderTwo.fromJson(decoded);
      return sliderTwo;
    } catch (e) {
      debugPrint('slider-two API error => $e');
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