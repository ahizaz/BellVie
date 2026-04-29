import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyServicesView extends StatelessWidget {
  const EmergencyServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD6D6),
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'emergency_services_screen'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE1E1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFB3B3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 8,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/banners/emergency services.png',
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'emergency_fast_response'.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'emergency_subtitle'.tr,
                          style: const TextStyle(
                            fontSize: 13.5,
                            height: 1.35,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'available_services'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const _EmergencyServiceTile(
              icon: Icons.local_taxi_rounded,
              titleKey: 'ambulance',
              subtitleKey: 'ambulance_subtitle',
            ),
            const SizedBox(height: 10),
            const _EmergencyServiceTile(
              icon: Icons.flight_takeoff_rounded,
              titleKey: 'air_ambulance',
              subtitleKey: 'air_ambulance_subtitle',
            ),
            const SizedBox(height: 10),
            const _EmergencyServiceTile(
              icon: Icons.monitor_heart_rounded,
              titleKey: 'icu_ambulance',
              subtitleKey: 'icu_ambulance_subtitle',
            ),
            const SizedBox(height: 10),
            const _EmergencyServiceTile(
              icon: Icons.person_pin_circle_rounded,
              titleKey: 'patient_transfer',
              subtitleKey: 'patient_transfer_subtitle',
            ),
            const SizedBox(height: 18),
            Text(
              'need_immediate_help'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E5E5)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'emergency_contact_guidance'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'emergency_call_instruction'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyServiceTile extends StatelessWidget {
  final IconData icon;
  final String titleKey;
  final String subtitleKey;

  const _EmergencyServiceTile({
    required this.icon,
    required this.titleKey,
    required this.subtitleKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD6D6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 22,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleKey.tr,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitleKey.tr,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
