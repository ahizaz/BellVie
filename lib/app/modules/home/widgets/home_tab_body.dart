import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/responsive.dart';
import '../../../routes/app_routes.dart';
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
        return const _PlaceholderScreen(title: 'my_appointments');
      case 2:
        return const _PlaceholderScreen(title: 'my_health');
      case 3:
        return const _PlaceholderScreen(title: 'records');
      case 4:
        return const _PlaceholderScreen(title: 'menu');
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
          QuickActionsBar(),
          SizedBox(height: 14),
          PopularServicesSection(),
          SizedBox(height: 18),
          // Promo banner slider (temporary hold)
          // PromoBannerCarousel(),
          // SizedBox(height: 18),
          ForeignTreatmentSection(),
          SizedBox(height: 18),
          GeneralPhysicianSection(),
          SizedBox(height: 18),
          TopDoctorsSection(),
          SizedBox(height: 18),
          // CoreFourSection(),
          // SizedBox(height: 18),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              size: 52,
              color: Color(0xFF2F6FED),
            ),
            const SizedBox(height: 12),
            Text(
              title.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'This section is not available yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F6FED),
                foregroundColor: Colors.white,
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
