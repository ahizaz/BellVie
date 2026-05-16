import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../services/api_service.dart';
import '../models/special_doctor.dart';

class SpecialDoctorRepository {
  final AppApiService _apiService = AppApiService();

  Future<SpecialDoctor?> fetchSpecialDoctor() async {
    try {
      debugPrint('SpecialDoctor => GET ${AppApiService.baseUrl}api/v1/special-doctor/doctors/');
      final response = await _apiService.get(
        path: 'api/v1/special-doctor/doctors/',
      );

      debugPrint('SpecialDoctor => status: ${response.statusCode}');
      debugPrint('SpecialDoctor => body: ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('SpecialDoctor API failed => ${response.statusCode}');
        return null;
      }

      final decoded = await compute(_decodeJson, response.body);
      final rawList = _extractList(decoded);
      final SpecialDoctor specialDoctor = SpecialDoctor.fromJson(decoded);
      return specialDoctor;
    } catch (e) {
      debugPrint('SpecialDoctor API error => $e');
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