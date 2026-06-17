import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class EmergencyServicesCard extends StatelessWidget {
  const EmergencyServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cardSize = MediaQuery.of(context).size.width * 0.38; // square size
    const cardRadius = 6.0; // uniform rounded corners
    final iconSize = cardSize * 0.53;

    return InkWell(
      borderRadius: BorderRadius.circular(cardRadius),
      onTap: () => Get.toNamed(Routes.EMERGENCY_SERVICES),
      child: Container(
        width: cardSize,
        height: cardSize,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            
            Container(
              width: iconSize,
              height: iconSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                'assets/images/banners/emergency_service_final.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'emergency_services'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
