import 'package:get/get.dart';

import '../data/specialist_doctors_repository.dart';
import '../models/specialist_doctor_item.dart';

class SpecialistDoctorListController extends GetxController {
  SpecialistDoctorListController(this._repository);

  final SpecialistDoctorsRepository _repository;

  final RxBool isLoading = false.obs;
  final RxList<SpecialistDoctorItem> doctors = <SpecialistDoctorItem>[].obs;
  final RxBool showNoData = false.obs;

  late final String categoryKey;
  late final String categoryLabel;
  late final String categoryAssetPath;

  @override
  void onInit() {
    super.onInit();
    final args = (Get.arguments as Map?) ?? {};
    categoryKey = (args['categoryKey'] ?? '').toString();
    categoryLabel = (args['categoryLabel'] ?? '').toString();
    categoryAssetPath = (args['categoryAssetPath'] ?? '').toString();
    loadDoctors();
  }

  Future<void> loadDoctors() async {
    isLoading.value = true;
    showNoData.value = false;
    // Start a 2s fallback: if still loading after 2s and no doctors yet,
    // show the no-data message (but keep fetching; later results will update UI).
    Future.delayed(const Duration(seconds: 2), () {
      if (isLoading.value && doctors.isEmpty) {
        showNoData.value = true;
      }
    });

    try {
      final result = await _repository.getDoctorsByCategory(
        categoryKey: categoryKey,
        categoryAssetPath: categoryAssetPath,
      );
      doctors.assignAll(result);
      if (doctors.isNotEmpty) showNoData.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
