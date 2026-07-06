// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../services/api_service.dart';
// import '../../home/controllers/home_controller.dart';

// class HospitalItem {
//   final int id;
//   final String nameEn;
//   final String nameBn;
//   final String area;
//   final String addressEn;
//   final String addressBn;
//   final String image;

//   HospitalItem({
//     required this.id,
//     required this.nameEn,
//     required this.nameBn,
//     required this.area,
//     required this.addressEn,
//     required this.addressBn,
//     required this.image,
//   });

//   factory HospitalItem.fromJson(Map<String, dynamic> json) {
//     return HospitalItem(
//       id: json['id'] ?? 0,
//       nameEn: (json['name_en'] ?? json['name'] ?? '').toString(),
//       nameBn: (json['name_bn'] ?? json['name'] ?? '').toString(),
//       area: (json['area'] ?? '').toString(),
//       addressEn: (json['address_en'] ?? json['address'] ?? '').toString(),
//       addressBn: (json['address_bn'] ?? json['address'] ?? '').toString(),
//       image: (json['image'] ?? '').toString(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name_en': nameEn,
//         'name_bn': nameBn,
//         'area': area,
//         'address_en': addressEn,
//         'address_bn': addressBn,
//         'image': image,
//       };
// }

// class HospitalPackageController extends GetxController {
//   static const String _cacheKey = 'bangladesh_hospitals_cache_v3';

//   static final List<HospitalItem> _memoryCache = [];
//   static final List<HospitalItem> _allMemoryCache = [];
//   static String? _memoryNextUrl;

//   final searchCtrl = TextEditingController();

//   final hospitals = <HospitalItem>[].obs;
//   final allHospitals = <HospitalItem>[].obs;

//   final isLoading = false.obs;
//   final isMoreLoading = false.obs;
//   final searchText = ''.obs;

//   String? nextUrl;
//   bool hasLoadedOnce = false;

//   bool get isSearching => searchText.value.trim().isNotEmpty;

//   bool get hasMore {
//     if (isSearching) return false;
//     if (nextUrl != null && nextUrl!.isNotEmpty) return true;
//     return hospitals.length < allHospitals.length;
//   }

//   bool get isBangla =>
//       Get.find<HomeController>().currentLocale.value.languageCode == 'bn';

//   @override
//   void onInit() {
//     super.onInit();
//     loadInitialHospitals();
//   }

//   @override
//   void onClose() {
//     searchCtrl.dispose();
//     super.onClose();
//   }

//   void onSearchChanged(String value) {
//     searchText.value = value.trim();
//     _applySearch();
//   }

//   void _applySearch() {
//     final query = searchText.value.toLowerCase();

//     if (query.isEmpty) {
//       hospitals.assignAll(allHospitals.take(10).toList());
//       return;
//     }

//     final matched = allHospitals.where((item) {
//       final nameEn = item.nameEn.toLowerCase();
//       final nameBn = item.nameBn.toLowerCase();
//       final area = item.area.toLowerCase();
//       final addressEn = item.addressEn.toLowerCase();
//       final addressBn = item.addressBn.toLowerCase();

//       return nameEn.contains(query) ||
//           nameBn.contains(query) ||
//           area.contains(query) ||
//           addressEn.contains(query) ||
//           addressBn.contains(query);
//     }).toList();

//     matched.sort((a, b) {
//       final aName = isBangla ? a.nameBn : a.nameEn;
//       final bName = isBangla ? b.nameBn : b.nameEn;

//       final aStarts = aName.toLowerCase().startsWith(query);
//       final bStarts = bName.toLowerCase().startsWith(query);

//       if (aStarts && !bStarts) return -1;
//       if (!aStarts && bStarts) return 1;

//       return aName.toLowerCase().compareTo(bName.toLowerCase());
//     });

//     hospitals.assignAll(matched);
//   }

//   Future<void> loadInitialHospitals() async {
//     if (hasLoadedOnce) return;
//     hasLoadedOnce = true;

//     if (_memoryCache.isNotEmpty) {
//       hospitals.assignAll(_memoryCache);
//       allHospitals.assignAll(_allMemoryCache);
//       nextUrl = _memoryNextUrl;
//       return;
//     }

//     await _loadCache();

//     if (hospitals.isEmpty) {
//       await fetchHospitals();
//     } else {
//       fetchHospitals(backgroundRefresh: true);
//     }
//   }

//   Future<void> fetchHospitals({bool backgroundRefresh = false}) async {
//     try {
//       if (!backgroundRefresh) isLoading.value = true;

//       final url = Uri.parse(
//         '${AppApiService.baseUrl}/api/v1/foreign-treatments/bangladesh-hospitals/?page_size=10',
//       );

//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final body = jsonDecode(response.body);
//         final List list = body is List ? body : (body['results'] ?? []);

//         nextUrl = body is Map ? body['next']?.toString() : null;

//         final data = list.map((e) => HospitalItem.fromJson(e)).toList();

//         if (nextUrl == null || nextUrl!.isEmpty) {
//           allHospitals.assignAll(data);
//         } else {
//           allHospitals.assignAll(data);
//         }

