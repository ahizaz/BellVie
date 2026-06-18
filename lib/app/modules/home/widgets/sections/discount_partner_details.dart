// // import 'package:flutter/material.dart';
// // import 'package:cached_network_image/cached_network_image.dart';

// // class DiscountPartnerDetails extends StatelessWidget {
// //   final String name;
// //   final String iconUrl;

// //   const DiscountPartnerDetails(
// //       {super.key, required this.name, required this.iconUrl});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(name),
// //         elevation: 0,
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             const SizedBox(height: 8),
// //             Center(
// //               child: Container(
// //                 height: 120,
// //                 width: 120,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(16),
// //                   color: Colors.grey.shade100,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.08),
// //                       blurRadius: 8,
// //                       offset: const Offset(0, 4),
// //                     ),
// //                   ],
// //                 ),
// //                 child: ClipRRect(
// //                   borderRadius: BorderRadius.circular(16),
// //                   child: iconUrl.isNotEmpty
// //                       ? CachedNetworkImage(
// //                           imageUrl: iconUrl,
// //                           fit: BoxFit.contain,
// //                           placeholder: (context, url) => Container(
// //                             color: Colors.grey.shade200,
// //                             child: const Center(
// //                               child: CircularProgressIndicator(strokeWidth: 2),
// //                             ),
// //                           ),
// //                           errorWidget: (context, url, error) => Container(
// //                             color: Colors.grey.shade200,
// //                             child: const Icon(Icons.broken_image),
// //                           ),
// //                         )
// //                       : Container(color: Colors.grey.shade200),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             Text(
// //               name,
// //               textAlign: TextAlign.center,
// //               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
// //             ),
// //             const SizedBox(height: 12),
// //             const Text(
// //               'About this partner',
// //               style: TextStyle(fontSize: 16, color: Colors.black87),
// //             ),
// //             const SizedBox(height: 8),
// //             const Text(
// //               'Details will be Coming soon',
// //               style: TextStyle(fontSize: 14, color: Colors.black87),
// //             ),
// //             const SizedBox(height: 16),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:bellevie/app/modules/home/data/discount_partner_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:bellevie/app/modules/home/controllers/home_controller.dart';

// class DiscountPartnerDetails extends StatefulWidget {
//   final int partnerId;
//   final String name;
//   final String iconUrl;

//   const DiscountPartnerDetails({
//     super.key,
//     required this.partnerId,
//     required this.name,
//     required this.iconUrl,
//   });

//   @override
//   State<DiscountPartnerDetails> createState() => _DiscountPartnerDetailsState();
// }

// class _DiscountPartnerDetailsState extends State<DiscountPartnerDetails> {
//   final DiscountPartnerRepository _repository = DiscountPartnerRepository();

//   bool _isLoading = true;
//   Map<String, dynamic>? _data;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDetails();
//   }

//   Future<void> _fetchDetails() async {
//     final result =
//         await _repository.fetchDiscountPartnerDetails(widget.partnerId);

//     if (!mounted) return;

//     setState(() {
//       _data = result;
//       _isLoading = false;
//     });
//   }

//   String _text(dynamic value) => (value ?? '').toString().trim();

//   @override
//   Widget build(BuildContext context) {
//     final homeController = Get.isRegistered<HomeController>()
//         ? Get.find<HomeController>()
//         : Get.put(HomeController());

//     final isBangla = homeController.currentLocale.value.languageCode == 'bn';

//     final title = isBangla
//         ? (_text(_data?['name_bn']).isNotEmpty
//             ? _text(_data?['name_bn'])
//             : widget.name)
//         : (_text(_data?['name_en']).isNotEmpty
//             ? _text(_data?['name_en'])
//             : widget.name);

//     final icon = _text(_data?['icon']).isNotEmpty
//         ? _text(_data?['icon'])
//         : widget.iconUrl;

