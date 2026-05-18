import 'package:flutter/material.dart';

class Subcategory {
  final int id;
  final int? category;
  final String name; // original / fallback name
  final String nameEn;
  final String nameBn;
  final String? icon;

  Subcategory({
    required this.id,
    this.category,
    required this.name,
    required this.nameEn,
    required this.nameBn,
    this.icon,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    final rawName = (json['name'] ?? '').toString();
    final rawNameEn = (json['name_en'] ?? rawName).toString();
    final rawNameBn = (json['name_bn'] ?? '').toString();

    return Subcategory(
      id: (json['id'] ?? 0) as int,
      category: json['category'] is int ? json['category'] as int : null,
      name: rawName,
      nameEn: rawNameEn,
      nameBn: rawNameBn,
      icon: json['icon']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'name_en': nameEn,
      'name_bn': nameBn,
      'icon': icon,
    };
  }

  String localizedName(Locale? locale) {
    final lang = locale?.languageCode ?? 'en';
    if (lang == 'bn' && nameBn.trim().isNotEmpty) return nameBn.trim();
    if (nameEn.trim().isNotEmpty) return nameEn.trim();
    return name.trim();
  }
}
