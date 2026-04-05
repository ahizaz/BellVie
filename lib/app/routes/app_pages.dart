import 'package:get/get.dart';

import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_views.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

import '../modules/foreign_treatment/bindings/foreign_treatment_binding.dart';
import '../modules/foreign_treatment/views/foreign_treatment_view.dart';

import '../modules/specialist_doctors/bindings/specialist_doctors_binding.dart';
import '../modules/specialist_doctors/views/specialist_doctors_view.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.FOREIGN_TREATMENT,
      page: () => const ForeignTreatmentView(),
      binding: ForeignTreatmentBinding(),
    ),
    GetPage(
      name: Routes.SPECIALIST_DOCTORS,
      page: () => const SpecialistDoctorsView(),
      binding: SpecialistDoctorsBinding(),
    ),
  ];
}
