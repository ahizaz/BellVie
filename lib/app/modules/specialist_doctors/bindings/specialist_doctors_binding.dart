import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class SpecialistDoctorsBinding extends Bindings {
  @override
  void dependencies() {
    // Reuse HomeController so bottom navigation behaves exactly like Home.
    if (!Get.isRegistered<HomeController>()) {
      Get.put<HomeController>(HomeController());
    }
  }
}
