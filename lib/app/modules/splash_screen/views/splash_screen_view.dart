import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is touched (extra safety)
    controller;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFD9F7E8),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return const Scaffold(
      backgroundColor: Color(0xFFD9F7E8),
      body: Center(
        child: Image(
          image: AssetImage('assets/images/Belle Vie Logo.png'),
          width: 210,
          height: 210,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
