import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bellevie/app/services/app_loader.dart';

import '../data/subcategory_repository.dart';
import '../models/subcategory.dart';

class SpecialistDoctorsController extends GetxController {
  final SubcategoryRepository _repository;

  SpecialistDoctorsController({SubcategoryRepository? repository})
      : _repository = repository ?? SubcategoryRepository();

  final RxList<Subcategory> items = <Subcategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  Future<void> loadItems() async {
    try {
      AppLoader.show(status: 'Loading...');
      final result = await _repository.fetchSubcategories();
      items.assignAll(result);
      debugPrint('Subcategories loaded: ${result.length}');
    } catch (e) {
      debugPrint('Error loading subcategories => $e');
    } finally {
      AppLoader.dismiss();
    }
  }
}
