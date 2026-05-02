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
      doctors.clear();
      hasMore.value = false;
      isLoading.value = true;
      showNoData.value = false;
    } else {
      // load more
      if (isLoading.value || isLoadingMore.value || !hasMore.value) return;
      isLoadingMore.value = true;
      _currentPage += 1;
    }

    // Start a 4s fallback: if still loading after 4s and no doctors yet,
    // show the no-data message (but keep fetching; later results will update UI).
    if (reset) {
      Future.delayed(const Duration(seconds: 4), () {
        if (isLoading.value && doctors.isEmpty) {
          showNoData.value = true;
        }
      });
    }

    try {
      final page = _currentPage;
      final result = await _repository.getDoctorsByCategory(
        categoryKey: categoryKey,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        page: page,
        categoryAssetPath: categoryAssetPath,
      );

      if (reset) {
        doctors.assignAll(result.items);
      } else {
        doctors.addAll(result.items);
      }

      hasMore.value = result.hasNext;
      if (doctors.isNotEmpty) showNoData.value = false;
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
