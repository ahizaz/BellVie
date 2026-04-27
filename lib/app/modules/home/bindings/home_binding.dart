import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../other_medical_service/controllers/categories_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.lazyPut<OtherMedicalController>(() => OtherMedicalController());
  }
}
