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

  factory HospitalItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HospitalItem(
      id: _parseInt(json['id']),
      nameEn: (
        json['name_en'] ??
        json['name'] ??
        ''
      ).toString(),
      nameBn: (
        json['name_bn'] ??
        json['name'] ??
        ''
      ).toString(),
      area: (
        json['area'] ??
        ''
      ).toString(),
      addressEn: (
        json['address_en'] ??
        json['address'] ??
        ''
      ).toString(),
      addressBn: (
        json['address_bn'] ??
        json['address'] ??
        ''
      ).toString(),
      image: (
        json['image'] ??
        ''
      ).toString(),
      district: _nestedName(
        json['district'],
      ),
      division: _nestedName(
        json['division'],
      ),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static String _nestedName(dynamic value) {
    if (value is Map<String, dynamic>) {
      return (
        value['name'] ??
        value['name_en'] ??
        ''
      ).toString();
    }

    if (value is Map) {
      return (
        value['name'] ??
        value['name_en'] ??
        ''
      ).toString();
    }

    return (value ?? '').toString();
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
      'district': {
        'name': district,
      },
      'division': {
        'name': division,
      },
    };
  }
}

class HospitalDetails {
  final int id;
  final String nameEn;
  final String nameBn;
  final String image;
  final String area;
  final String addressEn;
  final String addressBn;
  final String facilitiesEn;
  final String facilitiesBn;
  final String contactDetailsEn;
  final String contactDetailsBn;
  final String remarkEn;
  final String remarkBn;

  HospitalDetails({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.image,
    required this.area,
    required this.addressEn,
    required this.addressBn,
    required this.facilitiesEn,
    required this.facilitiesBn,
    required this.contactDetailsEn,
    required this.contactDetailsBn,
    required this.remarkEn,
    required this.remarkBn,
  });

  factory HospitalDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    return HospitalDetails(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(
                json['id']?.toString() ?? '',
              ) ??
              0,
      nameEn: (
        json['name_en'] ??
        json['name'] ??
        ''
      ).toString(),
      nameBn: (
        json['name_bn'] ??
        json['name'] ??
        ''
      ).toString(),
      image: (
        json['image'] ??
        ''
      ).toString(),
      area: (
        json['area'] ??
        ''
      ).toString(),
      addressEn: (
        json['address_en'] ??
        json['address'] ??
        ''
      ).toString(),
      addressBn: (
        json['address_bn'] ??
        json['address'] ??
        ''
      ).toString(),
      facilitiesEn: (
        json['facilities_en'] ??
        json['facilities'] ??
        ''
      ).toString(),
      facilitiesBn: (
        json['facilities_bn'] ??
        json['facilities'] ??
        ''
      ).toString(),
      contactDetailsEn: (
        json['contact_details_en'] ??
        json['contact_details'] ??
        ''
      ).toString(),
      contactDetailsBn: (
        json['contact_details_bn'] ??
        json['contact_details'] ??
        ''
      ).toString(),
      remarkEn: (
        json['remark_en'] ??
        json['remark'] ??
        ''
      ).toString(),
      remarkBn: (
        json['remark_bn'] ??
        json['remark'] ??
        ''
      ).toString(),
    );
  }
}

class HospitalPackageController extends GetxController {
  static const String _cacheKey =
      'bangladesh_hospitals_cache_v7';

  /*
   * International hospital API পাওয়া গেলে এখানে path বসাবে।
   *
   * Example:
   *
   * static const String _internationalHospitalApiPath =
   *     '/api/v1/foreign-treatments/international-hospitals/'
   *     '?page_size=30';
   */
  static const String _internationalHospitalApiPath = '';

  static final List<HospitalItem> _memoryCache = [];
  static final List<HospitalItem> _allMemoryCache = [];

  final TextEditingController searchCtrl =
      TextEditingController();

  final hospitals = <HospitalItem>[].obs;
  final allHospitals = <HospitalItem>[].obs;
  final internationalHospitals = <HospitalItem>[].obs;

  final isLoading = false.obs;
  final isInternationalLoading = false.obs;

  final searchText = ''.obs;

  final selectedDistrict = ''.obs;
  final selectedDivision = ''.obs;

  final isInternational = false.obs;

  bool hasLoadedOnce = false;

  bool get isSearching {
    return searchText.value.trim().isNotEmpty;
  }

  bool get hasFilter {
    return selectedDistrict.value.isNotEmpty ||
        selectedDivision.value.isNotEmpty;
  }

  bool get isBangla {
    return Get.find<HomeController>()
            .currentLocale
            .value
            .languageCode ==
        'bn';
  }

  List<String> get districts {
    final list = allHospitals
        .map(
          (hospital) => hospital.district.trim(),
        )
        .where(
          (district) => district.isNotEmpty,
        )
        .toSet()
        .toList();

    list.sort(
      (a, b) => a.toLowerCase().compareTo(
            b.toLowerCase(),
          ),
    );

    return list;
  }

