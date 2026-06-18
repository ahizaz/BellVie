
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/subcategory_repository.dart';
import '../models/subcategory.dart';

class SpecialistDoctorsController extends GetxController {
  final SubcategoryRepository _repository;

  SpecialistDoctorsController({SubcategoryRepository? repository})
      : _repository = repository ?? SubcategoryRepository();

  final RxList<Subcategory> items = <Subcategory>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool showNoData = false.obs;

  @override
  void onInit() {
    super.onInit();
    // read optional navigation arguments for category filtering
    final args = Get.arguments;
    int? categoryId;
    if (args is Map<String, dynamic>) {
      final raw = args['categoryId'];
      if (raw is int) categoryId = raw;
      if (raw is String) categoryId = int.tryParse(raw);
    }

    final memoryCached =
        _repository.loadCachedSubcategoriesSync(categoryId: categoryId);
    if (memoryCached.isNotEmpty) {
      items.assignAll(memoryCached);
      showNoData.value = false;
    }

    loadItems(categoryId: categoryId);
  }

  Future<void> loadItems({int? categoryId}) async {
    showNoData.value = false;
    final startedAt = DateTime.now();
    var loadedFromCache = false;

    try {
      final cached =
          await _repository.loadCachedSubcategories(categoryId: categoryId);
      if (cached.isNotEmpty) {
        items.assignAll(cached);
        debugPrint('Subcategories loaded from cache: ${items.length}');
        loadedFromCache = true;
        isLoading.value = false;
        showNoData.value = false;
        _refreshItemsFromApi(categoryId: categoryId);
        return;
      }

      isLoading.value = true;

      final result =
          await _repository.fetchSubcategories(categoryId: categoryId);
      if (result.isNotEmpty) {
        items.assignAll(result);
      }

      debugPrint('Subcategories loaded: ${items.length}');
    } catch (e) {
      debugPrint('Error loading subcategories => $e');
    } finally {
      if (!loadedFromCache) {
        final elapsed = DateTime.now().difference(startedAt);
        final remaining = const Duration(seconds: 3) - elapsed;
        if (!remaining.isNegative) {
          await Future.delayed(remaining);
        }
      }

      isLoading.value = false;
      if (items.isEmpty) {
        showNoData.value = true;
      }
    }
  }

  Future<void> _refreshItemsFromApi({int? categoryId}) async {
    try {
      final result = await _repository.fetchSubcategories(categoryId: categoryId);
      if (result.isNotEmpty) {
        items.assignAll(result);
        showNoData.value = false;
      }
    } catch (e) {
      debugPrint('Subcategories refresh error => $e');
    }
  }
}