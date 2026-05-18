import 'package:flutter/material.dart';

import 'package:bellevie/app/services/api_service.dart';

class PopularService {
  final int id;
  final String name; // original name field (fallback)
  final String nameEn;
  final String nameBn;
  final String iconUrl;

  PopularService({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.nameBn,
    required this.iconUrl,
  });

  factory PopularService.fromJson(Map<String, dynamic> json) {
    final rawIcon = (json['icon'] ?? '').toString();
    final resolvedIcon = _resolveImageUrl(rawIcon);
    final idVal = json['id'];
    final id = idVal is int ? idVal : int.tryParse(idVal?.toString() ?? '') ?? 0;

    final rawName = (json['name'] ?? '').toString().trim();
    final rawNameEn = (json['name_en'] ?? rawName).toString().trim();
    final rawNameBn = (json['name_bn'] ?? '').toString().trim();

    return PopularService(
      id: id,
      name: rawName,
      nameEn: rawNameEn,
      nameBn: rawNameBn,
      iconUrl: resolvedIcon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_en': nameEn,
      'name_bn': nameBn,
      'icon': iconUrl,
    };
  }

  String localizedName(Locale? locale) {
    final lang = locale?.languageCode ?? 'en';
    if (lang == 'bn' && nameBn.isNotEmpty) return nameBn;
    if (nameEn.isNotEmpty) return nameEn;
    return name;
  }

  static String _resolveImageUrl(String value) {
    if (value.trim().isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return '${AppApiService.baseUrl}$value';
  }
}
