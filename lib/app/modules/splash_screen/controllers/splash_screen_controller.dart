import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashScreenController extends GetxController {
  bool _navigated = false;

  @override
  void onReady() {
    super.onReady();
    _scheduleAutoNavigate();
  }

  void _scheduleAutoNavigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (isClosed || _navigated) {
        return;
      }
      _navigated = true;
      Get.offAllNamed(Routes.HOME);
    });
  }
}
