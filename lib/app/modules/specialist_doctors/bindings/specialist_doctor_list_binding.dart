import 'package:get/get.dart';

import '../controllers/specialist_doctor_list_controller.dart';
import '../data/specialist_doctors_repository.dart';

class SpecialistDoctorListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecialistDoctorListController>(
      () => SpecialistDoctorListController(SpecialistDoctorsRepository()),
    );
  }
}
