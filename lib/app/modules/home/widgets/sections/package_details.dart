// import 'package:flutter/material.dart';

// class PackageDetails extends StatelessWidget {
//   final String title;
//   final String assetPath;

//   const PackageDetails(
//       {super.key, required this.title, required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     final isProbashi = title == 'Probashi Package';
//     final caption = isProbashi
//         ? 'Bellevie Guardian NRB Health Support'
//         : 'Bellevie Guardian Health Programme';

//     const premiumHeader = [
//       'Category',
//       'Product 1',
//       'Product 2',
//       'Product 3',
//       'Product 4',
//       'Product 5',
//     ];

//     const premiumRows = [
//       [
//         'Yearly Premium',
//         'BDT 549',
//         'BDT 999',
//         'BDT 1499',
//         'BDT 2399',
//         'BDT 3599',
//       ],
//       [
//         'Life',
//         '100,000',
//         '150,000',
//         '175,000',
//         '200,000',
//         '350,000',
//       ],
//       [
//         'ADB',
//         '200,000',
//         '300,000',
//         '350,000',
//         '400,000',
//         '700,000',
//       ],
//       [
//         'PTD & PPD',
//         '100,000',
//         'N/A',
//         '175,000',
//         '200,000',
//         '250,000',
//       ],
//       [
//         'Critical Illness',
//         'N/A',
//         '25,000',
//         '50,000',
//         '100,000',
//         '150,000',
//       ],
//       [
//         'Hospicash',
//         'BDT 5000 (BDT 500/day, up to 5 days in a row)',
//         'BDT 15,000 (BDT 1000/day, up to 5 days in a row)',
//         'BDT 15,000 (BDT 1500/day, up to 5 days in a row)',
//         'BDT 20,000 (BDT 1500/day, up to 5 days in a row)',
//         'BDT 35,000 (BDT 2000/day, up to 5 days in a row)',
//       ],
//       [
//         'OPD',
//         'N/A',
//         'N/A',
//         'N/A',
//         '2000',
//         '5000',
//       ],
//       [
//         'Telemedicine',
//         '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
//         '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
//         '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
//         '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
//         '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
//       ],
//       [
//         'Discount Facilities',
//         'Up to 50% Discount facilities Up to 50+ Hospitals & Diagnostic center all around Bangladesh. https://guardianlife.com.bd/preferred-hospital',
//         '',
//         '',
//         '',
//         '',
//       ],
//     ];

//     const probashiHeader = ['Category', 'Coverage'];

//     const probashiRows = [
//       ['Yearly Premium (BDT)', '6250'],
//       ['Life', '500,000'],
//       ['Permanent Total Disability', '500,000'],
//       ['Permanent Partial Disability', '50,000-200,000'],
//       ['Funeral Benefit', 'Up to 20,000'],
//       ['Dead Body Repatriation', '15,000'],
//       ['Loss of Income (Up to six Months) Month', '50,000'],
//       ['Hospitalization', '50,000 (BDT 5000/day, up to 5 days in a row)'],
//       [
//         'Telemedicine',
//         '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
//       ],
//     ];

