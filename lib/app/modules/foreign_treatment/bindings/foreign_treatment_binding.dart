import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class ForeignTreatmentBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure HomeController exists so the bottom navigation behaves the same.
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController());
    }
  }
}
