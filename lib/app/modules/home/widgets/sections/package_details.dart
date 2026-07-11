
import 'package:bellevie/app/localization/app_translation.dart';
import 'package:bellevie/app/modules/home/widgets/sections/premium_package_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageDetails extends StatelessWidget {
  final String title;
  final String assetPath;

  const PackageDetails({
    super.key,
    required this.title,
    required this.assetPath,
  });

  // Probashi Package data
  static const List<List<String>> _probashiRowKeys = [
    ['yearly_premium_bdt', '6250'],
    ['life', '500,000'],
    ['permanent_total_disability', '500,000'],
    ['permanent_partial_disability', '50,000-200,000'],
    ['funeral_benefit', 'probashi_value_funeral'],
    ['dead_body_repatriation', '15,000'],
    ['loss_of_income', '50,000'],
    ['hospitalization', 'probashi_value_hospitalization'],
    ['telemedicine_24_7', 'probashi_value_telemedicine'],
  ];

  // Premium Package data from the new PDF
static const List<Map<String, String>> _premiumPlans = [
  {
    'key': 'shohay',
    'premium': 'BDT 900',
    'monthlyPremium': 'BDT 75',
    'life': '100,000',
    'accidental': '200,000',
    'disability': '100,000',
    'critical': 'N/A',
    'hospicash': '5,000',
    'opd': 'N/A',
  },
  {
    'key': 'nirbhor',
    'premium': 'BDT 1,620',
    'monthlyPremium': 'BDT 135',
    'life': '150,000',
    'accidental': '300,000',
    'disability': '150,000',
    'critical': 'N/A',
    'hospicash': '10,000',
    'opd': 'N/A',
  },
  {
    'key': 'shoshti',
    'premium': 'BDT 2,580',
    'monthlyPremium': 'BDT 215',
    'life': '175,000',
    'accidental': '350,000',
    'disability': '175,000',
    'critical': '50,000',
    'hospicash': '20,000',
    'opd': 'N/A',
  },
  {
    'key': 'aastha',
    'premium': 'BDT 4,500',
    'monthlyPremium': 'BDT 375',
    'life': '250,000',
    'accidental': '500,000',
    'disability': '200,000',
    'critical': '250,000',
    'hospicash': '30,000',
    'opd': '2,000',
  },
  {
    'key': 'prottoy',
    'premium': 'BDT 6,240',
    'monthlyPremium': 'BDT 520',
    'life': '350,000',
    'accidental': '700,000',
    'disability': '250,000',
    'critical': '300,000',
    'hospicash': '50,000',
    'opd': '5,000',
  },
  {
    'key': 'shurokkha',
    'nameEn': 'Shurokkha',
    'nameBn': 'সুরক্ষা',
    'premium': 'BDT 3,000',
    'monthlyPremium': 'BDT 250',
    'life': '300,000',
    'accidental': 'N/A',
    'disability': 'N/A',
    'critical': '300,000',
    'hospicash': 'N/A',
    'opd': 'N/A',
  },
];

  @override
  Widget build(BuildContext context) {
    final bool isProbashi = title == 'probashi_package'.tr ||
        title.toLowerCase().contains('probashi');

    final String caption = isProbashi
        ? 'bellevie_guardian_nrb'.tr
        : 'bellevie_guardian'.tr;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                assetPath,
                width: double.infinity,
                height: 235,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 110,
                    color: Colors.grey.shade100,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                caption,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
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
                border: Border.all(
                  color: Colors.white30,
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
                    blurRadius: 10,
                  ),
                ],
              ),
              child: isProbashi
                  ? _buildProbashiList(_probashiRowKeys)
                  : _buildPremiumVerticalPlans(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumVerticalPlans() {
    final bool isBn = Get.locale?.languageCode == 'bn';

    return Column(
      children: _premiumPlans.map((plan) {
        final String displayName;

        if (plan['key'] == 'shurokkha') {
          displayName = isBn
              ? '${plan['nameBn']} (${plan['nameEn']})'
              : '${plan['nameEn']} (${plan['nameBn']})';
        } else {
          displayName = localizedPremiumPlanName(plan['key']!);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Get.to(
                () => PremiumPlanDetails(plan: plan),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF9CCEE8),
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F4C6E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${'yearly_premium'.tr}: ${plan['premium']}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${isBn ? 'মাসিক প্রিমিয়াম' : 'Monthly Premium'}: '
                          '${plan['monthlyPremium']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF0F4C6E),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  static Widget _buildProbashiList(List<List<String>> rowKeys) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 360;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < rowKeys.length; i++) ...[
              _buildProbashiCard(
                label: rowKeys[i][0].tr,
                value: rowKeys[i][1].tr,
                emphasize: i == 0,
                isNarrow: isNarrow,
              ),
              if (i != rowKeys.length - 1)
                const SizedBox(height: 10),
            ],
          ],
        );
      },
    );
  }

  static Widget _buildProbashiCard({
    required String label,
    required String value,
    required bool emphasize,
    required bool isNarrow,
  }) {
    final TextStyle labelStyle = TextStyle(
      fontSize: 12.5,
      fontWeight: FontWeight.w700,
      color: emphasize
          ? const Color(0xFF0F4C6E)
          : Colors.black87,
    );

    final TextStyle valueStyle = TextStyle(
      fontSize: 12.5,
      fontWeight: emphasize
          ? FontWeight.w800
          : FontWeight.w600,
      color: emphasize
          ? const Color(0xFF0F4C6E)
          : Colors.black87,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: emphasize
              ? const Color(0xFF9CCEE8)
              : const Color(0xFFE1EDF5),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: isNarrow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: labelStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: valueStyle,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    label,
                    style: labelStyle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: valueStyle,
                  ),
                ),
              ],
            ),
    );
  }
}