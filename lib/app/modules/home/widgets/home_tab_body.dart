import 'package:bellevie/app/modules/home/widgets/sections/discount_partner.dart';
import 'package:bellevie/app/modules/home/widgets/sections/promotion_banner.dart';
import 'package:bellevie/app/modules/profile/controllers/profile_controller.dart';
import 'package:bellevie/app/modules/profile/views/profile_view.dart';
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
        // Show the ProfileView in the last tab
        Get.lazyPut<ProfileController>(() => ProfileController());
        return const ProfileView();
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
          SizedBox(height: 8),
          QuickActionsBar(),
          SizedBox(height: 12),
          Savour(),
          SizedBox(height: 12),

          PopularServicesSection(),
          SizedBox(height: 12),
          GeneralPhysicianSection(),
          SizedBox(height: 12),
          TopDoctorsSection(),
          SizedBox(
            height: 11,
          ),
          //SizedBox(height: 18),
          ForeignTreatmentSection(),

          SizedBox(
            height: 1,
          ),
          PromotionBanner(),

          SizedBox(height: 15),
          SocialService(),
          SizedBox(
            height: 12,
          ),
          // Promo banner slider (temporary hold)
          // PromoBannerCarousel(),
          // SizedBox(height: 18),

          // GeneralPhysicianSection(),

          //TopDoctorsSection(),

          // CoreFourSection(),
          DiscountPartner(),

          SubscriptionPackageSection(),
          SizedBox(
            height: 4,
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
        Text(
          'subscription_package'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildPackageColumn(
              'platinum'.tr,
              const Color(0xFF727474),
            ),
            _buildPackageColumn(
              'gold'.tr,
              const Color(0xFFB3882B),
            ),
            _buildPackageColumn(
              'silver'.tr,
              const Color(0xFFAAABB0),
            ),
            _buildPackageColumn(
              'bronze'.tr,
              const Color(0xFFB65F36),
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
        Text(
          'social_services'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPackageColumn(
              'community_health_services'.tr,
              'assets/images/community_health_srvice.png',
            ),
            _buildPackageColumn(
              'bellevie_health_club'.tr,
              'assets/images/bellevie_logo.png',
            ),
            _buildPackageColumn(
              'charity_partners'.tr,
              'assets/images/charity partners.png',
            ),
            _buildPackageColumn(
              'health_tourism'.tr,
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
            margin: const EdgeInsets.symmetric(horizontal: 4),
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  assetPath,
                  height: 55,
                  width: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.image_not_supported_rounded,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ],
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
              fontWeight: FontWeight.w700,
              fontSize: 10.7,
            ),
          ),
        ],
      ),
    );
  }
}

class Savour extends StatelessWidget {
  const Savour({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bellevie Health Saver Skims",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPackageColumn(
              'Freemium Package',
              'assets/images/banners/freemium.png',
            ),
            _buildPackageColumn(
              'Premium Package',
              'assets/images/banners/premium.png',
            ),
            _buildPackageColumn(
              'Subscribed Package',
              'assets/images/banners/subscription-package.png',
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
            margin: const EdgeInsets.symmetric(horizontal: 4),
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  assetPath,
                  height: 55,
                  width: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.image_not_supported_rounded,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ],
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
              fontWeight: FontWeight.w700,
              fontSize: 12,
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
            Text(
              'section_not_available_yet'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
              child: Text('home'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
