// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../routes/app_routes.dart';
// import '../../controllers/popular_services_controller.dart';

// class PopularServicesSection extends StatelessWidget {
//   const PopularServicesSection({super.key});

//   static const _services = <_ServiceItem>[
//     _ServiceItem('specialist_doctors', 'assets/images/Doctor Services.png'),
//     _ServiceItem(
//       'hospitals_booking',
//       'assets/images/Hospitals Booking.png',
//       whiteIconBackground: true,
//     ),
//     _ServiceItem('telemedicine', 'assets/images/Telemedicine.png'),
//     _ServiceItem('pharmacy', 'assets/images/Pharmacy.png'),
//     _ServiceItem('video_consultancy', 'assets/images/Video Consultancy.png'),
//     _ServiceItem('ambulance_services', 'assets/images/Ambulance.png'),
//     _ServiceItem(
//         'community_health_care', 'assets/images/Community health Care.png'),
//     _ServiceItem('hospital_support_services',
//         'assets/images/Hopital Support Services.png'),
//     _ServiceItem('health_insurance', 'assets/images/Health Insurance.png'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(PopularServicesController());

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Text(
//                 'popular_services'.tr,
//                 textAlign: TextAlign.left,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             InkWell(
//               borderRadius: BorderRadius.circular(18),
//               onTap: () => Get.toNamed(Routes.POPULAR_SERVICES),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'All',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF2F6FED),
//                     ),
//                   ),
//                   const SizedBox(width: 6),
//                   Container(
//                     height: 24,
//                     width: 24,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF2F6FED),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward_ios,
//                       size: 12,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Column(
//           children: [
//             Obx(() {
//               final apiItems = controller.items;
//               final isLoading = controller.isLoading.value;
//               final useApi = apiItems.isNotEmpty;
//               final count = useApi ? apiItems.length : _services.length;

//               if (isLoading && apiItems.isEmpty) {
//                 return const SizedBox(
//                   height: 112,
//                   child: Center(
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   ),
//                 );
//               }

//               return LayoutBuilder(builder: (context, constraints) {
//                 final totalWidth = constraints.maxWidth;
//                 const crossCount = 4;
//                 const spacing = 2.0;
//                 const childAspect = 0.76;

//                 final availableWidth = totalWidth;
//                 final itemWidth =
//                     (availableWidth - (crossCount - 1) * spacing) / crossCount;
//                 final itemHeight = itemWidth / childAspect;
//                 final rows = (count / crossCount).ceil();
//                 final gridHeight = rows * itemHeight +
//                     (rows - 1) * spacing +
//                     2; // small buffer

//                 // Use the computed grid height so the grid takes full space
//                 // instead of being artificially capped which caused clipping.
//                 final cappedHeight = gridHeight.toDouble();

//                 return SizedBox(
//                   height: cappedHeight,
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.zero,
//                     itemCount: count,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: crossCount,
//                       crossAxisSpacing: spacing,
//                       mainAxisSpacing: spacing,
//                       childAspectRatio: childAspect,
//                     ),
//                     itemBuilder: (context, i) {
//                       if (useApi) {
//                         final svc = apiItems[i];
//                         return _ServiceCardFromApi(
//                           name: svc.name,
//                           iconUrl: svc.iconUrl,
//                           titleKey: svc.name,
//                           serviceId: svc.id,
//                         );
//                       }
//                       return _ServiceCard(item: _services[i]);
//                     },
//                   ),
//                 );
//               });
//             }),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _ServiceCardFromApi extends StatelessWidget {
//   final String name;
//   final String iconUrl;
//   final String titleKey;
//   final int serviceId;

//   const _ServiceCardFromApi({
//     required this.name,
//     required this.iconUrl,
//     required this.titleKey,
//     required this.serviceId,
//   });

