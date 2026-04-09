import 'package:bellevie/app/modules/auth/views/regester_views.dart';
import 'package:get/get.dart';

import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_views.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/emergency_services/views/emergency_services_view.dart';
import '../modules/pathology_test/views/pathology_test_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

import '../modules/foreign_treatment/bindings/foreign_treatment_binding.dart';
import '../modules/foreign_treatment/views/foreign_treatment_view.dart';

import '../modules/specialist_doctors/bindings/specialist_doctors_binding.dart';
import '../modules/specialist_doctors/views/specialist_doctors_view.dart';

import 'auth_middleware.dart';
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
      name: Routes.CONTACT_US,
      page: () => const ContactUsView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.EMERGENCY_SERVICES,
      page: () => const EmergencyServicesView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.PATHOLOGY_TEST,
      page: () => const PathologyTestView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.FOREIGN_TREATMENT,
      page: () => const ForeignTreatmentView(),
      binding: ForeignTreatmentBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.SPECIALIST_DOCTORS,
      page: () => const SpecialistDoctorsView(),
      binding: SpecialistDoctorsBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
  ];
}
