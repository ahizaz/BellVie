import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app/localization/app_translation.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Keep image cache bounded to avoid memory spikes on lower-end devices.
  PaintingBinding.instance.imageCache.maximumSize = 120;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 120 << 20;
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
      title: 'app_title'.tr,
      translations: AppTranslation(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BD'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) => child!,
    );
  }
}
