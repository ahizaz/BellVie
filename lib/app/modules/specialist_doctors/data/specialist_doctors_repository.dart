import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../services/api_service.dart';
import '../models/specialist_doctor_item.dart';

class DoctorsPage {
  final List<SpecialistDoctorItem> items;
  final bool hasNext;
  final int count;
  const DoctorsPage(
      {required this.items, required this.hasNext, required this.count});
}

class SpecialistDoctorsRepository {
  final AppApiService _apiService = AppApiService();

  // static data removed — now fully remote-driven
  static final Map<String, List<SpecialistDoctorItem>>
      _staticDoctorsByCategory = {};

  /// Simple container for paginated doctor responses
  /// Use a const constructor so callers can return empty const values.
  static const DoctorsPage emptyPage =
      DoctorsPage(items: [], hasNext: false, count: 0);

  /// Result wrapper for paginated doctor responses
  /// - [items]: parsed list of doctors
  /// - [hasNext]: whether API returned a non-null `next` link
  /// - [count]: total count reported by API when available

  Future<DoctorsPage> getDoctorsByCategory({
    String? categoryKey,
    int? categoryId,
    int? subcategoryId,
    int page = 1,
    bool useCache = true,
    String? categoryAssetPath,
  }) async {
    if (useCache) {
      final cached = await _loadCachedDoctorsPage(
        categoryKey: categoryKey,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        page: page,
      );
      if (cached != null) {
        return cached;
      }
    }

    // If numeric ids are provided, prefer calling the popular-service doctors
    // endpoint with page/category/subcategory query params for exact results.
    if (categoryId != null && subcategoryId != null) {
      final encodedCategory = Uri.encodeQueryComponent(categoryId.toString());
      final encodedSub = Uri.encodeQueryComponent(subcategoryId.toString());
      final encodedPage = Uri.encodeQueryComponent(page.toString());
      final path =
          '/api/v1/popular-service/doctors/?page=$encodedPage&category=$encodedCategory&subcategory=$encodedSub';

      try {
        final response = await _apiService.get(path: path);
        debugPrint(
            'Specialist doctors direct API ($path) status <= ${response.statusCode}');
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final parsed = await _parseDoctorsPageFromBody(response.body);
          if (parsed.items.isNotEmpty || parsed.count > 0) return parsed;
        }
      } catch (e) {
        debugPrint('Direct specialist doctors API error => $e');
      }
      // if the direct call failed or returned empty, fall through to older
      // heuristics below so app still works with other backends.
    }

    // Backwards-compatible behavior: accept a string categoryKey and try
    // various legacy endpoints and static fallbacks.
    final key = (categoryKey ?? '').trim();
    if (key.isEmpty) {
      return emptyPage;
    }

    final apiDoctors = await _fetchDoctorsFromApi(categoryKey!);
    if (apiDoctors.isNotEmpty) {
      return DoctorsPage(
          items: apiDoctors, hasNext: false, count: apiDoctors.length);
    }

    final selected = _staticDoctorsByCategory[categoryKey];
    if (selected != null) {
      return DoctorsPage(
          items: selected, hasNext: false, count: selected.length);
    }

    return emptyPage;
  }

  Future<DoctorsPage?> _loadCachedDoctorsPage({
    String? categoryKey,
    int? categoryId,
    int? subcategoryId,
    required int page,
  }) async {
    final candidatePaths = _candidatePaths(
      categoryKey: categoryKey,
      categoryId: categoryId,
      subcategoryId: subcategoryId,
    );

    for (final path in candidatePaths) {
      try {
        final cachedBody = await _apiService.getCachedBody(
          path: _withPage(path, page),
        );
        if (cachedBody == null || cachedBody.isEmpty) {
          continue;
        }

        final parsed = await _parseDoctorsPageFromBody(cachedBody);
        if (parsed.items.isNotEmpty || parsed.count > 0) {
          debugPrint('Specialist doctors cache hit => $path');
          return parsed;
        }
      } catch (e) {
        debugPrint('Specialist doctors cache read error => $e');
      }
    }

    return null;
  }

  List<String> _candidatePaths({
    String? categoryKey,
    int? categoryId,
    int? subcategoryId,
  }) {
    if (categoryId != null && subcategoryId != null) {
      return [
        '/api/v1/popular-service/doctors/?category=${Uri.encodeQueryComponent(categoryId.toString())}&subcategory=${Uri.encodeQueryComponent(subcategoryId.toString())}',
      ];
    }

    final key = (categoryKey ?? '').trim();
    if (key.isEmpty) {
      return const [];
    }

    final encodedCategory = Uri.encodeQueryComponent(key);
    return [
      '/api/v1/popular-service/doctors/',
      '/api/v1/specialist-doctors/?category=$encodedCategory',
      '/api/v1/specialist-doctors/?category_key=$encodedCategory',
      '/api/v1/specialist-doctors/$encodedCategory/',
      '/api/v1/doctors/?category=$encodedCategory',
      '/api/v1/doctors/specialist/?category=$encodedCategory',
    ];
  }

  String _withPage(String path, int page) {
    final encodedPage = Uri.encodeQueryComponent(page.toString());
    if (path.contains('?')) {
      return '$path&page=$encodedPage';
    }
    return '$path?page=$encodedPage';
  }

  Future<DoctorsPage> _parseDoctorsPageFromBody(String body) async {
    dynamic decoded;
    try {
      decoded = await compute(_decodeJson, body);
    } catch (_) {
      return emptyPage;
    }

    final rawList = _extractList(decoded);
    final items = rawList
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

    bool hasNext = false;
    int count = items.length;
    if (decoded is Map<String, dynamic>) {
      final nextVal = decoded['next'];
      if (nextVal != null) hasNext = true;
      final c = decoded['count'];
      if (c is int) count = c;
    }

    return DoctorsPage(items: items, hasNext: hasNext, count: count);
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
        final fullPath = _withPage(path, 1);
        final response = await _apiService.get(path: fullPath);
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
        final nested =
            candidate['results'] ?? candidate['items'] ?? candidate['doctors'];
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
