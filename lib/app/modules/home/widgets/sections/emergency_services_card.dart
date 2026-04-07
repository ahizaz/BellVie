import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class EmergencyServicesCard extends StatelessWidget {
  const EmergencyServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cardRadius = MediaQuery.of(context).size.width * 0.045;
    final iconSize = MediaQuery.of(context).size.width * 0.14;

    return InkWell(
      borderRadius: BorderRadius.circular(cardRadius),
      onTap: () => Get.toNamed(Routes.EMERGENCY_SERVICES),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD6D6),
          borderRadius: BorderRadius.circular(cardRadius),
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
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/images/Emergency.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'emergency_services'.tr,
                style: TextStyle(
                  fontSize: 14.5,
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
