
import 'package:bellevie/app/localization/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremiumPlanDetails extends StatelessWidget {
  final Map<String, String> plan;

  const PremiumPlanDetails({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final displayName = localizedPremiumPlanName(plan['key']!);

    return Scaffold(
      appBar: AppBar(
        title: Text(displayName),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFBEE9FF), Color(0xFFDFF8EF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F4C6E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${'yearly_premium'.tr}: ${plan['premium']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildDetailCard('life_coverage'.tr, plan['life'] ?? 'N/A'),
            _buildDetailCard(
              'accidental_death_benefit'.tr,
              plan['accidental'] ?? 'N/A',
            ),
            _buildDetailCard(
              'permanent_disability'.tr,
              plan['disability'] ?? 'N/A',
            ),
            _buildDetailCard('critical_illness'.tr, plan['critical'] ?? 'N/A'),
            _buildDetailCard(
              'hospicash'.tr,
              '${plan['key']}_hospicash_value'.tr,
            ),
            _buildDetailCard('opd'.tr, plan['opd'] ?? 'N/A'),

            // changed: hardcoded English removed
            _buildDetailCard(
              'telemedicine'.tr,
              'premium_telemedicine_value'.tr,
            ),
            _buildDetailCard(
              'discount_facilities'.tr,
              'premium_discount_facilities_value'.tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF9CCEE8), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 2),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F4C6E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
