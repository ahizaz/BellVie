import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';

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
        final logoSize = isSmall ? 50.0 : 56.0;
        final titleFont = isSmall ? 13.5 : 15.5;
        final chipHPad = isSmall ? 12.0 : 12.0;
        final chipVPad = isSmall ? 6.0 : 8.0;

        Widget iconBtn(IconData icon) {
          return SizedBox(
            width: isSmall ? 32 : 36,
            height: isSmall ? 32 : 36,
            child: IconButton(
              padding: EdgeInsets.zero,
              splashRadius: isSmall ? 18 : 20,
              onPressed: _showComingSoon,
              icon: Icon(
                icon,
                size: isSmall ? 20 : 22,
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
            isSmall ? 10 : 12,
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
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'app_title'.tr,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: titleFont,
                    height: 1.1,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              // Obx(() {
              //   final isBangla =
              //       homeController.currentLocale.value.languageCode == 'bn';

              //   return Container(
              //     constraints: BoxConstraints(
              //       minWidth: isSmall ? 115 : 115,
              //       minHeight: isSmall ? 30 : 40,
              //     ),
              //     padding: EdgeInsets.symmetric(
              //       horizontal: chipHPad,
              //       vertical: chipVPad,
              //     ),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFFBFEFE2),
              //       borderRadius: BorderRadius.circular(14),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         InkWell(
              //           onTap: () => homeController
              //               .changeLanguage(const Locale('en', 'US')),
              //           borderRadius: BorderRadius.circular(10),
              //           child: Text(
              //             'Eng',
              //             style: TextStyle(
              //               fontSize: isSmall ? 11.5 : 12,
              //               fontWeight:
              //                   isBangla ? FontWeight.w500 : FontWeight.w600,
              //               color: Colors.black87,
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 6),
              //           child: Container(
              //             width: 1,
              //             height: isSmall ? 12 : 14,
              //             color: Colors.black26,
              //           ),
              //         ),
              //         InkWell(
              //           onTap: () => homeController
              //               .changeLanguage(const Locale('bn', 'BD')),
              //           borderRadius: BorderRadius.circular(10),
              //           child: Text(
              //             'Ban',
              //             style: TextStyle(
              //               fontSize: isSmall ? 11.5 : 12,
              //               fontWeight:
              //                   isBangla ? FontWeight.w600 : FontWeight.w500,
              //               color: Colors.black87,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   );
              // }),
              // Obx(() {
              //   final isBangla =
              //       homeController.currentLocale.value.languageCode == 'bn';
              //   return InkWell(
              //     borderRadius: BorderRadius.circular(14),
              //     onTap: () {
              //       if (isBangla) {
              //         homeController.changeLanguage(const Locale('en', 'US'));
              //       } else {
              //         homeController.changeLanguage(const Locale('bn', 'BD'));
              //       }
              //     },
              //     child: Container(
              //       constraints: BoxConstraints(
              //         minWidth: isSmall ? 80 : 72,
              //         minHeight: isSmall ? 50 : 45,
              //       ),
              //       padding: EdgeInsets.symmetric(
              //         horizontal: chipHPad,
              //         vertical: chipVPad,
              //       ),
              //       decoration: BoxDecoration(
              //         color: const Color(0xFFBFEFE2),
              //         borderRadius: BorderRadius.circular(14),
              //       ),
              //       alignment: Alignment.center,
              //       child: Text(
              //         isBangla ? 'Ban' : 'Eng',
              //         style: TextStyle(
              //           fontSize: isSmall ? 12 : 13,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.black87,
              //         ),
              //       ),
              //     ),
              //   );
              // }),
              Obx(() {
                final isBangla =
                    homeController.currentLocale.value.languageCode == 'bn';

                return PopupMenuButton<String>(
                  offset: const Offset(0, 50), // niche dropdown ashbe
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
              const SizedBox(width: 6),
              // iconBtn(Icons.search),
              iconBtn(Icons.notifications_none),
              const SizedBox(width: 6),
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
                                    size: isSmall ? 18 : 20,
                                    color: Colors.black54,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: isSmall ? 18 : 20,
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
