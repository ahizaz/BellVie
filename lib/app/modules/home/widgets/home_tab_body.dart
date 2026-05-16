import 'package:bellevie/app/modules/home/widgets/sections/discount_partner.dart';
import 'package:bellevie/app/modules/home/widgets/sections/promotion_banner.dart';
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
          SizedBox(height: 18),
          PopularServicesSection(),
          SizedBox(height: 28),
          GeneralPhysicianSection(),
          SizedBox(height: 28),
          TopDoctorsSection(),
          SizedBox(
            height: 28,
          ),
          //SizedBox(height: 18),
          ForeignTreatmentSection(),

          SizedBox(
            height: 18,
          ),
          PromotionBanner(),

          SizedBox(height: 18),
          SocialService(),
          SizedBox(
            height: 18,
          ),
          // Promo banner slider (temporary hold)
          // PromoBannerCarousel(),
          // SizedBox(height: 18),

          // GeneralPhysicianSection(),

          //TopDoctorsSection(),

          // CoreFourSection(),
          DiscountPartner(),
          SizedBox(
            height: 18,
          ),
          SubscriptionPackageSection(),
          SizedBox(
            height: 18,
          ),
          MedicalAccessoriesSection(),
        ],
      ),
    );
  }
}

class SubscriptionPackageSection extends StatelessWidget {
  const SubscriptionPackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Subscription package',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildPackageColumn(
              'Platinum',
              const Color(0xFFE5E4E2),
            ),
            _buildPackageColumn(
              'Gold',
              const Color(0xFFFFD700),
            ),
            _buildPackageColumn(
              'Silver',
              const Color(0xFFC0C0C0),
            ),
            _buildPackageColumn(
              'Green',
              const Color(0xFF4CAF50),
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildPackageColumn(
    String label,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          // Box container
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFBEE9FF),
                  Color(0xFFDFF8EF),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white24,
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33FFFFFF),
                  offset: Offset(-3, -3),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Color(0x22000000),
                  offset: Offset(3, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: .2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Text outside the box (single line, scale to fit)
          SizedBox(
            height: 40,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialService extends StatelessWidget {
  const SocialService({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Social Services',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // এটাকে start রাখলে ভালো দেখায়
          children: [
            _buildPackageColumn(
              'Community Health Services',
              'assets/images/community_health_srvice.png',
            ),
            _buildPackageColumn(
              'Bellevie Health Club',
              'assets/images/bellevie_logo.png',
            ),
            _buildPackageColumn(
              'Charity Partners',
              'assets/images/charity partners.png',
            ),
            _buildPackageColumn(
              'Health Tourism & Wellness Partners',
              'assets/images/healthcare.png',
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildPackageColumn(
    String label,
    String assetPath,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Box container
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFBEE9FF), Color(0xFFDFF8EF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33FFFFFF),
                  offset: Offset(-3, -3),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Color(0x22000000),
                  offset: Offset(3, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Container(
              height: 70, // একটু বাড়িয়ে দিলাম যাতে সুন্দর দেখায়
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    assetPath,
                    height: 42,
                    width: 42,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Label
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 15.5, // একটু ছোট করলে ভালো ফিট হয়
            ),
          ),
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
