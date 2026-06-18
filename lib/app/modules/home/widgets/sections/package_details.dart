
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

  // ====================== PROBASHI PACKAGE KEYS (Translation Support) ======================
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
  // =======================================================================================

  @override
  Widget build(BuildContext context) {
    final bool isProbashi = title == 'probashi_package'.tr ||
        title.toLowerCase().contains('probashi');

    final String caption =
        isProbashi ? 'bellevie_guardian_nrb'.tr : 'bellevie_guardian'.tr;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 110,
                  color: Colors.grey.shade100,
                  child: const Center(
                    child: Icon(Icons.image_not_supported_rounded,
                        color: Colors.grey),
                  ),
                ),
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

            // Main Content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFBEE9FF), Color(0xFFDFF8EF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white30, width: 1),
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

  // ====================== PREMIUM VERTICAL PLANS ======================
  Widget _buildPremiumVerticalPlans() {
    final List<Map<String, String>> plans = [
      {
        'key': 'shohay',
        'premium': 'BDT 549',
        'life': '100,000',
        'accidental death benefit': '200,000',
        'permanent total disability': '100,000',
        'critical': 'N/A',
        'hospicash': 'BDT 5000 (BDT 500/day, up to 5 days in a row)',
        'opd': 'N/A',
      },
      {
        'key': 'nirbhor',
        'premium': 'BDT 999',
        'life': '150,000',
        'accidental death benefit': '300,000',
        'permanent total disability': 'N/A',
        'critical': '25,000',
        'hospicash': 'BDT 15,000 (BDT 1000/day, up to 5 days in a row)',
        'opd': 'N/A',
      },
      {
        'key': 'shoshti',
        'premium': 'BDT 1499',
        'life': '175,000',
        'accidental death benefit': '350,000',
        'permanent total disability': '175,000',
        'critical': '50,000',
        'hospicash': 'BDT 15,000 (BDT 1500/day, up to 5 days in a row)',
        'opd': 'N/A',
      },
      {
        'key': 'aastha',
        'premium': 'BDT 2399',
        'life': '200,000',
        'accidental death benefit': '400,000',
        'permanent partial disability': '200,000',
        'critical': '100,000',
        'hospicash': 'BDT 20,000 (BDT 1500/day, up to 5 days in a row)',
        'opd': '2000',
      },
      {
        'key': 'prottoy',
        'premium': 'BDT 3599',
        'life': '350,000',
        'accidental death benefit': '700,000',
        'permanent partial disability': '250,000',
        'critical': '150,000',
        'hospicash': 'BDT 35,000 (BDT 2000/day, up to 5 days in a row)',
        'opd': '5000',
      },
    ];

    return Column(
      children: plans.map((plan) {
        final displayName = localizedPremiumPlanName(plan['key']!);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Get.to(() => PremiumPlanDetails(plan: plan)),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF9CCEE8), width: 1.5),
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
                        const SizedBox(height: 6),
                        Text(
                          '${'yearly_premium'.tr}: ${plan['premium']}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF0F4C6E), size: 20),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ====================== PROBASHI PACKAGE ======================
  static Widget _buildProbashiList(List<List<String>> rowKeys) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;

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
              if (i != rowKeys.length - 1) const SizedBox(height: 10),
            ]
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
    final labelStyle = TextStyle(
      fontSize: 12.5,
      fontWeight: FontWeight.w700,
      color: emphasize ? const Color(0xFF0F4C6E) : Colors.black87,
    );

    final valueStyle = TextStyle(
      fontSize: 12.5,
      fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
      color: emphasize ? const Color(0xFF0F4C6E) : Colors.black87,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: emphasize ? const Color(0xFF9CCEE8) : const Color(0xFFE1EDF5),
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
                Text(label, style: labelStyle),
                const SizedBox(height: 6),
                Text(value, style: valueStyle),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: Text(label, style: labelStyle)),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Text(
                    value,
                    style: valueStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
    );
  }
}
