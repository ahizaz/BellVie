import 'package:bellevie/app/modules/auth/views/regester_views.dart';
import 'package:get/get.dart';

import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/onboarding/views/onboarding_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/auth/views/login_views.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/emergency_services/views/emergency_services_view.dart';
import '../modules/pathology_test/views/pathology_test_view.dart';
import '../modules/pathology_test/views/available_lab_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

import '../modules/foreign_treatment/bindings/foreign_treatment_binding.dart';
import '../modules/foreign_treatment/views/foreign_treatment_view.dart';
import '../modules/home/views/popular_services_view.dart';
import '../modules/social_services/views/social_services_list_view.dart';
import '../modules/social_services/views/social_service_detail_view.dart';

import '../modules/specialist_doctors/bindings/specialist_doctors_binding.dart';
import '../modules/specialist_doctors/bindings/specialist_doctor_list_binding.dart';
import '../modules/specialist_doctors/views/doctor_details_view.dart';
import '../modules/specialist_doctors/views/specialist_doctor_list_view.dart';
import '../modules/specialist_doctors/views/specialist_doctors_view.dart';
import '../modules/other_medical_service/bindings/categories_binding.dart';
import '../modules/other_medical_service/views/categories_view.dart';
import '../modules/common/views/coming_soon_view.dart';
import '../modules/appointments/views/book_appointment_view.dart';
import '../modules/appointments/views/doctor_booking_view.dart';
import '../modules/appointments/views/general_physician_booking_view.dart';
import '../modules/appointments/views/general_physician_payment_view.dart';
import '../modules/appointments/views/specialist_doctor_booking_view.dart';
import '../modules/appointments/views/specialist_doctor_payment_view.dart';
import '../modules/appointments/views/appointment_payment_view.dart';
import '../modules/appointments/views/appointment_list_view.dart';

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
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
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
    ),
    GetPage(
      name: Routes.EMERGENCY_SERVICES,
      page: () => const EmergencyServicesView(),
    ),
    GetPage(
      name: Routes.PATHOLOGY_TEST,
      page: () => const PathologyTestView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.AMAR_LAB,
      page: () => const AvailableLabView(),
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
      name: Routes.POPULAR_SERVICES,
      page: () => const PopularServicesView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.SOCIAL_SERVICES,
      page: () => const SocialServicesListView(),
    ),
    GetPage(
      name: Routes.SOCIAL_SERVICE_DETAIL,
      page: () => const SocialServiceDetailView(),
    ),
    GetPage(
      name: Routes.SPECIALIST_DOCTORS,
      page: () => const SpecialistDoctorsView(),
      binding: SpecialistDoctorsBinding(),
    ),
    GetPage(
      name: Routes.OTHER_MEDICAL_SERVICES,
      page: () => const OtherMedicalCategoriesView(),
      binding: OtherMedicalBinding(),
    ),
    GetPage(
      name: Routes.SPECIALIST_DOCTOR_LIST,
      page: () => const SpecialistDoctorListView(),
      binding: SpecialistDoctorListBinding(),
    ),
    GetPage(
      name: Routes.DOCTOR_DETAILS,
      page: () => const DoctorDetailsView(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.COMING_SOON,
      page: () => const ComingSoonView(),
      //middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.BOOK_APPOINTMENT,
      page: () => const BookAppointmentView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.DOCTOR_BOOKING,
      page: () => const DoctorBookingView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.GENERAL_PHYSICIAN_BOOKING,
      page: () => const GeneralPhysicianBookingView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.GENERAL_PHYSICIAN_PAYMENT,
      page: () => const GeneralPhysicianPaymentView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.SPECIALIST_DOCTOR_BOOKING,
      page: () => const SpecialistDoctorBookingView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.SPECIALIST_DOCTOR_PAYMENT,
      page: () => const SpecialistDoctorPaymentView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.APPOINTMENT_PAYMENT,
      page: () => const AppointmentPaymentView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/appointment-list',
      page: () => const AppointmentListView(),
    ),
  ];
}
