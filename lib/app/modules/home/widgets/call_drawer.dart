import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

Future<void> showBelleVieCallDrawer(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const BelleVieCallDrawer(),
  );
}

class BelleVieCallDrawer extends StatelessWidget {
  const BelleVieCallDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'route': Routes.EMERGENCY_SERVICES,
        'image': 'assets/images/banners/Emergency_service_banner.jpg',
      },
      {
        'route': Routes.SPECIALIST_DOCTORS,
        'image': 'assets/images/banners/special_service_banner.jpg',
      },
      {
        'route': Routes.CONTACT_US,
        'image': 'assets/images/banners/call_us_need.jpg',
      },
    ];

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
            const SizedBox(height: 15),
            SizedBox(
              height: 84,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = items[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.toNamed(item['route'] as String);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        item['image'] as String,
                        fit: BoxFit.cover,
                        width: 180,
                        height: 84,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
