import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/specialist_doctors_controller.dart';

class SpecialistDoctorsBinding extends Bindings {
  @override
  void dependencies() {
    // Reuse HomeController so bottom navigation behaves exactly like Home.
    if (!Get.isRegistered<HomeController>()) {
      Get.put<HomeController>(HomeController());
    }
    if (!Get.isRegistered<SpecialistDoctorsController>()) {
      Get.put<SpecialistDoctorsController>(SpecialistDoctorsController());
    }
  }
}
