import 'dart:convert';

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

  HospitalItem({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.area,
    required this.addressEn,
    required this.addressBn,
    required this.image,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_bn': nameBn,
      'area': area,
      'address_en': addressEn,
      'address_bn': addressBn,
      'image': image,
    };
  }
}

class HospitalPackageController extends GetxController {
  static const String _cacheKey = 'bangladesh_hospitals_cache_v2';

  static final List<HospitalItem> _memoryCache = [];
  static final List<HospitalItem> _allMemoryCache = [];
  static String? _memoryNextUrl;

  final hospitals = <HospitalItem>[].obs;
  final allHospitals = <HospitalItem>[].obs;

  final isLoading = false.obs;
  final isMoreLoading = false.obs;

  String? nextUrl;
  bool hasLoadedOnce = false;

  bool get hasMore {
    if (nextUrl != null && nextUrl!.isNotEmpty) return true;
    return hospitals.length < allHospitals.length;
  }

  bool get isBangla =>
      Get.find<HomeController>().currentLocale.value.languageCode == 'bn';

  @override
  void onInit() {
    super.onInit();
    loadInitialHospitals();
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
      if (!backgroundRefresh) {
        isLoading.value = true;
      }

      final url = Uri.parse(
        '${AppApiService.baseUrl}/api/v1/foreign-treatments/bangladesh-hospitals/?page_size=10',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final List list = body is List ? body : (body['results'] ?? []);
        nextUrl = body is Map ? body['next']?.toString() : null;

        final data = list.map((e) => HospitalItem.fromJson(e)).toList();

        if (nextUrl == null || nextUrl!.isEmpty) {
          allHospitals.assignAll(data);
          hospitals.assignAll(allHospitals.take(10).toList());
        } else {
          hospitals.assignAll(data);
          allHospitals.assignAll(data);
        }

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
    if (isMoreLoading.value) return;

    if (nextUrl == null || nextUrl!.isEmpty) {
      final nextItems = allHospitals.take(hospitals.length + 10).toList();
      hospitals.assignAll(nextItems);

      _memoryCache
        ..clear()
        ..addAll(hospitals);

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

        hospitals.addAll(newData);
        allHospitals.addAll(newData);

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

    final data = {
      'next': nextUrl,
      'items': hospitals.map((e) => e.toJson()).toList(),
      'all_items': allHospitals.map((e) => e.toJson()).toList(),
    };

    await prefs.setString(_cacheKey, jsonEncode(data));
  }

  Future<void> _loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);

    if (cached == null || cached.isEmpty) return;

    final body = jsonDecode(cached);

    nextUrl = body['next']?.toString();

    final List items = body['items'] ?? [];
    final List allItems = body['all_items'] ?? [];

    hospitals.assignAll(
      items.map((e) => HospitalItem.fromJson(e)).toList(),
    );

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