  List<String> get divisions {
    final list = allHospitals
        .map(
          (hospital) => hospital.division.trim(),
        )
        .where(
          (division) => division.isNotEmpty,
        )
        .toSet()
        .toList();

    list.sort(
      (a, b) => a.toLowerCase().compareTo(
            b.toLowerCase(),
          ),
    );

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

    if (isInternational.value) {
      _applyInternationalSearch();
    } else {
      _applyBangladeshSearch();
    }
  }

  void selectDistrict(String value) {
    if (isInternational.value) {
      return;
    }

    selectedDistrict.value = value;
    selectedDivision.value = '';

    _applyBangladeshSearch();
  }

  void selectDivision(String value) {
    if (isInternational.value) {
      return;
    }

    selectedDivision.value = value;
    selectedDistrict.value = '';

    _applyBangladeshSearch();
  }

  void selectNational() {
    if (!isInternational.value) {
      return;
    }

    isInternational.value = false;

    selectedDistrict.value = '';
    selectedDivision.value = '';

    searchCtrl.clear();
    searchText.value = '';

    _applyBangladeshSearch();
  }

  Future<void> selectInternational() async {
    if (isInternational.value) {
      return;
    }

    isInternational.value = true;

    selectedDistrict.value = '';
    selectedDivision.value = '';

    searchCtrl.clear();
    searchText.value = '';

    if (internationalHospitals.isNotEmpty) {
      _applyInternationalSearch();
    } else {
      hospitals.clear();
      await fetchInternationalHospitals();
    }
  }

  void clearFilter() {
    selectedDistrict.value = '';
    selectedDivision.value = '';

    searchCtrl.clear();
    searchText.value = '';

    if (isInternational.value) {
      _applyInternationalSearch();
    } else {
      _applyBangladeshSearch();
    }
  }

  void _applyBangladeshSearch() {
    final String query =
        searchText.value.trim().toLowerCase();

    final filtered = allHospitals.where(
      (item) {
        final bool districtMatch =
            selectedDistrict.value.isEmpty ||
            item.district ==
                selectedDistrict.value;

        final bool divisionMatch =
            selectedDivision.value.isEmpty ||
            item.division ==
                selectedDivision.value;

        final bool searchMatch =
            query.isEmpty ||
            item.nameEn.toLowerCase().contains(query) ||
            item.nameBn.toLowerCase().contains(query) ||
            item.area.toLowerCase().contains(query) ||
            item.addressEn.toLowerCase().contains(query) ||
            item.addressBn.toLowerCase().contains(query) ||
            item.district.toLowerCase().contains(query) ||
            item.division.toLowerCase().contains(query);

        return districtMatch &&
            divisionMatch &&
            searchMatch;
      },
    ).toList();

    _sortHospitals(filtered);

    if (query.isEmpty && !hasFilter) {
      hospitals.assignAll(
        filtered.take(30).toList(),
      );
    } else {
      hospitals.assignAll(filtered);
    }
  }

  void _applyInternationalSearch() {
    final String query =
        searchText.value.trim().toLowerCase();

    final filtered = internationalHospitals.where(
      (item) {
        return query.isEmpty ||
            item.nameEn.toLowerCase().contains(query) ||
            item.nameBn.toLowerCase().contains(query) ||
            item.area.toLowerCase().contains(query) ||
            item.addressEn.toLowerCase().contains(query) ||
            item.addressBn.toLowerCase().contains(query) ||
            item.district.toLowerCase().contains(query) ||
            item.division.toLowerCase().contains(query);
      },
    ).toList();

    _sortHospitals(filtered);

    if (query.isEmpty) {
      hospitals.assignAll(
        filtered.take(30).toList(),
      );
    } else {
      hospitals.assignAll(filtered);
    }
  }

  void _sortHospitals(
    List<HospitalItem> hospitalList,
  ) {
    hospitalList.sort(
      (a, b) {
        final String aName =
            isBangla ? a.nameBn : a.nameEn;

        final String bName =
            isBangla ? b.nameBn : b.nameEn;

        return aName.toLowerCase().compareTo(
              bName.toLowerCase(),
            );
      },
    );
  }

  Future<void> loadInitialHospitals() async {
    if (hasLoadedOnce) {
      return;
    }

    hasLoadedOnce = true;

    if (_memoryCache.isNotEmpty) {
      allHospitals.assignAll(_allMemoryCache);
      hospitals.assignAll(
        _memoryCache.take(30).toList(),
      );
      return;
    }

    await _loadCache();

    if (allHospitals.isEmpty) {
      await fetchHospitals();
    } else {
      _applyBangladeshSearch();

      fetchHospitals(
        backgroundRefresh: true,
      );
    }
  }

