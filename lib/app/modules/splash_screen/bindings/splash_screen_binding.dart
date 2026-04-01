import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Eager init so timer runs on splash
    Get.put<SplashScreenController>(SplashScreenController());
  }
}

