import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class EmergencyServicesCard extends StatelessWidget {
  const EmergencyServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height * 0.08;
    final cardRadius = 0.0; // square corners
    final iconSize =
        MediaQuery.of(context).size.width * 0.14; // slightly larger icon

    return InkWell(
      borderRadius: BorderRadius.zero,
      onTap: () => Get.toNamed(Routes.EMERGENCY_SERVICES),
      child: Container(
        height: cardHeight,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD6D6),
          borderRadius: BorderRadius.zero,
          border: Border.all(color: const Color(0xFFFFB3B3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                'assets/images/banners/emergency services.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'emergency_services'.tr,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
