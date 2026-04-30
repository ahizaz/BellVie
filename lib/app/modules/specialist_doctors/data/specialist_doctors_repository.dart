import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../../services/app_loader.dart';

import '../../../services/api_service.dart';
import '../models/specialist_doctor_item.dart';

class SpecialistDoctorsRepository {
  static const String _defaultDoctorImage = 'assets/images/Doctor Services.png';
  final AppApiService _apiService = AppApiService();

  // static data removed — now fully remote-driven
  static final Map<String, List<SpecialistDoctorItem>>
      _staticDoctorsByCategory = {};

  Future<List<SpecialistDoctorItem>> getDoctorsByCategory({
    required String categoryKey,
    String? categoryAssetPath,
  }) async {
    final apiDoctors = await _fetchDoctorsFromApi(categoryKey);
    if (apiDoctors.isNotEmpty) {
      return apiDoctors;
    }

    final selected = _staticDoctorsByCategory[categoryKey];
    if (selected != null) {
      return selected;
    }

    // No static fallback doctors — return empty list so UI shows no items
    // when backend has no data for the requested category.
    return const [];
  }

  Future<List<SpecialistDoctorItem>> _fetchDoctorsFromApi(
      String categoryKey) async {
    if (categoryKey.trim().isEmpty) return const [];

    final encodedCategory = Uri.encodeQueryComponent(categoryKey.trim());
    final candidatePaths = <String>[
      '/api/v1/popular-service/doctors/',
      '/api/v1/specialist-doctors/?category=$encodedCategory',
      '/api/v1/specialist-doctors/?category_key=$encodedCategory',
      '/api/v1/specialist-doctors/$encodedCategory/',
      '/api/v1/doctors/?category=$encodedCategory',
      '/api/v1/doctors/specialist/?category=$encodedCategory',
    ];

    for (final path in candidatePaths) {
      try {
        final response = await _apiService.get(path: path);
        debugPrint(
            'Specialist doctors API ($path) status <= ${response.statusCode}');
        debugPrint(
            'Specialist doctors API ($path) response <= ${response.body}');

        if (response.statusCode == 404 || response.statusCode == 405) {
          continue;
        }

        if (response.statusCode < 200 || response.statusCode >= 300) {
          debugPrint('Specialist doctors API failed => ${response.statusCode}');
          return const [];
        }

        final parsed = await _parseDoctorsFromBody(response.body);
        if (parsed.isNotEmpty) {
          // try filtering by categoryKey (subcategory match)
          final filtered = _filterByCategory(parsed, categoryKey);
          if (filtered.isNotEmpty) return filtered;
          // no match in this parsed response — continue trying other endpoints
          debugPrint('No doctors matched subcategory "$categoryKey" in $path');
          continue;
        }
      } catch (e) {
        debugPrint('Specialist doctors API error => $e');
      }
    }

    return const [];
  }
  Future<List<SpecialistDoctorItem>> _parseDoctorsFromBody(String body) async {
    // offload JSON decoding to background isolate
    dynamic decoded;
    try {
      decoded = await compute(_decodeJson, body);
    } catch (_) {
      return const [];
    }

    final rawList = _extractList(decoded);
    if (rawList.isEmpty) return const [];

    return rawList
        .whereType<Map<String, dynamic>>()
        .map((item) {
          try {
            final base = SpecialistDoctorItem.fromJson(item);
            return SpecialistDoctorItem(
              id: base.id,
              name: base.name,
              designation: base.designation,
              imageAssetPath: _resolveImageUrl(base.imageAssetPath),
              hospitalName: base.hospitalName,
              subcategoryName: base.subcategoryName,
            );
          } catch (_) {
            return null;
          }
        })
        .whereType<SpecialistDoctorItem>()
        .where((doctor) => doctor.name.isNotEmpty)
        .toList();
  }

}

// top-level helper for compute
dynamic _decodeJson(String body) => jsonDecode(body);

  List<SpecialistDoctorItem> _filterByCategory(
      List<SpecialistDoctorItem> items, String categoryKey) {
    final key = _toKey(categoryKey);
    if (key.isEmpty) return items;
    final filtered =
        items.where((d) => _toKey(d.subcategoryName) == key).toList();
    return filtered;
  }

  String _toKey(String s) {
    return s
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-z0-9]+"), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .trim();
  }

  List<dynamic> _extractList(dynamic decoded) {
    if (decoded is List) {
      return decoded;
    }

    if (decoded is Map<String, dynamic>) {
      final candidates = <dynamic>[
        decoded['results'],
        decoded['data'],
        decoded['items'],
        decoded['doctors'],
      ];

      for (final candidate in candidates) {
        if (candidate is List) {
          return candidate;
        }
        if (candidate is Map<String, dynamic>) {
          final nested = candidate['results'] ??
              candidate['items'] ??
              candidate['doctors'];
          if (nested is List) {
            return nested;
          }
        }
      }
    }

    return const [];
  }

  String _resolveImageUrl(String value) {
    if (value.trim().isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return '${AppApiService.baseUrl}$value';
  }

