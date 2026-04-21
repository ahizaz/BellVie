import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';
import '../models/specialist_doctor_item.dart';

class SpecialistDoctorsRepository {
  static const String _defaultDoctorImage = 'assets/images/Doctor Services.png';
  final AppApiService _apiService = AppApiService();

  static final Map<String, List<SpecialistDoctorItem>>
      _staticDoctorsByCategory = {
    'internal_medicine': const [
      SpecialistDoctorItem(
        id: 'internal-3',
        name: 'Dr. Sumaiya Nowsheen Khan Panthoi',
        designation: 'Medicine (PGT) Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'internal-4',
        name: 'Dr MD.ABU HASNAN RUBEL',
        designation: 'Medicine Specialist',
        imageAssetPath: '',
      ),
    ],
    'general_physician': const [
      SpecialistDoctorItem(
        id: 'gp-1',
        name: 'Dr. Avishek Chakraborty',
        designation: 'MBBS',
        imageAssetPath: '',
      ),
    ],
    'neuromedicine': const [],
    'gastroenterology': const [],
    'urology': const [
      SpecialistDoctorItem(
        id: 'urology-1',
        name: 'Dr MD.Abdullah Alamin Shohan',
        designation: 'Urology Specialist',
        imageAssetPath: 'assets/images/drsohan.jpeg',
      ),
      SpecialistDoctorItem(
        id: 'urology-2',
        name: 'Dr MD.Ishtiaqul haque Mortuza',
        designation: 'Urology Specialist',
        imageAssetPath: 'assets/images/mortazadr.jpeg',
      ),
      SpecialistDoctorItem(
        id: 'urology-3',
        name: 'Dr.Shafiqur Rahman',
        designation: 'Urology Specialist',
        imageAssetPath: '',
      ),
    ],
    'oncology': const [
      SpecialistDoctorItem(
        id: 'onc-1',
        name: 'Dr MD.Rassell',
        designation: 'Surgical Oncology Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'onc-2',
        name: 'Dr K.M.Sakib',
        designation: 'MS (Surgical Oncology) Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'onc-3',
        name: 'Prof.Dr.Md.Khorshed Alam',
        designation: 'Oncology Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'onc-4',
        name: 'Dr Altaf Hossain',
        designation: 'Clinical Oncology Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'onc-5',
        name: 'Dr Rifat Zia Hossain',
        designation: 'Oncology Specialist',
        imageAssetPath: '',
      ),
    ],
    'radio_therapy': const [
      SpecialistDoctorItem(
        id: 'rt-1',
        name: 'Dr Md.Waheed Akhtar',
        designation: 'Radiotherapy specialist',
        imageAssetPath: '',
      ),
    ],
    'rheumatology': const [],
    'cardiology': const [],
    'family_medicine': const [],
    'endocrinology': const [],
    'gynaecology_and_obstetrics': const [
      SpecialistDoctorItem(
        id: 'gyn-1',
        name: 'Dr. Sanjida Rezwana',
        designation: 'Gyn Specialist',
        imageAssetPath: '',
      ),
    ],
    'oral_and_maxillofacial_surgery': const [
      SpecialistDoctorItem(
        id: 'oms-1',
        name: 'Dr. Mausumi Iqbal',
        designation: 'Oral & Maxillofacial Surgery Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'oms-2',
        name: 'Dr Mezbah ul Azeez',
        designation: 'Periodontology Specialist',
        imageAssetPath: 'assets/images/drmezbah.jpeg',
      ),
    ],
  };

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

    final fallbackImage =
        (categoryAssetPath != null && categoryAssetPath.isNotEmpty)
            ? categoryAssetPath
            : _defaultDoctorImage;

    return [
      SpecialistDoctorItem(
        id: '$categoryKey-1',
        name: 'Dr. Ahsan Karim',
        designation: 'Consultant Specialist',
        imageAssetPath: fallbackImage,
      ),
      SpecialistDoctorItem(
        id: '$categoryKey-2',
        name: 'Dr. Nusrat Jahan',
        designation: 'Associate Consultant',
        imageAssetPath: fallbackImage,
      ),
    ];
  }

  Future<List<SpecialistDoctorItem>> _fetchDoctorsFromApi(
      String categoryKey) async {
    if (categoryKey.trim().isEmpty) return const [];

    final token = AuthService.to.accessToken.value.trim();
    final headers = <String, String>{
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    final encodedCategory = Uri.encodeQueryComponent(categoryKey.trim());
    final candidatePaths = <String>[
      '/api/v1/specialist-doctors/?category=$encodedCategory',
      '/api/v1/specialist-doctors/?category_key=$encodedCategory',
      '/api/v1/specialist-doctors/$encodedCategory/',
      '/api/v1/doctors/?category=$encodedCategory',
      '/api/v1/doctors/specialist/?category=$encodedCategory',
    ];

    for (final path in candidatePaths) {
      try {
        final response = await _apiService.get(path: path, headers: headers);
        if (response.statusCode == 404 || response.statusCode == 405) {
          continue;
        }

        if (response.statusCode < 200 || response.statusCode >= 300) {
          debugPrint('Specialist doctors API failed => ${response.statusCode}');
          return const [];
        }

        final parsed = _parseDoctorsFromBody(response.body);
        if (parsed.isNotEmpty) {
          return parsed;
        }
      } catch (e) {
        debugPrint('Specialist doctors API error => $e');
      }
    }

    return const [];
  }

  List<SpecialistDoctorItem> _parseDoctorsFromBody(String body) {
    dynamic decoded;
    try {
      decoded = jsonDecode(body);
    } catch (_) {
      return const [];
    }

    final rawList = _extractList(decoded);
    if (rawList.isEmpty) return const [];

    return rawList
        .whereType<Map<String, dynamic>>()
        .map((item) => SpecialistDoctorItem(
              id: (item['id'] ?? item['uuid'] ?? '').toString(),
              name:
                  (item['name'] ?? item['doctor_name'] ?? '').toString().trim(),
              designation: (item['designation'] ??
                      item['speciality'] ??
                      item['title'] ??
                      '')
                  .toString()
                  .trim(),
              imageAssetPath: _resolveImageUrl(
                (item['image'] ??
                        item['profile_picture'] ??
                        item['profile_image'] ??
                        item['avatar'] ??
                        item['photo'] ??
                        '')
                    .toString(),
              ),
            ))
        .where((doctor) => doctor.name.isNotEmpty)
        .toList();
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
}
