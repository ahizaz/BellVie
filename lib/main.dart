import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const BelleVieApp());
}

class BelleVieApp extends StatelessWidget {
  const BelleVieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      title: 'Belle vie',
      builder: EasyLoading.init(),
    );
  }
}
