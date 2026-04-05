import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<AuthService>(() async => AuthService().init());
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
