import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    currentLocale.value = Get.locale ?? const Locale('en', 'US');
    // If the Home route was opened with a `tab` query parameter or argument,
    // initialize the tab index accordingly (used for redirect-after-login).
    try {
      final tabParam = Get.parameters['tab'] ??
          (Get.arguments is Map
              ? (Get.arguments as Map)['tab']?.toString()
              : null);
      if (tabParam != null && tabParam.isNotEmpty) {
        final parsed = int.tryParse(tabParam);
        if (parsed != null) {
          tabIndex.value = parsed;
        }
      }
    } catch (_) {
      // ignore parameter parsing errors
    }
  }

  bool changeTab(int index) {
    tabIndex.value = index;
    return true;
  }

  void changeLanguage(Locale locale) {
    currentLocale.value = locale;
    Get.updateLocale(locale);
  }
}
