import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/responsive.dart';
import 'home_carousels.dart';
import 'home_sections.dart';

class HomeTabBody extends StatelessWidget {
  final int index;

  const HomeTabBody({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const HomeScrollContent();
      case 1:
        return _PlaceholderScreen(title: 'my_appointments');
      case 2:
        return _PlaceholderScreen(title: 'my_health');
      case 3:
        return _PlaceholderScreen(title: 'cart');
      case 4:
        return _PlaceholderScreen(title: 'menu');
      default:
        return const SizedBox.shrink();
    }
  }
}

class HomeScrollContent extends StatelessWidget {
  const HomeScrollContent({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.w(12);
    final topPadding = context.h(12);
    final bottomPadding = context.h(20);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        bottomPadding,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeBannerCarousel(),
          SizedBox(height: 14),
          EmergencyServicesCard(),
          SizedBox(height: 14),
          ContactUsCard(),
          SizedBox(height: 14),
          PopularServicesSection(),
          SizedBox(height: 18),
          PromoBannerCarousel(),
          SizedBox(height: 18),
          ForeignTreatmentSection(),
          SizedBox(height: 18),
          CoreFourSection(),
          SizedBox(height: 18),
          MedicalAccessoriesSection(),
        ],
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title.tr,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
