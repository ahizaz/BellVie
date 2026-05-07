import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/home_tab_body.dart';
import '../widgets/home_top_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  void _onBottomNavTap(BuildContext context, int index) {
    if (index == 2) {
      _showCallDrawer(context);
      return;
    }
    controller.changeTab(index);
  }

  void _showCallDrawer(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const _CallDrawer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.currentLocale.value;
      final activeIndex =
          controller.tabIndex.value == 2 ? 0 : controller.tabIndex.value;
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (activeIndex == 0) const HomeTopBar(),
              Expanded(child: HomeTabBody(index: activeIndex)),
            ],
          ),
        ),
        bottomNavigationBar: HomeBottomNav(
          currentIndex: activeIndex,
          onTap: (index) => _onBottomNavTap(context, index),
        ),
      );
    });
  }
}

class _CallDrawer extends StatelessWidget {
  const _CallDrawer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCFD8E2),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Your Urgent Need',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF13A0BE),
              ),
            ),
            const SizedBox(height: 12),
            _CallDrawerCard(
              title: 'Emergency Doctor',
              subtitle: 'Get urgent medical support quickly.',
              icon: Icons.emergency_rounded,
              iconBg: const Color(0xFFEAF4FF),
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(Routes.EMERGENCY_SERVICES);
              },
            ),
            const SizedBox(height: 10),
            _CallDrawerCard(
              title: 'Special Doctor',
              subtitle: 'Connect with specialist consultation.',
              icon: Icons.medical_services_rounded,
              iconBg: const Color(0xFFEAFBF7),
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(Routes.SPECIALIST_DOCTORS);
              },
            ),
            const SizedBox(height: 10),
            _CallDrawerCard(
              title: 'Call Us For Other Need',
              subtitle: 'Reach BelleVie support for any other help.',
              icon: Icons.call_rounded,
              iconBg: const Color(0xFFFFF3EA),
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(Routes.CONTACT_US);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CallDrawerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final VoidCallback onTap;

  const _CallDrawerCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF5F8FC),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF2C6CB8),
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF8693A2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
