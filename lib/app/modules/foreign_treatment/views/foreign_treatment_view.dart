import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../home/controllers/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';

part '../widgets/shared_widgets.dart';
part '../widgets/foreign_treatment_home_widgets.dart';
part '../widgets/india_hospitals_widgets.dart';
part '../widgets/hospital_list_widgets.dart';

/// ===============================
/// FOREIGN TREATMENT (MAIN) PAGE
/// ===============================
class ForeignTreatmentView extends GetView<HomeController> {
  const ForeignTreatmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child:
                    _ForeignTreatmentTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

class _ForeignTreatmentTabBody extends StatelessWidget {
  final int index;
  const _ForeignTreatmentTabBody({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _ForeignTreatmentHome();
      case 1:
        return const _PlaceholderScreen(titleKey: 'my_appointments');
      case 2:
        return const _PlaceholderScreen(titleKey: 'my_health');
      case 3:
        return const _PlaceholderScreen(titleKey: 'cart');
      case 4:
        return const _PlaceholderScreen(titleKey: 'menu');
      default:
        return const SizedBox.shrink();
    }
  }
}

/// ===============================
/// INDIA HOSPITALS PAGE
/// ===============================
class IndiaHospitalsView extends GetView<HomeController> {
  final int countryId;
  final String countryTitle;

  const IndiaHospitalsView({
    super.key,
    required this.countryId,
    required this.countryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _IndiaHospitalsTabBody(
                  index: controller.tabIndex.value,
                  countryId: countryId,
                  countryTitle: countryTitle,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

/// ===============================
/// CHAINA HOSPITALS PAGE
/// ===============================
class ChainaHospitalsView extends GetView<HomeController> {
  const ChainaHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _BlankCountryTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

/// ===============================
/// THAILAND HOSPITALS PAGE
/// ===============================
class ThailandHospitalsView extends GetView<HomeController> {
  const ThailandHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _HospitalListTabBody(
                  index: controller.tabIndex.value,
                  hospitals: const [
                    'MedPark Hospital',
                    'Sukhumvit Hospital',
                    'Nakhonthon Hospital',
                    'Bangkok Hospital',
                    'Bumrungrad International Hospital',
                    'Samitivej Hospital',
                    'Vejthani Hospital',
                    'Phyathai 2 Hospital',
                    'Rutnin Eye Hospital',
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

/// ===============================
/// TURKEY HOSPITALS PAGE
/// ===============================
class TurkeyHospitalsView extends GetView<HomeController> {
  const TurkeyHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _BlankCountryTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

/// ===============================
/// SINGAPORE HOSPITALS PAGE
/// ===============================
class SingaporeHospitalsView extends GetView<HomeController> {
  const SingaporeHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _BlankCountryTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

/// ===============================
/// MALAYSIA HOSPITALS PAGE
/// ===============================
class MalaysiaHospitalsView extends GetView<HomeController> {
  const MalaysiaHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _HospitalListTabBody(
                  index: controller.tabIndex.value,
                  hospitals: const [
                    'Sunway Medical Centre Damansara',
                    'Revival Clinic',
                    'Primecare Clinic',
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}