//     final details = isBangla
//         ? (_text(_data?['details_bn']).isNotEmpty
//             ? _text(_data?['details_bn'])
//             : _text(_data?['details']))
//         : (_text(_data?['details_en']).isNotEmpty
//             ? _text(_data?['details_en'])
//             : _text(_data?['details']));

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F9FB),
//       appBar: AppBar(
//         title: Text(title),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(18),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFFBEE9FF),
//                           Color(0xFFDFF8EF),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color(0x22000000),
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 120,
//                           width: 120,
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(14),
//                             child: icon.isNotEmpty
//                                 ? CachedNetworkImage(
//                                     imageUrl: icon,
//                                     fit: BoxFit.contain,
//                                     placeholder: (context, url) => const Center(
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                       ),
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.broken_image),
//                                   )
//                                 : const Icon(Icons.local_hospital, size: 50),
//                           ),
//                         ),
//                         const SizedBox(height: 14),
//                         Text(
//                           title,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 18),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(18),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(18),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color(0x14000000),
//                           blurRadius: 8,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Discount Details',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           details.isNotEmpty
//                               ? details
//                               : 'Details will be Coming soon',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             height: 1.6,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:bellevie/app/modules/home/data/discount_partner_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:bellevie/app/modules/home/controllers/home_controller.dart';

// class DiscountPartnerDetails extends StatefulWidget {
//   final int partnerId;
//   final String name;
//   final String iconUrl;

//   const DiscountPartnerDetails({
//     super.key,
//     required this.partnerId,
//     required this.name,
//     required this.iconUrl,
//   });

//   @override
//   State<DiscountPartnerDetails> createState() => _DiscountPartnerDetailsState();
// }

// class _DiscountPartnerDetailsState extends State<DiscountPartnerDetails> {
//   final DiscountPartnerRepository _repository = DiscountPartnerRepository();

//   late final HomeController homeController;

//   bool _isLoading = true;
//   Map<String, dynamic>? _data;

//   @override
//   void initState() {
//     super.initState();

//     homeController = Get.isRegistered<HomeController>()
//         ? Get.find<HomeController>()
//         : Get.put(HomeController());

//     final cachedData =
//         homeController.getCachedDiscountPartnerDetails(widget.partnerId);

//     if (cachedData != null) {
//       _data = cachedData;
//       _isLoading = false;
//       _fetchDetails(showLoading: false);
//     } else {
//       _fetchDetails(showLoading: true);
//     }
//   }

//   Future<void> _fetchDetails({required bool showLoading}) async {
//     if (showLoading) {
//       setState(() {
//         _isLoading = true;
//       });
//     }

//     final result =
//         await _repository.fetchDiscountPartnerDetails(widget.partnerId);

//     if (!mounted) return;

//     if (result != null) {
//       final oldData = jsonEncode(_data ?? {});
//       final newData = jsonEncode(result);

//       homeController.setCachedDiscountPartnerDetails(widget.partnerId, result);

//       if (oldData != newData) {
//         setState(() {
//           _data = result;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   String _text(dynamic value) => (value ?? '').toString().trim();

//   @override
//   Widget build(BuildContext context) {
//     final isBangla = homeController.currentLocale.value.languageCode == 'bn';

//     final title = isBangla
//         ? (_text(_data?['name_bn']).isNotEmpty
//             ? _text(_data?['name_bn'])
//             : widget.name)
//         : (_text(_data?['name_en']).isNotEmpty
//             ? _text(_data?['name_en'])
//             : widget.name);

//     final icon = _text(_data?['icon']).isNotEmpty
//         ? _text(_data?['icon'])
//         : widget.iconUrl;

