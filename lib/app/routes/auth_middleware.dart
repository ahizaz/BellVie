import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import 'app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route == Routes.LOGIN || route == Routes.SPLASH) {
      return null;
    }

    if (AuthService.to.authenticated) {
      return null;
    }

    return const RouteSettings(name: Routes.LOGIN);
  }
}
