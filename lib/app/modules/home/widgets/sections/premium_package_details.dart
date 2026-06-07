// import 'package:flutter/material.dart';

// class PremiumPlanDetails extends StatelessWidget {
//   final Map<String, String> plan;

//   const PremiumPlanDetails({super.key, required this.plan});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(plan['name']!)),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Text(plan['name']!,
//             //     style:
//             //         const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             _buildInfo('Yearly Premium', plan['premium']!),
//             _buildInfo('Life Coverage', '${plan['life']} BDT'),
//             // Add more benefits here later
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfo(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 16)),
//           Text(value,
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class PremiumPlanDetails extends StatelessWidget {
//   final Map<String, String> plan;

//   const PremiumPlanDetails({
//     super.key,
//     required this.plan,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(plan['name']!),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: const Color(0xFF9CCEE8),
//             ),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0x14000000),
//                 blurRadius: 6,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Text(
//                   plan['name']!,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF0F4C6E),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildInfo('Yearly Premium', plan['premium'] ?? ''),
//               _buildInfo('Life Coverage', plan['life'] ?? ''),
//               _buildInfo('Accidental Death Benefit', plan['adb'] ?? ''),
//               _buildInfo(
//                   'Permanent Partial Disability & Permanent Total Disability',
//                   plan['ptd'] ?? ''),
//               _buildInfo('Critical Illness', plan['critical'] ?? ''),
//               _buildInfo('Hospicash', plan['hospicash'] ?? ''),
//               _buildInfo('OPD', plan['opd'] ?? ''),
//               _buildInfo(
//                 'Telemedicine',
//                 '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
//               ),
//               _buildInfo(
//                 'Discount Facilities',
//                 'Up to 50% Discount facilities Up to 50+ Hospitals & Diagnostic center all around Bangladesh.',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfo(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: const Color(0xFFF8FCFF),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: const Color(0xFFE1EDF5),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF0F4C6E),
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class PremiumPlanDetails extends StatelessWidget {
//   final Map<String, String> plan;

//   const PremiumPlanDetails({super.key, required this.plan});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(plan['name'] ?? 'Plan Details'),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFFBEE9FF), Color(0xFFDFF8EF)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     plan['name']!,
//                     style: const TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF0F4C6E),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Yearly Premium: ${plan['premium']}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             // Details Cards
//             _buildDetailCard('Life Coverage', plan['life'] ?? 'N/A'),
//             _buildDetailCard('Accidental Death Benefit',
//                 plan['accidental death benefit'] ?? 'N/A'),
//             _buildDetailCard(
//               'Permanent Partial Disability & Permanent Total Disability',
//               plan['permanent total disability'] ?? 'N/A',
//             ),
//             _buildDetailCard('Critical Illness', plan['critical'] ?? 'N/A'),
//             _buildDetailCard('Hospicash', plan['hospicash'] ?? 'N/A'),
//             _buildDetailCard('OPD', plan['opd'] ?? 'N/A'),
//             _buildDetailCard(
//               'Telemedicine',
//               '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
//             ),
//             _buildDetailCard(
//               'Discount Facilities',
//               'Up to 50% Discount facilities at 50+ Hospitals & Diagnostic centers all around Bangladesh.',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailCard(String title, String value) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: const Color(0xFF9CCEE8), width: 1.2),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x14000000),
//             offset: Offset(0, 2),
//             blurRadius: 6,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF0F4C6E),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:bellevie/app/localization/app_translation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PremiumPlanDetails extends StatelessWidget {
//   final Map<String, String> plan;

//   const PremiumPlanDetails({super.key, required this.plan});

//   @override
//   Widget build(BuildContext context) {
//     final displayName = localizedPremiumPlanName(plan['key']!);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(displayName),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFFBEE9FF), Color(0xFFDFF8EF)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     displayName,
//                     style: const TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF0F4C6E)),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '${'yearly_premium'.tr}: ${plan['premium']}',
//                     style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             _buildDetailCard('life_coverage'.tr, plan['life'] ?? 'N/A'),
//             _buildDetailCard(
//                 'accidental_death_benefit'.tr, plan['accidental'] ?? 'N/A'),
//             _buildDetailCard(
//                 'permanent_disability'.tr, plan['disability'] ?? 'N/A'),
//             _buildDetailCard('critical_illness'.tr, plan['critical'] ?? 'N/A'),
//             _buildDetailCard('hospicash'.tr, plan['hospicash'] ?? 'N/A'),
//             _buildDetailCard('opd'.tr, plan['opd'] ?? 'N/A'),
//             _buildDetailCard('telemedicine'.tr,
//                 '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)'),
//             _buildDetailCard('discount_facilities'.tr,
//                 'Up to 50% Discount facilities at 50+ Hospitals & Diagnostic centers all around Bangladesh.'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailCard(String title, String value) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: const Color(0xFF9CCEE8), width: 1.2),
//         boxShadow: const [
//           BoxShadow(
//               color: Color(0x14000000), offset: Offset(0, 2), blurRadius: 6)
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF0F4C6E))),
//           const SizedBox(height: 8),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87)),
//         ],
//       ),
//     );
//   }
// }
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
            _buildDetailCard('hospicash'.tr, plan['hospicash'] ?? 'N/A'),
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
