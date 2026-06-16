// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EmergencyServicesView extends StatelessWidget {
//   const EmergencyServicesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F2F2),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFFD6D6),
//         foregroundColor: Colors.black87,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           'emergency_services_screen'.tr,
//           style: const TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFE1E1),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: const Color(0xFFFFB3B3)),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x14000000),
//                     blurRadius: 8,
//                     offset: Offset(0, 8),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Flexible(
//                     flex: 0,
//                     child: Image.asset(
//                       'assets/images/banners/emergency_service_final.png',
//                       fit: BoxFit.contain,
//                       width: 100,
//                       height: 100,
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'emergency_fast_response'.tr,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           'emergency_subtitle'.tr,
//                           style: const TextStyle(
//                             fontSize: 13.5,
//                             height: 1.35,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 18),
//             Text(
//               'available_services'.tr,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const _EmergencyServiceTile(
//               icon: Icons.local_taxi_rounded,
//               titleKey: 'ambulance',
//               subtitleKey: 'ambulance_subtitle',
//               serviceType: 'ambulance',
//             ),
//             const SizedBox(height: 10),
//             const _EmergencyServiceTile(
//               icon: Icons.flight_takeoff_rounded,
//               titleKey: 'air_ambulance',
//               subtitleKey: 'air_ambulance_subtitle',
//               serviceType: 'air_ambulance',
//             ),
//             const SizedBox(height: 10),
//             const _EmergencyServiceTile(
//               icon: Icons.monitor_heart_rounded,
//               titleKey: 'icu_ambulance',
//               subtitleKey: 'icu_ambulance_subtitle',
//               serviceType: 'icu_ambulance',
//             ),
//             const SizedBox(height: 10),
//             const _EmergencyServiceTile(
//               icon: Icons.person_pin_circle_rounded,
//               titleKey: 'patient_transfer',
//               subtitleKey: 'patient_transfer_subtitle',
//               serviceType: 'patient_transfer',
//             ),
//             const SizedBox(height: 18),
//             Text(
//               'need_immediate_help'.tr,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFFE5E5E5)),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x0F000000),
//                     blurRadius: 8,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'emergency_contact_guidance'.tr,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       height: 1.4,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'emergency_call_instruction'.tr,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       height: 1.4,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _EmergencyServiceTile extends StatelessWidget {
//   final IconData icon;
//   final String titleKey;
//   final String subtitleKey;
//   final String serviceType;

//   const _EmergencyServiceTile({
//     required this.icon,
//     required this.titleKey,
//     required this.subtitleKey,
//     required this.serviceType,
//   });

//   // Phone numbers for each service
//   static const Map<String, List<String>> phoneNumbers = {
//     'ambulance': ['+880 1805-464400', '01805464392', '01805464391'],
//     'air_ambulance': ['+880 1805-464400', '01805464392', '01805464391'],
//     'icu_ambulance': ['+880 1805-464400', '01805464392', '01805464391'],
//     'patient_transfer': ['+880 1805-464400', '01805464392', '01805464391'],
//   };

//   void _showPhoneNumbers(BuildContext context) {
//     final numbers = phoneNumbers[serviceType] ?? [];

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(titleKey.tr),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Contact Numbers:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             ...numbers
//                 .map((number) => Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.phone, color: Colors.blue, size: 20),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               number,
//                               style: const TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ))
//                 .toList(),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showPhoneNumbers(context),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: const Color(0xFFE5E5E5)),
//           boxShadow: const [
//             BoxShadow(
//               color: Color(0x0F000000),
//               blurRadius: 8,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFFFD6D6),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 icon,
//                 size: 22,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     titleKey.tr,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitleKey.tr,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       height: 1.35,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(Icons.chevron_right, color: Colors.black54),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  Flexible(
                    flex: 0,
                    child: Image.asset(
                      'assets/images/banners/emergency_service_final.png',
                      fit: BoxFit.contain,
                      width: 100,
                      height: 100,
                    ),
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
              serviceType: 'ambulance',
            ),
            const SizedBox(height: 10),
            const _EmergencyServiceTile(
              icon: Icons.flight_takeoff_rounded,
              titleKey: 'air_ambulance',
              subtitleKey: 'air_ambulance_subtitle',
              serviceType: 'air_ambulance',
            ),
            const SizedBox(height: 10),
            const _EmergencyServiceTile(
              icon: Icons.monitor_heart_rounded,
              titleKey: 'icu_ambulance',
              subtitleKey: 'icu_ambulance_subtitle',
              serviceType: 'icu_ambulance',
            ),
            const SizedBox(height: 10),
            const _EmergencyServiceTile(
              icon: Icons.person_pin_circle_rounded,
              titleKey: 'patient_transfer',
              subtitleKey: 'patient_transfer_subtitle',
              serviceType: 'patient_transfer',
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
  final String serviceType;

  const _EmergencyServiceTile({
    required this.icon,
    required this.titleKey,
    required this.subtitleKey,
    required this.serviceType,
  });

  static const Map<String, List<String>> phoneNumbers = {
    'ambulance': ['+880 1805-464400', '01805464392', '01805464391'],
    'air_ambulance': ['+880 1805-464400', '01805464392', '01805464391'],
    'icu_ambulance': ['+880 1805-464400', '01805464392', '01805464391'],
    'patient_transfer': ['+880 1805-464400', '01805464392', '01805464391'],
  };

  Future<void> _makePhoneCall(String number) async {
    final cleanNumber = number.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri(scheme: 'tel', path: cleanNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar(
        'Error',
        'Could not open dial pad',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showPhoneNumbers(BuildContext context) {
    final numbers = phoneNumbers[serviceType] ?? [];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titleKey.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Numbers:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...numbers.map(
              (number) => InkWell(
                onTap: () => _makePhoneCall(number),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.blue, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          number,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPhoneNumbers(context),
      child: Container(
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
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
