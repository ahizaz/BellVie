import 'package:get/get.dart';
import '../controllers/categories_controller.dart';

class OtherMedicalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherMedicalController>(() => OtherMedicalController());
  }
}
