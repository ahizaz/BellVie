import 'package:get/get.dart';

import '../data/specialist_doctors_repository.dart';
import '../models/specialist_doctor_item.dart';

class SpecialistDoctorListController extends GetxController {
  SpecialistDoctorListController(this._repository);

  final SpecialistDoctorsRepository _repository;

  final RxBool isLoading = false.obs;
  final RxList<SpecialistDoctorItem> doctors = <SpecialistDoctorItem>[].obs;

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
    try {
      final result = await _repository.getDoctorsByCategory(
        categoryKey: categoryKey,
        categoryAssetPath: categoryAssetPath,
      );
      doctors.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}