//     final details = isBangla
//         ? (_text(_data?['details_bn']).isNotEmpty
//             ? _text(_data?['details_bn'])
//             : _text(_data?['details']))
//         : (_text(_data?['details_en']).isNotEmpty
//             ? _text(_data?['details_en'])
//             : _text(_data?['details']));

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F9FB),
//       appBar: AppBar(
//         title: Text(title),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(18),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFFBEE9FF),
//                           Color(0xFFDFF8EF),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color(0x22000000),
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 120,
//                           width: 120,
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(14),
//                             child: icon.isNotEmpty
//                                 ? CachedNetworkImage(
//                                     imageUrl: icon,
//                                     fit: BoxFit.contain,
//                                     placeholder: (context, url) => const Center(
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                       ),
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.broken_image),
//                                   )
//                                 : const Icon(Icons.local_hospital, size: 50),
//                           ),
//                         ),
//                         const SizedBox(height: 14),
//                         Text(
//                           title,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 18),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(18),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(18),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color(0x14000000),
//                           blurRadius: 8,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Discount Details',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           details.isNotEmpty
//                               ? details
//                               : 'Details will be Coming soon',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             height: 1.6,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
import 'dart:convert';

import 'package:bellevie/app/modules/home/data/discount_partner_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:bellevie/app/modules/home/controllers/home_controller.dart';

class DiscountPartnerDetails extends StatefulWidget {
  final int partnerId;
  final String name;
  final String iconUrl;

  const DiscountPartnerDetails({
    super.key,
    required this.partnerId,
    required this.name,
    required this.iconUrl,
  });

  @override
  State<DiscountPartnerDetails> createState() => _DiscountPartnerDetailsState();
}

class _DiscountPartnerDetailsState extends State<DiscountPartnerDetails> {
  final DiscountPartnerRepository _repository = DiscountPartnerRepository();

  late final HomeController homeController;

  bool _isLoading = true;
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();

    homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    final cachedData =
        homeController.getCachedDiscountPartnerDetails(widget.partnerId);

    if (cachedData != null) {
      _data = cachedData;
      _isLoading = false;
      _fetchDetails(showLoading: false);
    } else {
      _fetchDetails(showLoading: true);
    }
  }

  Future<void> _fetchDetails({required bool showLoading}) async {
    if (showLoading) {
      setState(() => _isLoading = true);
    }

    final result =
        await _repository.fetchDiscountPartnerDetails(widget.partnerId);

    if (!mounted) return;

    if (result != null) {
      final oldData = jsonEncode(_data ?? {});
      final newData = jsonEncode(result);

      homeController.setCachedDiscountPartnerDetails(widget.partnerId, result);

      if (oldData != newData) {
        setState(() {
          _data = result;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } else {
      setState(() => _isLoading = false);
    }
  }

  String _text(dynamic value) => (value ?? '').toString().trim();

  Future<void> _openDialPad(String number) async {
    final cleanNumber = number.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri(scheme: 'tel', path: cleanNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _clickableDetailsText(String details) {
    final lines = details.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        final trimmed = line.trim();
        final isPhone = RegExp(r'^\+?[\d\s-]{7,}$').hasMatch(trimmed);

        if (trimmed.isEmpty) {
          return const SizedBox(height: 8);
        }

        if (isPhone) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: InkWell(
              onTap: () => _openDialPad(trimmed),
              child: Text(
                trimmed,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Color(0xFF2F6FED),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            trimmed,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isBangla = homeController.currentLocale.value.languageCode == 'bn';

    final title = isBangla
        ? (_text(_data?['name_bn']).isNotEmpty
            ? _text(_data?['name_bn'])
            : widget.name)
        : (_text(_data?['name_en']).isNotEmpty
            ? _text(_data?['name_en'])
            : widget.name);

    final icon = _text(_data?['icon']).isNotEmpty
        ? _text(_data?['icon'])
        : widget.iconUrl;

    final details = isBangla
        ? (_text(_data?['details_bn']).isNotEmpty
            ? _text(_data?['details_bn'])
            : _text(_data?['details']))
        : (_text(_data?['details_en']).isNotEmpty
            ? _text(_data?['details_en'])
            : _text(_data?['details']));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFBEE9FF),
                          Color(0xFFDFF8EF),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: icon.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: icon,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.broken_image),
                                  )
                                : const Icon(Icons.local_hospital, size: 50),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Discount Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        details.isNotEmpty
                            ? _clickableDetailsText(details)
                            : const Text(
                                'Details will be Coming soon',
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
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
