import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashScreenController extends GetxController {
  /// Navigate to the home route when user taps the Get Started button.
  void goToHome() {
    Get.offAllNamed(Routes.HOME);
  }
}