  Future<void> fetchHospitals({
    bool backgroundRefresh = false,
  }) async {
    try {
      if (!backgroundRefresh) {
        isLoading.value = true;
      }

      final url = Uri.parse(
        '${AppApiService.baseUrl}'
        '/api/v1/foreign-treatments/'
        'bangladesh-hospitals/?page_size=30',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(
          response.body,
        );

        final List<dynamic> list =
            _extractResultList(body);

        final List<HospitalItem> data =
            _mapHospitalList(list);

        allHospitals.assignAll(data);

        if (!isInternational.value) {
          _applyBangladeshSearch();
        }

        _memoryCache
          ..clear()
          ..addAll(data.take(30));

        _allMemoryCache
          ..clear()
          ..addAll(data);

        await _saveCache();
      } else {
        debugPrint(
          'Bangladesh hospital API error: '
          '${response.statusCode}',
        );
      }
    } catch (error) {
      debugPrint(
        'Bangladesh hospital fetching error: $error',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchInternationalHospitals() async {
    if (_internationalHospitalApiPath.trim().isEmpty) {
      internationalHospitals.clear();

      if (isInternational.value) {
        hospitals.clear();
      }

      return;
    }

    try {
      isInternationalLoading.value = true;

      final url = Uri.parse(
        '${AppApiService.baseUrl}'
        '$_internationalHospitalApiPath',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(
          response.body,
        );

        final List<dynamic> list =
            _extractResultList(body);

        final List<HospitalItem> data =
            _mapHospitalList(list);

        internationalHospitals.assignAll(data);

        if (isInternational.value) {
          _applyInternationalSearch();
        }
      } else {
        internationalHospitals.clear();

        if (isInternational.value) {
          hospitals.clear();
        }

        debugPrint(
          'International hospital API error: '
          '${response.statusCode}',
        );
      }
    } catch (error) {
      internationalHospitals.clear();

      if (isInternational.value) {
        hospitals.clear();
      }

      debugPrint(
        'International hospital fetching error: $error',
      );
    } finally {
      isInternationalLoading.value = false;
    }
  }

  List<dynamic> _extractResultList(
    dynamic body,
  ) {
    if (body is List) {
      return body;
    }

    if (body is Map &&
        body['results'] is List) {
      return body['results'] as List;
    }

    if (body is Map &&
        body['data'] is List) {
      return body['data'] as List;
    }

    if (body is Map &&
        body['items'] is List) {
      return body['items'] as List;
    }

    return [];
  }

  List<HospitalItem> _mapHospitalList(
    List<dynamic> list,
  ) {
    return list
        .whereType<Map>()
        .map(
          (item) => HospitalItem.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }

  Future<void> _saveCache() async {
    try {
      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
        _cacheKey,
        jsonEncode({
          'items': allHospitals
              .take(30)
              .map(
                (hospital) => hospital.toJson(),
              )
              .toList(),
          'all_items': allHospitals
              .map(
                (hospital) => hospital.toJson(),
              )
              .toList(),
        }),
      );
    } catch (error) {
      debugPrint(
        'Hospital cache saving error: $error',
      );
    }
  }

  Future<void> _loadCache() async {
    try {
      final prefs =
          await SharedPreferences.getInstance();

      final String? cached =
          prefs.getString(_cacheKey);

      if (cached == null || cached.isEmpty) {
        return;
      }

      final dynamic body = jsonDecode(cached);

      if (body is! Map) {
        return;
      }

      final List<dynamic> items =
          body['items'] is List
              ? body['items'] as List
              : [];

      final List<dynamic> allItems =
          body['all_items'] is List
              ? body['all_items'] as List
              : [];

      final List<HospitalItem> cachedHospitals =
          _mapHospitalList(items);

      final List<HospitalItem> cachedAllHospitals =
          _mapHospitalList(allItems);

      if (cachedAllHospitals.isNotEmpty) {
        allHospitals.assignAll(
          cachedAllHospitals,
        );
      } else {
        allHospitals.assignAll(
          cachedHospitals,
        );
      }

      hospitals.assignAll(
        allHospitals.take(30).toList(),
      );

      _memoryCache
        ..clear()
        ..addAll(
          hospitals,
        );

      _allMemoryCache
        ..clear()
        ..addAll(
          allHospitals,
        );
    } catch (error) {
      debugPrint(
        'Hospital cache loading error: $error',
      );
    }
  }
}

class HospitalDetailsController extends GetxController {
  final int hospitalId;

  HospitalDetailsController({
    required this.hospitalId,
  });

  final isLoading = false.obs;

  final hospitalDetails =
      Rxn<HospitalDetails>();

  bool get isBangla {
    return Get.find<HomeController>()
            .currentLocale
            .value
            .languageCode ==
        'bn';
  }

  @override
  void onInit() {
    super.onInit();
    fetchHospitalDetails();
  }

  Future<void> fetchHospitalDetails() async {
    try {
      isLoading.value = true;

      final url = Uri.parse(
        '${AppApiService.baseUrl}'
        '/api/v1/foreign-treatments/'
        'bangladesh-hospitals/$hospitalId/',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(
          response.body,
        );

        if (body is Map) {
          hospitalDetails.value =
              HospitalDetails.fromJson(
            Map<String, dynamic>.from(body),
          );
        }
      } else {
        debugPrint(
          'Hospital details API error: '
          '${response.statusCode}',
        );
      }
    } catch (error) {
      debugPrint(
        'Hospital details fetching error: $error',
      );
    } finally {
      isLoading.value = false;
    }
  }
  
}