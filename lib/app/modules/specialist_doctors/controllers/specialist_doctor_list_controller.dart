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
      isLoading.value = true;
      showNoData.value = false;
    } else {
      // load more
      if (isLoading.value || isLoadingMore.value || !hasMore.value) return;
      isLoadingMore.value = true;
      _currentPage += 1;
    }

    try {
      final page = _currentPage;
      bool loadedFromCache = false;

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
          loadedFromCache = true;
          isLoading.value = false; // Hide loader immediately after showing cached data
        }
      }

      // Fetch fresh data from API (or use cache if no fresh data needed)
      final result = await _repository.getDoctorsByCategory(
        categoryKey: categoryKey,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        page: page,
        useCache: false,
        categoryAssetPath: categoryAssetPath,
      );

      if (reset) {
        if (result.items.isNotEmpty) {
          doctors.assignAll(result.items);
        }
      } else {
        doctors.addAll(result.items);
      }

      hasMore.value = result.hasNext;
      if (reset) {
        showNoData.value = doctors.isEmpty;
      }
    } finally {
      if (reset) {
        isLoading.value = false;
      } else {
        isLoadingMore.value = false;
      }
    }
  }

  Future<void> loadMore() async => loadDoctors(reset: false);
}
