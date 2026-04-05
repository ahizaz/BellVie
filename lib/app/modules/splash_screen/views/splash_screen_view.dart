import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';
import '../../../theme/responsive.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is touched (extra safety)
    controller;
    final logoSize = context.w(210).clamp(150.0, 240.0).toDouble();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFD9F7E8),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFD9F7E8),
      body: Center(
        child: Image(
          image: const AssetImage('assets/images/Belle Vie Logo.png'),
          width: logoSize,
          height: logoSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
