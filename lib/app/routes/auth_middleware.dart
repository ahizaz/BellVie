import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import 'app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!AuthService.to.authenticated) {
      AuthService.to.setPendingRedirect(route);
      return RouteSettings(
        name: Routes.LOGIN,
      );
    }
    return null;
  }
}
