
import 'package:bellevie/app/localization/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremiumPlanDetails extends StatelessWidget {
  final Map<String, String> plan;

  const PremiumPlanDetails({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBn = Get.locale?.languageCode == 'bn';

    final String displayName = _getDisplayName(isBn);
    final String notApplicable = isBn ? 'প্রযোজ্য নয়' : 'N/A';
    final String currency = isBn ? 'টাকা' : 'BDT';

    String formatBenefit(String? value) {
      if (value == null || value.trim().isEmpty || value == 'N/A') {
        return notApplicable;
      }

      return '$currency $value';
    }

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
                  colors: [
                    Color(0xFFBEE9FF),
                    Color(0xFFDFF8EF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F4C6E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${'yearly_premium'.tr}: '
                    '${plan['premium'] ?? notApplicable}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${isBn ? 'মাসিক প্রিমিয়াম' : 'Monthly Premium'}: '
                    '${plan['monthlyPremium'] ?? notApplicable}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // PDF-এর নতুন Life data
            _buildDetailCard(
              'life_coverage'.tr,
              formatBenefit(plan['life']),
            ),

            // PDF-এর নতুন ADB data
            _buildDetailCard(
              'accidental_death_benefit'.tr,
              formatBenefit(plan['accidental']),
            ),

            // PDF-এর নতুন PTD & PPD data
            _buildDetailCard(
              'permanent_disability'.tr,
              formatBenefit(plan['disability']),
            ),

            // PDF-এর নতুন Critical Illness data
            _buildDetailCard(
              'critical_illness'.tr,
              formatBenefit(plan['critical']),
            ),

            // PDF-এর নতুন IPD data
            // পুরোনো hospicash translation আর ব্যবহার করা হচ্ছে না
            _buildDetailCard(
              isBn ? 'হাসপাতালে ভর্তি সহায়তা (IPD)' : 'IPD',
              formatBenefit(plan['hospicash']),
            ),

            // PDF-এর নতুন OPD data
            _buildDetailCard(
              'opd'.tr,
              formatBenefit(plan['opd']),
            ),

            // PDF-এর Telemedicine তথ্য
            _buildDetailCard(
              'telemedicine'.tr,
              isBn
                  ? '২৪/৭ আনলিমিটেড অডিও ও ভিডিও ডাক্তার পরামর্শ '
                      '(পরিবারের সর্বোচ্চ ৬ জন সদস্য)'
                  : '24/7 Unlimited Audio & Video Doctor Consultancy '
                      '(Up to 6 family members)',
            ),

            // আগের Discount Facilities ঠিক রাখা হয়েছে
            _buildDetailCard(
              'discount_facilities'.tr,
              'premium_discount_facilities_value'.tr,
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayName(bool isBn) {
    final String key = plan['key'] ?? '';

    if (key == 'shurokkha') {
      final String englishName = plan['nameEn'] ?? 'Shurokkha';
      final String bengaliName = plan['nameBn'] ?? 'সুরক্ষা';

      return isBn
          ? '$bengaliName ($englishName)'
          : '$englishName ($bengaliName)';
    }

    if (key.isEmpty) {
      return isBn ? 'প্রিমিয়াম পরিকল্পনা' : 'Premium Plan';
    }

    return localizedPremiumPlanName(key);
  }

  Widget _buildDetailCard(
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF9CCEE8),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
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