//         _applySearch();

//         _memoryCache
//           ..clear()
//           ..addAll(hospitals);

//         _allMemoryCache
//           ..clear()
//           ..addAll(allHospitals);

//         _memoryNextUrl = nextUrl;

//         await _saveCache();
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> loadMoreHospitals() async {
//     if (isMoreLoading.value || !hasMore) return;

//     if (nextUrl == null || nextUrl!.isEmpty) {
//       hospitals.assignAll(allHospitals.take(hospitals.length + 10).toList());
//       await _saveCache();
//       return;
//     }

//     try {
//       isMoreLoading.value = true;

//       final response = await http.get(Uri.parse(nextUrl!));

//       if (response.statusCode == 200) {
//         final body = jsonDecode(response.body);
//         final List list = body is List ? body : (body['results'] ?? []);

//         nextUrl = body is Map ? body['next']?.toString() : null;

//         final newData = list.map((e) => HospitalItem.fromJson(e)).toList();

//         allHospitals.addAll(newData);
//         _applySearch();

//         _memoryCache
//           ..clear()
//           ..addAll(hospitals);

//         _allMemoryCache
//           ..clear()
//           ..addAll(allHospitals);

//         _memoryNextUrl = nextUrl;

//         await _saveCache();
//       }
//     } finally {
//       isMoreLoading.value = false;
//     }
//   }

//   Future<void> _saveCache() async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setString(
//       _cacheKey,
//       jsonEncode({
//         'next': nextUrl,
//         'items': hospitals.map((e) => e.toJson()).toList(),
//         'all_items': allHospitals.map((e) => e.toJson()).toList(),
//       }),
//     );
//   }

//   Future<void> _loadCache() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cached = prefs.getString(_cacheKey);

//     if (cached == null || cached.isEmpty) return;

//     final body = jsonDecode(cached);

//     nextUrl = body['next']?.toString();

//     final List items = body['items'] ?? [];
//     final List allItems = body['all_items'] ?? [];

//     hospitals.assignAll(items.map((e) => HospitalItem.fromJson(e)).toList());
//     allHospitals.assignAll(allItems.map((e) => HospitalItem.fromJson(e)).toList());

//     _memoryCache
//       ..clear()
//       ..addAll(hospitals);

//     _allMemoryCache
//       ..clear()
//       ..addAll(allHospitals);

//     _memoryNextUrl = nextUrl;
//   }
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../home/controllers/home_controller.dart';

class HospitalItem {
  final int id;
  final String nameEn;
  final String nameBn;
  final String area;
  final String addressEn;
  final String addressBn;
  final String image;
  final String district;
  final String division;

  HospitalItem({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.area,
    required this.addressEn,
    required this.addressBn,
    required this.image,
    required this.district,
    required this.division,
  });

  factory HospitalItem.fromJson(Map<String, dynamic> json) {
    return HospitalItem(
      id: json['id'] ?? 0,
      nameEn: (json['name_en'] ?? json['name'] ?? '').toString(),
      nameBn: (json['name_bn'] ?? json['name'] ?? '').toString(),
      area: (json['area'] ?? '').toString(),
      addressEn: (json['address_en'] ?? json['address'] ?? '').toString(),
      addressBn: (json['address_bn'] ?? json['address'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      district: (json['district']?['name'] ?? '').toString(),
      division: (json['division']?['name'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_en': nameEn,
        'name_bn': nameBn,
        'area': area,
        'address_en': addressEn,
        'address_bn': addressBn,
        'image': image,
        'district': {'name': district},
        'division': {'name': division},
      };
}

class HospitalPackageController extends GetxController {
  static const String _cacheKey = 'bangladesh_hospitals_cache_v4';

  static final List<HospitalItem> _memoryCache = [];
  static final List<HospitalItem> _allMemoryCache = [];
  static String? _memoryNextUrl;

  final searchCtrl = TextEditingController();

  final hospitals = <HospitalItem>[].obs;
  final allHospitals = <HospitalItem>[].obs;

  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final searchText = ''.obs;

  final selectedDistrict = ''.obs;
  final selectedDivision = ''.obs;

  String? nextUrl;
  bool hasLoadedOnce = false;

  bool get isSearching => searchText.value.trim().isNotEmpty;

  bool get hasFilter =>
      selectedDistrict.value.isNotEmpty || selectedDivision.value.isNotEmpty;

  bool get hasMore {
    if (isSearching || hasFilter) return false;
    if (nextUrl != null && nextUrl!.isNotEmpty) return true;
    return hospitals.length < allHospitals.length;
  }

  bool get isBangla =>
      Get.find<HomeController>().currentLocale.value.languageCode == 'bn';

  List<String> get districts {
    final list = allHospitals
        .map((e) => e.district)
        .where((e) => e.trim().isNotEmpty)
        .toSet()
        .toList();
    list.sort();
    return list;
  }

  List<String> get divisions {
    final list = allHospitals
        .map((e) => e.division)
        .where((e) => e.trim().isNotEmpty)
        .toSet()
        .toList();
    list.sort();
    return list;
  }

  @override
  void onInit() {
    super.onInit();
    loadInitialHospitals();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }

  void onSearchChanged(String value) {
    searchText.value = value.trim();
    _applySearch();
  }

  void selectDistrict(String value) {
    selectedDistrict.value = value;
    selectedDivision.value = '';
    _applySearch();
  }

  void selectDivision(String value) {
    selectedDivision.value = value;
    selectedDistrict.value = '';
    _applySearch();
  }

  void clearFilter() {
    selectedDistrict.value = '';
    selectedDivision.value = '';
    _applySearch();
  }

  void _applySearch() {
    final query = searchText.value.toLowerCase();

    final filtered = allHospitals.where((item) {
      final districtMatch = selectedDistrict.value.isEmpty ||
          item.district == selectedDistrict.value;

      final divisionMatch = selectedDivision.value.isEmpty ||
          item.division == selectedDivision.value;

      final nameEn = item.nameEn.toLowerCase();
      final nameBn = item.nameBn.toLowerCase();
      final area = item.area.toLowerCase();
      final addressEn = item.addressEn.toLowerCase();
      final addressBn = item.addressBn.toLowerCase();
      final district = item.district.toLowerCase();
      final division = item.division.toLowerCase();

      final searchMatch = query.isEmpty ||
          nameEn.contains(query) ||
          nameBn.contains(query) ||
          area.contains(query) ||
          addressEn.contains(query) ||
          addressBn.contains(query) ||
          district.contains(query) ||
          division.contains(query);

      return districtMatch && divisionMatch && searchMatch;
    }).toList();

    filtered.sort((a, b) {
      final aName = isBangla ? a.nameBn : a.nameEn;
      final bName = isBangla ? b.nameBn : b.nameEn;
      return aName.toLowerCase().compareTo(bName.toLowerCase());
    });

    if (query.isEmpty && !hasFilter) {
      hospitals.assignAll(filtered.take(10).toList());
    } else {
      hospitals.assignAll(filtered);
    }
  }

  Future<void> loadInitialHospitals() async {
    if (hasLoadedOnce) return;
    hasLoadedOnce = true;

    if (_memoryCache.isNotEmpty) {
      hospitals.assignAll(_memoryCache);
      allHospitals.assignAll(_allMemoryCache);
      nextUrl = _memoryNextUrl;
      return;
    }

    await _loadCache();

    if (hospitals.isEmpty) {
      await fetchHospitals();
    } else {
      fetchHospitals(backgroundRefresh: true);
    }
  }

  Future<void> fetchHospitals({bool backgroundRefresh = false}) async {
    try {
      if (!backgroundRefresh) isLoading.value = true;

      final url = Uri.parse(
        '${AppApiService.baseUrl}/api/v1/foreign-treatments/bangladesh-hospitals/?page_size=10',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List list = body is List ? body : (body['results'] ?? []);

        nextUrl = body is Map ? body['next']?.toString() : null;

        final data = list.map((e) => HospitalItem.fromJson(e)).toList();

        allHospitals.assignAll(data);

        _applySearch();

        _memoryCache
          ..clear()
          ..addAll(hospitals);

        _allMemoryCache
          ..clear()
          ..addAll(allHospitals);

        _memoryNextUrl = nextUrl;

        await _saveCache();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreHospitals() async {
    if (isMoreLoading.value || !hasMore) return;

    if (nextUrl == null || nextUrl!.isEmpty) {
      hospitals.assignAll(allHospitals.take(hospitals.length + 10).toList());
      await _saveCache();
      return;
    }

    try {
      isMoreLoading.value = true;

      final response = await http.get(Uri.parse(nextUrl!));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List list = body is List ? body : (body['results'] ?? []);

        nextUrl = body is Map ? body['next']?.toString() : null;

        final newData = list.map((e) => HospitalItem.fromJson(e)).toList();

        allHospitals.addAll(newData);

        _applySearch();

        _memoryCache
          ..clear()
          ..addAll(hospitals);

        _allMemoryCache
          ..clear()
          ..addAll(allHospitals);

        _memoryNextUrl = nextUrl;

        await _saveCache();
      }
    } finally {
      isMoreLoading.value = false;
    }
  }

  Future<void> _saveCache() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _cacheKey,
      jsonEncode({
        'next': nextUrl,
        'items': hospitals.map((e) => e.toJson()).toList(),
        'all_items': allHospitals.map((e) => e.toJson()).toList(),
      }),
    );
  }

  Future<void> _loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);

    if (cached == null || cached.isEmpty) return;

    final body = jsonDecode(cached);

    nextUrl = body['next']?.toString();

    final List items = body['items'] ?? [];
    final List allItems = body['all_items'] ?? [];

    hospitals.assignAll(items.map((e) => HospitalItem.fromJson(e)).toList());
    allHospitals.assignAll(
      allItems.map((e) => HospitalItem.fromJson(e)).toList(),
    );

    _memoryCache
      ..clear()
      ..addAll(hospitals);

    _allMemoryCache
      ..clear()
      ..addAll(allHospitals);

    _memoryNextUrl = nextUrl;
  }
}