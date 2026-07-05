// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../home/widgets/call_drawer.dart';
// import '../../home/controllers/home_controller.dart';
// import '../../home/widgets/home_bottom_nav.dart';
// import '../controllers/specialist_doctors_controller.dart';
// import '../models/subcategory.dart';
// import '../../../routes/app_routes.dart';
// import '../../../theme/responsive.dart';
// import '../../../services/auth_service.dart';
// import '../../../services/api_service.dart';

// class SpecialistDoctorsView extends GetView<HomeController> {
//   const SpecialistDoctorsView({super.key});

//   Future<void> _onBottomNavTap(BuildContext context, int index) async {
//     if (index == 2) {
//       await showBelleVieCallDrawer(context);
//       return;
//     }

//     if (index == 1) {
//       final isLoggedIn = Get.find<AuthService>().authenticated;

//       if (!isLoggedIn) {
//         await Get.toNamed(Routes.LOGIN);
//         return;
//       }

//       await Get.toNamed('/appointment-list');
//       return;
//     }

//     if (index == 3 || index == 4) {
//       final isLoggedIn = Get.find<AuthService>().authenticated;

//       if (!isLoggedIn) {
//         await Get.toNamed(Routes.LOGIN);
//         return;
//       }

//       Get.offAllNamed(Routes.HOME, arguments: {'tab': index});
//       return;
//     }

//     Get.offAllNamed(Routes.HOME, arguments: {'tab': index});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F2F2),
//       body: const SafeArea(
//         child: Column(
//           children: [
//             HomeTopBar(),
//             Expanded(child: _SpecialistDoctorsGrid()),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Obx(
//         () => HomeBottomNav(
//           currentIndex: controller.tabIndex.value,
//           onTap: (i) => _onBottomNavTap(context, i),
//         ),
//       ),
//     );
//   }
// }

// class _SpecialistDoctorsGrid extends StatelessWidget {
//   const _SpecialistDoctorsGrid();

//   String _toKey(String s) {
//     final key = s
//         .toLowerCase()
//         .replaceAll(RegExp(r"[^a-z0-9]+"), '_')
//         .replaceAll(RegExp(r'_+'), '_')
//         .trim();
//     return key;
//   }

//   String _screenTitle() {
//     final args = Get.arguments;
//     final rawLabel = args is Map ? args['categoryLabel'] : null;
//     final label = (rawLabel ?? '').toString().trim();

//     if (label.isEmpty) {
//       return 'specialist_doctors_screen'.tr;
//     }

//     return label.split(RegExp(r'\s+')).map((word) {
//       if (word.isEmpty) return word;
//       if (word.length == 1) return word.toUpperCase();
//       return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
//     }).join(' ');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<SpecialistDoctorsController>();
//     final sidePadding = context.w(12);
//     final topPadding = context.h(14);
//     final bottomPadding = context.h(18);
//     final crossAxisSpacing = context.w(8).clamp(6.0, 10.0);

//     return SingleChildScrollView(
//       padding: EdgeInsets.fromLTRB(
//         sidePadding,
//         topPadding,
//         sidePadding,
//         bottomPadding,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             _screenTitle(),
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEEEEEE),
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color(0x33000000),
//                   blurRadius: 10,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Obx(() {
//               final items = controller.items;

//               if (items.isEmpty) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 24),
//                   child: Center(
//                     child: Text(
//                       'No subcategories available right now.',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black54,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 );
//               }

