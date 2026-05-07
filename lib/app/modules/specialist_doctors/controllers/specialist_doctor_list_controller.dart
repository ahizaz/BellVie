import 'package:get/get.dart';

import '../data/specialist_doctors_repository.dart';
import '../models/specialist_doctor_item.dart';

class SpecialistDoctorListController extends GetxController {
  SpecialistDoctorListController(this._repository);

  final SpecialistDoctorsRepository _repository;

  final RxBool isLoading = false.obs;
  final RxList<SpecialistDoctorItem> doctors = <SpecialistDoctorItem>[].obs;
  final RxBool showNoData = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = false.obs;
  int _currentPage = 1;

  late final String categoryKey;
  late final String categoryLabel;
  late final String categoryAssetPath;
  late final int? categoryId;
  late final int? subcategoryId;

  @override
  void onInit() {
    super.onInit();
    final args = (Get.arguments as Map?) ?? {};
    categoryKey = (args['categoryKey'] ?? '').toString();
    categoryLabel = (args['categoryLabel'] ?? '').toString();
    categoryAssetPath = (args['categoryAssetPath'] ?? '').toString();
    // optional numeric ids passed from the subcategory card
    final rawCat = args['categoryId'];
    if (rawCat is int) {
      categoryId = rawCat;
    } else if (rawCat is String) {
      categoryId = int.tryParse(rawCat);
    } else {
      categoryId = null;
    }

    final rawSub = args['subcategoryId'];
    if (rawSub is int) {
      subcategoryId = rawSub;
    } else if (rawSub is String) {
      subcategoryId = int.tryParse(rawSub);
    } else {
      subcategoryId = null;
    }
    loadDoctors(reset: true);
  }

  Future<void> loadDoctors({bool reset = true}) async {
    if (reset) {
      _currentPage = 1;
      showNoData.value = false;
      isLoading.value = false;
    } else {
      // load more
      if (isLoading.value || isLoadingMore.value || !hasMore.value) return;
      isLoadingMore.value = true;
      _currentPage += 1;
    }

    try {
      final page = _currentPage;

      // Always try cache first (no loader shown)
      if (reset && doctors.isEmpty) {
        final cachedResult = await _repository.getDoctorsByCategory(
          categoryKey: categoryKey,
          categoryId: categoryId,
          subcategoryId: subcategoryId,
          page: page,
          useCache: true,
          categoryAssetPath: categoryAssetPath,
        );

        if (cachedResult.items.isNotEmpty) {
          doctors.assignAll(cachedResult.items);
          hasMore.value = cachedResult.hasNext;
          showNoData.value = false;
          // Cache found - use it, NO further API calls
          return;
        }
      }

      // Cache miss on first load - fetch from API silently and cache it
      if (reset && doctors.isEmpty) {
        final result = await _repository.getDoctorsByCategory(
          categoryKey: categoryKey,
          categoryId: categoryId,
          subcategoryId: subcategoryId,
          page: page,
          useCache: false,
          categoryAssetPath: categoryAssetPath,
        );

        if (result.items.isNotEmpty) {
          doctors.assignAll(result.items);
          hasMore.value = result.hasNext;
        } else {
          showNoData.value = true;
        }
        return;
      }

      // Load more (pagination)
      if (!reset) {
        final result = await _repository.getDoctorsByCategory(
          categoryKey: categoryKey,
          categoryId: categoryId,
          subcategoryId: subcategoryId,
          page: page,
          useCache: false,
          categoryAssetPath: categoryAssetPath,
        );

        doctors.addAll(result.items);
        hasMore.value = result.hasNext;
      }
    } finally {
      if (!reset) {
        isLoadingMore.value = false;
      }
    }
  }

  Future<void> loadMore() async => loadDoctors(reset: false);
}
