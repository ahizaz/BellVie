import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AuthService extends GetxService {
  final RxBool isLoggedIn = false.obs;

  bool get authenticated => isLoggedIn.value;

  static AuthService get to => Get.find<AuthService>();

  Future<AuthService> init() async {
    return this;
  }

  Future<void> login() async {
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    isLoggedIn.value = false;
  }

  bool requireLogin() {
    if (authenticated) {
      return true;
    }

    Get.toNamed(Routes.LOGIN);
    return false;
  }
}