//     final header = isProbashi ? probashiHeader : premiumHeader;
//     final rows = isProbashi ? probashiRows : premiumRows;
//     final widths = isProbashi
//         ? const [180.0, 240.0]
//         : const [120.0, 140.0, 140.0, 140.0, 140.0, 140.0];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 8),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: Image.asset(
//                 assetPath,
//                 width: double.infinity,
//                 height: 235,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   width: double.infinity,
//                   height: 110,
//                   color: Colors.grey.shade100,
//                   child: Center(
//                     child: Icon(
//                       Icons.image_not_supported_rounded,
//                       color: Colors.grey[400],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 14),
//             if (caption != null) ...[
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   caption,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xFFBEE9FF),
//                     Color(0xFFDFF8EF),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.white30, width: 1),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x33FFFFFF),
//                     offset: Offset(-3, -3),
//                     blurRadius: 6,
//                   ),
//                   BoxShadow(
//                     color: Color(0x22000000),
//                     offset: Offset(3, 4),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: isProbashi
//                   ? _buildProbashiList(rows)
//                   : SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildTableRow(header, widths, isHeader: true),
//                           const SizedBox(height: 5),
//                           for (final row in rows) ...[
//                             _buildTableRow(row, widths),
//                             const SizedBox(height: 6),
//                           ]
//                         ],
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   static Widget _buildTableRow(
//     List<String> cells,
//     List<double> widths, {
//     bool isHeader = false,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(
//         cells.length,
//         (index) => _buildCell(
//           cells[index],
//           width: widths[index],
//           isHeader: isHeader,
//         ),
//       ),
//     );
//   }

//   static Widget _buildCell(
//     String text, {
//     required double width,
//     bool isHeader = false,
//   }) {
//     final background = isHeader ? const Color(0xFFE6F4FF) : Colors.white;
//     final borderColor = isHeader ? const Color(0xFFD6E8F6) : Colors.black12;

//     return Container(
//       width: width,
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//       margin: const EdgeInsets.only(right: 6),
//       decoration: BoxDecoration(
//         color: background,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: borderColor, width: 1),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x14000000),
//             offset: Offset(1, 2),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: isHeader ? 12.5 : 12,
//           fontWeight: isHeader ? FontWeight.w700 : FontWeight.w600,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }

//   static Widget _buildProbashiList(List<List<String>> rows) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final isNarrow = constraints.maxWidth < 360;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             for (var i = 0; i < rows.length; i++) ...[
//               _buildProbashiCard(
//                 label: rows[i][0],
//                 value: rows[i][1],
//                 emphasize: i == 0,
//                 isNarrow: isNarrow,
//               ),
//               if (i != rows.length - 1) const SizedBox(height: 10),
//             ],
//           ],
//         );
//       },
//     );
//   }

//   static Widget _buildProbashiCard({
//     required String label,
//     required String value,
//     required bool emphasize,
//     required bool isNarrow,
//   }) {
//     final labelStyle = TextStyle(
//       fontSize: 12.5,
//       fontWeight: FontWeight.w700,
//       color: emphasize ? const Color(0xFF0F4C6E) : Colors.black87,
//     );

//     final valueStyle = TextStyle(
//       fontSize: 12.5,
//       fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
//       color: emphasize ? const Color(0xFF0F4C6E) : Colors.black87,
//     );

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: emphasize ? const Color(0xFF9CCEE8) : const Color(0xFFE1EDF5),
//           width: 1,
//         ),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x14000000),
//             offset: Offset(0, 2),
//             blurRadius: 6,
//           ),
//         ],
//       ),
//       child: isNarrow
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label, style: labelStyle),
//                 const SizedBox(height: 6),
//                 Text(value, style: valueStyle),
//               ],
//             )
//           : Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 5,
//                   child: Text(label, style: labelStyle),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     value,
//                     style: valueStyle,
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
// import 'package:bellevie/app/modules/home/widgets/sections/premium_package_details.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PackageDetails extends StatelessWidget {
//   final String title;
//   final String assetPath;

//   const PackageDetails({
//     super.key,
//     required this.title,
//     required this.assetPath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isProbashi =
//         title == 'Probashi Package' || title == 'probashi_package'.tr;
//     final String caption = isProbashi
//         ? 'Bellevie Guardian NRB Health Support'
//         : 'Bellevie Guardian Health Programme';

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 8),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: Image.asset(
//                 assetPath,
//                 width: double.infinity,
//                 height: 235,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   width: double.infinity,
//                   height: 110,
//                   color: Colors.grey.shade100,
//                   child: const Center(
//                     child: Icon(Icons.image_not_supported_rounded,
//                         color: Colors.grey),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 14),

//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 caption,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Main Content
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFFBEE9FF), Color(0xFFDFF8EF)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.white30, width: 1),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x33FFFFFF),
//                     offset: Offset(-3, -3),
//                     blurRadius: 6,
//                   ),
//                   BoxShadow(
//                     color: Color(0x22000000),
//                     offset: Offset(3, 4),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: isProbashi
//                   ? _buildProbashiList(_probashiRows)
//                   : _buildPremiumVerticalPlans(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ====================== PREMIUM VERTICAL PLANS ======================

//   // ====================== PREMIUM VERTICAL PLANS ======================
//   Widget _buildPremiumVerticalPlans() {
//     final List<Map<String, String>> plans = [
//       {
//         'name': 'Shohay',
//         'name_bn': 'সহায়', // Added Bengali name
//         'premium': 'BDT 549',
//         'life': '100,000',
//         'accidental death benefit': '200,000',
//         'permanent total disability': '100,000',
//         'critical': 'N/A',
//         'hospicash': 'BDT 5000 (BDT 500/day, up to 5 days in a row)',
//         'opd': 'N/A',
//       },
//       {
//         'name': 'Nirbhor',
//         'name_bn': 'নির্ভর',
//         'premium': 'BDT 999',
//         'life': '150,000',
//         'accidental death benefit': '300,000',
//         'permanent total disability': 'N/A',
//         'critical': '25,000',
//         'hospicash': 'BDT 15,000 (BDT 1000/day, up to 5 days in a row)',
//         'opd': 'N/A',
//       },
//       {
//         'name': 'Shoshti',
//         'name_bn': 'শস্তি',
//         'premium': 'BDT 1499',
//         'life': '175,000',
//         'accidental death benefit': '350,000',
//         'permanent total disability': '175,000',
//         'critical': '50,000',
//         'hospicash': 'BDT 15,000 (BDT 1500/day, up to 5 days in a row)',
//         'opd': 'N/A',
//       },
//       {
//         'name': 'Aastha',
//         'name_bn': 'আস্থা',
//         'premium': 'BDT 2399',
//         'life': '200,000',
//         'accidental death benefit': '400,000',
//         'permanent partial disability': '200,000',
//         'critical': '100,000',
//         'hospicash': 'BDT 20,000 (BDT 1500/day, up to 5 days in a row)',
//         'opd': '2000',
//       },
//       {
//         'name': 'Prottoy',
//         'name_bn': 'প্রত্যয়',
//         'premium': 'BDT 3599',
//         'life': '350,000',
//         'accidental death benefit': '700,000',
//         'permanent partial disability': '250,000',
//         'critical': '150,000',
//         'hospicash': 'BDT 35,000 (BDT 2000/day, up to 5 days in a row)',
//         'opd': '5000',
//       },
//     ];