//   void _handleTap() {
//     debugPrint('Popular service tapped: $titleKey');
//     Get.toNamed(
//       Routes.SPECIALIST_DOCTORS,
//       arguments: {
//         'categoryId': serviceId,
//         'categoryLabel': name,
//         'categoryAssetPath': iconUrl,
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       onTap: _handleTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 70,
//               width: 90,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xFFBEE9FF),
//                     Color(0xFFDFF8EF),
//                   ],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x33FFFFFF),
//                     offset: Offset(-3, -3),
//                     blurRadius: 6,
//                   ),
//                   BoxShadow(
//                     color: Color(0x22000000),
//                     offset: Offset(3, 3),
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: SizedBox(
//                   height: 36,
//                   width: 36,
//                   child: iconUrl.isNotEmpty
//                       ? CachedNetworkImage(
//                           imageUrl: iconUrl,
//                           fit: BoxFit.contain,
//                           errorWidget: (_, __, ___) =>
//                               Image.asset('assets/images/Doctor Services.png'),
//                         )
//                       : Image.asset('assets/images/Doctor Services.png'),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 6),
//             Flexible(
//               child: Text(
//                 name,
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.visible,
//                 softWrap: true,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ServiceItem {
//   final String titleKey;
//   final String assetPath;
//   final bool whiteIconBackground;

//   const _ServiceItem(
//     this.titleKey,
//     this.assetPath, {
//     this.whiteIconBackground = false,
//   });
// }

// class _ServiceCard extends StatelessWidget {
//   final _ServiceItem item;
//   const _ServiceCard({required this.item});

//   void _showComingSoon() {
//     Get.toNamed(Routes.COMING_SOON);
//   }

//   void _handleTap() {
//     if (item.titleKey == 'specialist_doctors') {
//       Get.toNamed(Routes.SPECIALIST_DOCTORS);
//       return;
//     }

//     _showComingSoon();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       onTap: _handleTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 80,
//               width: 80,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xFFE0F7FA),
//                     Color(0xFFE8F8FB),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(32),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.08),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: SizedBox(
//                   height: 36,
//                   width: 36,
//                   child: Image.asset(item.assetPath, fit: BoxFit.contain),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 6),
//             Flexible(
//               child: Text(
//                 item.titleKey.tr,
//                 textAlign: TextAlign.center,
//                 maxLines: 3,
//                 overflow: TextOverflow.visible,
//                 softWrap: true,
//                 style: const TextStyle(
//                   fontSize: 11,
//                   height: 1.2,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../controllers/popular_services_controller.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  static const _services = <_ServiceItem>[
    _ServiceItem('specialist_doctors', 'assets/images/Doctor Services.png'),
    _ServiceItem(
      'hospitals_booking',
      'assets/images/Hospitals Booking.png',
      whiteIconBackground: true,
    ),
    _ServiceItem('telemedicine', 'assets/images/Telemedicine.png'),
    _ServiceItem('pharmacy', 'assets/images/Pharmacy.png'),
    _ServiceItem('video_consultancy', 'assets/images/Video Consultancy.png'),
    _ServiceItem('ambulance_services', 'assets/images/Ambulance.png'),
    _ServiceItem(
        'community_health_care', 'assets/images/Community health Care.png'),
    _ServiceItem('hospital_support_services',
        'assets/images/Hopital Support Services.png'),
    _ServiceItem('health_insurance', 'assets/images/Health Insurance.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PopularServicesController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'popular_services'.tr,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => Get.toNamed(Routes.POPULAR_SERVICES),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F6FED),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F6FED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Obx(() {
          final apiItems = controller.items;
          final isLoading = controller.isLoading.value;
          final useApi = apiItems.isNotEmpty;
          final totalItems = useApi ? apiItems.length : _services.length;

          if (isLoading && apiItems.isEmpty) {
            return const SizedBox(
              height: 112,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }

          return _PopularServicesGrid(
            totalItems: totalItems,
            useApi: useApi,
            apiItems: apiItems,
            services: _services,
          );
        }),
      ],
    );
  }
}

// ================== Show More / Close Grid Widget ==================
class _PopularServicesGrid extends StatefulWidget {
  final int totalItems;
  final bool useApi;
  final List<dynamic> apiItems;
  final List<_ServiceItem> services;

  const _PopularServicesGrid({
    required this.totalItems,
    required this.useApi,
    required this.apiItems,
    required this.services,
  });

  @override
  State<_PopularServicesGrid> createState() => _PopularServicesGridState();
}

class _PopularServicesGridState extends State<_PopularServicesGrid> {
  bool _isExpanded = false;

  int get _displayCount => _isExpanded ? widget.totalItems : 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          const crossCount = 4;
          const spacing = 2.0;
          const childAspect = 0.76;

          final availableWidth = constraints.maxWidth;
          final itemWidth =
              (availableWidth - (crossCount - 1) * spacing) / crossCount;
          final itemHeight = itemWidth / childAspect;
          final rows = (_displayCount / crossCount).ceil();
          final gridHeight = rows * itemHeight + (rows - 1) * spacing + 4;

          return SizedBox(
            height: gridHeight,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _displayCount,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: childAspect,
              ),
              itemBuilder: (context, i) {
                if (widget.useApi) {
                  final svc = widget.apiItems[i];
                  return _ServiceCardFromApi(
                    name: svc.localizedName(Get.locale),
                    iconUrl: svc.iconUrl,
                    titleKey: svc.localizedName(Get.locale),
                    serviceId: svc.id,
                  );
                }
                return _ServiceCard(item: widget.services[i]);
              },
            ),
          );
        }),

        // Show More / Close Button
        if (widget.totalItems > 8)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  setState(() => _isExpanded = !_isExpanded);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2F6FED).withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isExpanded ? 'Close' : 'Show More',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2F6FED),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 18,
                        color: const Color(0xFF2F6FED),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ================== Existing Supporting Classes ==================

class _ServiceCardFromApi extends StatelessWidget {
  final String name;
  final String iconUrl;
  final String titleKey;
  final int serviceId;

  const _ServiceCardFromApi({
    required this.name,
    required this.iconUrl,
    required this.titleKey,
    required this.serviceId,
  });

  void _handleTap() {
    debugPrint('Popular service tapped: $titleKey');
    Get.toNamed(
      Routes.SPECIALIST_DOCTORS,
      arguments: {
        'categoryId': serviceId,
        'categoryLabel': name,
        'categoryAssetPath': iconUrl,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _handleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 90,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFBEE9FF), Color(0xFFDFF8EF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33FFFFFF),
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: Color(0x22000000),
                    offset: Offset(3, 3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: iconUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: iconUrl,
                          fit: BoxFit.contain,
                          errorWidget: (_, __, ___) =>
                              Image.asset('assets/images/Doctor Services.png'),
                        )
                      : Image.asset('assets/images/Doctor Services.png'),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.visible,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItem {
  final String titleKey;
  final String assetPath;
  final bool whiteIconBackground;

  const _ServiceItem(
    this.titleKey,
    this.assetPath, {
    this.whiteIconBackground = false,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem item;
  const _ServiceCard({required this.item});

  void _showComingSoon() {
    Get.toNamed(Routes.COMING_SOON);
  }

  void _handleTap() {
    if (item.titleKey == 'specialist_doctors') {
      Get.toNamed(Routes.SPECIALIST_DOCTORS);
      return;
    }
    _showComingSoon();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _handleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE0F7FA), Color(0xFFE8F8FB)],
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: Image.asset(item.assetPath, fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                item.titleKey.tr,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.visible,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
