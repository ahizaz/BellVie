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
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient (no circular overlays)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF8CC9F5),
                  Color(0xFF6EB5EE),
                  Color(0xFF5BA6E8),
                ],
              ),
            ),
          ),
          // (overlay removed so background image shows clearly)
          // Center logo + text
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Belle Vie Logo.png',
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                Text(
                  'brand_name'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'app_tagline'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