//     return Column(
//       children: plans.map((plan) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 12),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(16),
//             onTap: () => Get.to(() => PremiumPlanDetails(plan: plan)),
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFF9CCEE8), width: 1.5),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x14000000),
//                     offset: Offset(0, 3),
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // English + Bengali Name
//                         Text(
//                           '${plan['name']!} (${plan['name_bn']!})',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF0F4C6E),
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           'Yearly Premium: ${plan['premium']}',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(Icons.arrow_forward_ios_rounded,
//                       color: Color(0xFF0F4C6E), size: 20),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // ====================== PROBASHI PACKAGE (Unchanged) ======================
//   static const List<List<String>> _probashiRows = [
//     ['Yearly Premium (BDT)', '6250'],
//     ['Life', '500,000'],
//     ['Permanent Total Disability', '500,000'],
//     ['Permanent Partial Disability', '50,000-200,000'],
//     ['Funeral Benefit', 'Up to 20,000'],
//     ['Dead Body Repatriation', '15,000'],
//     ['Loss of Income (Up to six Months)', '50,000'],
//     ['Hospitalization', '50,000 (BDT 5000/day, up to 5 days in a row)'],
//     [
//       'Telemedicine',
//       '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)'
//     ],
//   ];

//   static Widget _buildProbashiList(List<List<String>> rows) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final isNarrow = constraints.maxWidth < 360;
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             for (var i = 0; i < rows.length; i++) ...[
//               _buildProbashiCard(
//                 label: rows[i][0],
//                 value: rows[i][1],
//                 emphasize: i == 0,
//                 isNarrow: isNarrow,
//               ),
//               if (i != rows.length - 1) const SizedBox(height: 10),
//             ],
//           ],
//         );
//       },
//     );
//   }

//   static Widget _buildProbashiCard({
//     required String label,
//     required String value,
//     required bool emphasize,
//     required bool isNarrow,
//   }) {
//     final labelStyle = TextStyle(
//       fontSize: 12.5,
//       fontWeight: FontWeight.w700,
//       color: emphasize ? const Color(0xFF0F4C6E) : Colors.black87,
//     );

//     final valueStyle = TextStyle(
//       fontSize: 12.5,
//       fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
//       color: emphasize ? const Color(0xFF0F4C6E) : Colors.black87,
//     );

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: emphasize ? const Color(0xFF9CCEE8) : const Color(0xFFE1EDF5),
//           width: 1,
//         ),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x14000000),
//             offset: Offset(0, 2),
//             blurRadius: 6,
//           ),
//         ],
//       ),
//       child: isNarrow
//           ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label, style: labelStyle),
//                 const SizedBox(height: 6),
//                 Text(value, style: valueStyle),
//               ],
//             )
//           : Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(flex: 5, child: Text(label, style: labelStyle)),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     value,
//                     style: valueStyle,
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
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

  @override
  Widget build(BuildContext context) {
    final bool isProbashi =
        title == 'probashi_package'.tr || title.toLowerCase().contains('probashi');

    final String caption = isProbashi
        ? 'bellevie_guardian_nrb'.tr
        : 'bellevie_guardian'.tr;

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
                  ? _buildProbashiList(_probashiRows)
                  : _buildPremiumVerticalPlans(),
            ),
          ],
        ),
      ),
    );
  }

  // ====================== PREMIUM VERTICAL PLANS (Updated with Translation) ======================
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
        final name = plan['key']!.tr;
        final nameBn = '${plan['key']}_bn'.tr;

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
                          '$name ($nameBn)',
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

  // ====================== PROBASHI PACKAGE (Unchanged) ======================
  static const List<List<String>> _probashiRows = [
    ['Yearly Premium (BDT)', '6250'],
    ['Life', '500,000'],
    ['Permanent Total Disability', '500,000'],
    ['Permanent Partial Disability', '50,000-200,000'],
    ['Funeral Benefit', 'Up to 20,000'],
    ['Dead Body Repatriation', '15,000'],
    ['Loss of Income (Up to six Months)', '50,000'],
    ['Hospitalization', '50,000 (BDT 5000/day, up to 5 days in a row)'],
    [
      'Telemedicine',
      '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)'
    ],
  ];

  static Widget _buildProbashiList(List<List<String>> rows) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < rows.length; i++) ...[
              _buildProbashiCard(
                label: rows[i][0],
                value: rows[i][1],
                emphasize: i == 0,
                isNarrow: isNarrow,
              ),
              if (i != rows.length - 1) const SizedBox(height: 10),
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