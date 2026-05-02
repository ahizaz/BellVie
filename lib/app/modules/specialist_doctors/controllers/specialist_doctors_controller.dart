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
    loadItems(categoryId: categoryId);
  }

  Future<void> loadItems({int? categoryId}) async {
    isLoading.value = true;
    showNoData.value = false;

    // If still loading after 4s and no items, show empty state
    Future.delayed(const Duration(seconds: 4), () {
      if (isLoading.value && items.isEmpty) {
        showNoData.value = true;
      }
    });

    try {
      final result =
          await _repository.fetchSubcategories(categoryId: categoryId);
      items.assignAll(result);
      if (items.isNotEmpty) showNoData.value = false;
      debugPrint('Subcategories loaded: ${result.length}');
    } catch (e) {
      debugPrint('Error loading subcategories => $e');
    } finally {
      isLoading.value = false;
    }
  }
}