//               return GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: items.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: crossAxisSpacing,
//                   mainAxisSpacing: crossAxisSpacing,
//                   childAspectRatio: 1.2,
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return _SpecialistServiceCard(
//                     subcategory: item,
//                     toKey: _toKey(item.nameEn),
//                     categoryId: item.category,
//                     subcategoryId: item.id,
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SpecialistServiceCard extends StatelessWidget {
//   final Subcategory subcategory;
//   final String toKey;
//   final int? categoryId;
//   final int? subcategoryId;

//   const _SpecialistServiceCard({
//     required this.subcategory,
//     required this.toKey,
//     this.categoryId,
//     this.subcategoryId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cardPadding = context.w(10).clamp(8.0, 12.0);
//     final thumbSize = context.w(50).clamp(44.0, 56.0);
//     final imageProvider =
//         subcategory.icon != null && subcategory.icon!.isNotEmpty
//             ? CachedNetworkImageProvider(
//                 AppApiService.resolveImageUrl(subcategory.icon!),
//               )
//             : const AssetImage('assets/images/Doctor Services.png')
//                 as ImageProvider;

//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       onTap: () {
//         final Map<String, dynamic> args = {
//           'categoryKey': toKey,
//           'categoryLabel': subcategory.localizedName(Get.locale),
//           'categoryAssetPath': subcategory.icon ?? '',
//         };

//         if (categoryId != null) args['categoryId'] = categoryId;
//         if (subcategoryId != null) args['subcategoryId'] = subcategoryId;

//         Get.toNamed(
//           Routes.SPECIALIST_DOCTOR_LIST,
//           arguments: args,
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.fromLTRB(
//           cardPadding,
//           cardPadding,
//           cardPadding,
//           context.w(8).clamp(6.0, 10.0),
//         ),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 215, 240, 237),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: const Color.fromARGB(255, 185, 218, 213),
//           ),
//           boxShadow: const [
//             BoxShadow(
//               color: Color(0x22000000),
//               blurRadius: 8,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Center(
//                 child: SizedBox(
//                   height: thumbSize,
//                   width: thumbSize,
//                   child: Image(
//                     image: imageProvider,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               subcategory.localizedName(Get.locale),
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 fontSize: 12,
//                 height: 1.15,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // -------------------- TOP BAR (same as Home) --------------------

// class HomeTopBar extends StatelessWidget {
//   const HomeTopBar({super.key});

//   void _showComingSoon() {
//     Get.toNamed(Routes.COMING_SOON);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final homeController = Get.find<HomeController>();
//     final authService = AuthService.to;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final isSmall = constraints.maxWidth < 380;

//         final logoSize = isSmall ? 42.0 : 46.0;
//         final titleFont = isSmall ? 12.5 : 14.0;
//         final chipHPad = isSmall ? 20.0 : 20.0;
//         final chipVPad = isSmall ? 8.0 : 8.0;

//         Widget iconBtn(IconData icon, {VoidCallback? onPressed}) {
//           return SizedBox(
//             width: isSmall ? 30 : 32,
//             height: isSmall ? 40 : 32,
//             child: IconButton(
//               padding: EdgeInsets.zero,
//               splashRadius: isSmall ? 16 : 18,
//               onPressed: onPressed ?? _showComingSoon,
//               icon: Icon(
//                 icon,
//                 size: isSmall ? 18 : 20,
//                 color: Colors.black87,
//               ),
//             ),
//           );
//         }

//         return Container(
//           color: Colors.white,
//           padding: EdgeInsets.fromLTRB(
//             12,
//             isSmall ? 8 : 10,
//             12,
//             isSmall ? 8 : 10,
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 width: logoSize,
//                 height: logoSize,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 clipBehavior: Clip.antiAlias,
//                 child: const Image(
//                   image: AssetImage('assets/images/Belle Vie Logo.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 2),
//                   child: Text(
//                     'app_title'.tr,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: true,
//                     style: TextStyle(
//                       fontSize: titleFont,
//                       height: 1.05,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 3),
//               Obx(() {
//                 final isBangla =
//                     homeController.currentLocale.value.languageCode == 'bn';

//                 return PopupMenuButton<String>(
//                   offset: const Offset(0, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   color: const Color(0xFFE9E1EA),
//                   onSelected: (value) {
//                     if (value == 'en') {
//                       homeController.changeLanguage(const Locale('en', 'US'));
//                     } else {
//                       homeController.changeLanguage(const Locale('bn', 'BD'));
//                     }
//                   },
//                   itemBuilder: (context) => [
//                     PopupMenuItem(
//                       value: 'en',
//                       child: Text(
//                         'Eng',
//                         style: TextStyle(
//                           fontSize: isSmall ? 12 : 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     PopupMenuItem(
//                       value: 'bn',
//                       child: Text(
//                         'বাংলা',
//                         style: TextStyle(
//                           fontSize: isSmall ? 12 : 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                   child: Container(
//                     constraints: BoxConstraints(
//                       minWidth: isSmall ? 70 : 60,
//                       minHeight: isSmall ? 40 : 45,
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: chipHPad,
//                       vertical: chipVPad,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFEFEFEF),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       isBangla ? 'বাংলা' : 'Eng',
//                       style: TextStyle(
//                         fontSize: isSmall ? 15 : 15,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//               const SizedBox(width: 4),
//               iconBtn(
//                 Icons.notifications_none,
//                 onPressed: () => Get.toNamed(Routes.NOTIFICATIONS),
//               ),
//               const SizedBox(width: 4),
//               Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () => Get.toNamed(Routes.PROFILE),
//                   customBorder: const CircleBorder(),
//                   child: Obx(() {
//                     final avatarBytes = authService.profileAvatarBytes.value;
//                     final profilePictureUrl =
//                         authService.profilePictureUrl.value;

//                     return Container(
//                       width: isSmall ? 32 : 34,
//                       height: isSmall ? 32 : 34,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xFFEFEFEF),
//                       ),
//                       clipBehavior: Clip.antiAlias,
//                       child: avatarBytes != null
//                           ? Image.memory(
//                               avatarBytes,
//                               fit: BoxFit.cover,
//                             )
//                           : profilePictureUrl.isNotEmpty
//                               ? CachedNetworkImage(
//                                   imageUrl: profilePictureUrl,
//                                   fit: BoxFit.cover,
//                                   errorWidget: (_, __, ___) => Icon(
//                                     Icons.person,
//                                     size: isSmall ? 17 : 18,
//                                     color: Colors.black54,
//                                   ),
//                                 )
//                               : Icon(
//                                   Icons.person,
//                                   size: isSmall ? 17 : 18,
//                                   color: Colors.black54,
//                                 ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/widgets/call_drawer.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/widgets/home_bottom_nav.dart';
import '../controllers/specialist_doctors_controller.dart';
import '../models/subcategory.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/responsive.dart';
import '../../../services/auth_service.dart';
import '../../../services/api_service.dart';

class SpecialistDoctorsView extends GetView<HomeController> {
  const SpecialistDoctorsView({super.key});

  Future<void> _onBottomNavTap(BuildContext context, int index) async {
    if (index == 2) {
      await showBelleVieCallDrawer(context);
      return;
    }

    if (index == 1) {
      final isLoggedIn = Get.find<AuthService>().authenticated;

      if (!isLoggedIn) {
        await Get.toNamed(Routes.LOGIN);
        return;
      }

      await Get.toNamed('/appointment-list');
      return;
    }

    if (index == 3 || index == 4) {
      final isLoggedIn = Get.find<AuthService>().authenticated;

      if (!isLoggedIn) {
        await Get.toNamed(Routes.LOGIN);
        return;
      }

      Get.offAllNamed(Routes.HOME, arguments: {'tab': index});
      return;
    }

    Get.offAllNamed(Routes.HOME, arguments: {'tab': index});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: const SafeArea(
        child: Column(
          children: [
            HomeTopBar(),
            Expanded(child: _SpecialistDoctorsGrid()),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => HomeBottomNav(
          currentIndex: controller.tabIndex.value,
          onTap: (i) => _onBottomNavTap(context, i),
        ),
      ),
    );
  }
}

class _SpecialistDoctorsGrid extends StatelessWidget {
  const _SpecialistDoctorsGrid();

  String _toKey(String s) {
    final key = s
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-z0-9]+"), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .trim();
    return key;
  }

  String _screenTitle() {
    final args = Get.arguments;
    final rawLabel = args is Map ? args['categoryLabel'] : null;
    final label = (rawLabel ?? '').toString().trim();

    if (label.isEmpty) {
      return 'specialist_doctors_screen'.tr;
    }

    return label.split(RegExp(r'\s+')).map((word) {
      if (word.isEmpty) return word;
      if (word.length == 1) return word.toUpperCase();
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
  }

  bool _isHospitalBookingCategory() {
    final args = Get.arguments;
    final rawLabel = args is Map ? args['categoryLabel'] : null;
    final label = (rawLabel ?? '').toString().toLowerCase().trim();

    return label.contains('hospital booking') ||
        label.contains('hospitals booking');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpecialistDoctorsController>();
    final sidePadding = context.w(12);
    final topPadding = context.h(14);
    final bottomPadding = context.h(18);
    final crossAxisSpacing = context.w(8).clamp(6.0, 10.0);
    final isHospitalBooking = _isHospitalBookingCategory();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        sidePadding,
        topPadding,
        sidePadding,
        bottomPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _screenTitle(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Obx(() {
              final items = controller.items;
              final totalItems =
                  isHospitalBooking ? items.length + 1 : items.length;

              if (items.isEmpty && !isHospitalBooking) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No subcategories available right now.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: totalItems,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: crossAxisSpacing,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  if (isHospitalBooking && index == items.length) {
                    return const _HospitalPackageCard();
                  }

                  final item = items[index];

                  return _SpecialistServiceCard(
                    subcategory: item,
                    toKey: _toKey(item.nameEn),
                    categoryId: item.category,
                    subcategoryId: item.id,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _SpecialistServiceCard extends StatelessWidget {
  final Subcategory subcategory;
  final String toKey;
  final int? categoryId;
  final int? subcategoryId;

  const _SpecialistServiceCard({
    required this.subcategory,
    required this.toKey,
    this.categoryId,
    this.subcategoryId,
  });

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.w(10).clamp(8.0, 12.0);
    final thumbSize = context.w(50).clamp(44.0, 56.0);
    final imageProvider =
        subcategory.icon != null && subcategory.icon!.isNotEmpty
            ? CachedNetworkImageProvider(
                AppApiService.resolveImageUrl(subcategory.icon!),
              )
            : const AssetImage('assets/images/Doctor Services.png')
                as ImageProvider;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final Map<String, dynamic> args = {
          'categoryKey': toKey,
          'categoryLabel': subcategory.localizedName(Get.locale),
          'categoryAssetPath': subcategory.icon ?? '',
        };

        if (categoryId != null) args['categoryId'] = categoryId;
        if (subcategoryId != null) args['subcategoryId'] = subcategoryId;

        Get.toNamed(
          Routes.SPECIALIST_DOCTOR_LIST,
          arguments: args,
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
          cardPadding,
          cardPadding,
          cardPadding,
          context.w(8).clamp(6.0, 10.0),
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 240, 237),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color.fromARGB(255, 185, 218, 213),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  height: thumbSize,
                  width: thumbSize,
                  child: Image(
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subcategory.localizedName(Get.locale),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                height: 1.15,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HospitalPackageCard extends StatelessWidget {
  const _HospitalPackageCard();

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.w(10).clamp(8.0, 12.0);
    final thumbSize = context.w(50).clamp(44.0, 56.0);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        final isLoggedIn = Get.find<AuthService>().authenticated;

        if (!isLoggedIn) {
          await Get.toNamed(Routes.LOGIN);
          return;
        }

        Get.toNamed(Routes.HOSPITAL_PACKAGE);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
          cardPadding,
          cardPadding,
          cardPadding,
          context.w(8).clamp(6.0, 10.0),
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 240, 237),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color.fromARGB(255, 185, 218, 213),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  height: thumbSize,
                  width: thumbSize,
                  child: Image.asset(
                    'assets/images/special doctors/hospital (1).png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Hospital Package',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                height: 1.15,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- TOP BAR (same as Home) --------------------

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  void _showComingSoon() {
    Get.toNamed(Routes.COMING_SOON);
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final authService = AuthService.to;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 380;

        final logoSize = isSmall ? 42.0 : 46.0;
        final titleFont = isSmall ? 12.5 : 14.0;
        final chipHPad = isSmall ? 20.0 : 20.0;
        final chipVPad = isSmall ? 8.0 : 8.0;

        Widget iconBtn(IconData icon, {VoidCallback? onPressed}) {
          return SizedBox(
            width: isSmall ? 30 : 32,
            height: isSmall ? 40 : 32,
            child: IconButton(
              padding: EdgeInsets.zero,
              splashRadius: isSmall ? 16 : 18,
              onPressed: onPressed ?? _showComingSoon,
              icon: Icon(
                icon,
                size: isSmall ? 18 : 20,
                color: Colors.black87,
              ),
            ),
          );
        }

        return Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(
            12,
            isSmall ? 8 : 10,
            12,
            isSmall ? 8 : 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: logoSize,
                height: logoSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                clipBehavior: Clip.antiAlias,
                child: const Image(
                  image: AssetImage('assets/images/Belle Vie Logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    'app_title'.tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: titleFont,
                      height: 1.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Obx(() {
                final isBangla =
                    homeController.currentLocale.value.languageCode == 'bn';

                return PopupMenuButton<String>(
                  offset: const Offset(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  color: const Color(0xFFE9E1EA),
                  onSelected: (value) {
                    if (value == 'en') {
                      homeController.changeLanguage(const Locale('en', 'US'));
                    } else {
                      homeController.changeLanguage(const Locale('bn', 'BD'));
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'en',
                      child: Text(
                        'Eng',
                        style: TextStyle(
                          fontSize: isSmall ? 12 : 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'bn',
                      child: Text(
                        'বাংলা',
                        style: TextStyle(
                          fontSize: isSmall ? 12 : 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: isSmall ? 70 : 60,
                      minHeight: isSmall ? 40 : 45,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: chipHPad,
                      vertical: chipVPad,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isBangla ? 'বাংলা' : 'Eng',
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 4),
              iconBtn(
                Icons.notifications_none,
                onPressed: () => Get.toNamed(Routes.NOTIFICATIONS),
              ),
              const SizedBox(width: 4),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.PROFILE),
                  customBorder: const CircleBorder(),
                  child: Obx(() {
                    final avatarBytes = authService.profileAvatarBytes.value;
                    final profilePictureUrl =
                        authService.profilePictureUrl.value;

                    return Container(
                      width: isSmall ? 32 : 34,
                      height: isSmall ? 32 : 34,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEFEFEF),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: avatarBytes != null
                          ? Image.memory(
                              avatarBytes,
                              fit: BoxFit.cover,
                            )
                          : profilePictureUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: profilePictureUrl,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => Icon(
                                    Icons.person,
                                    size: isSmall ? 17 : 18,
                                    color: Colors.black54,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: isSmall ? 17 : 18,
                                  color: Colors.black54,
                                ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
