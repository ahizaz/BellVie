import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    currentLocale.value = Get.locale ?? const Locale('en', 'US');
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
