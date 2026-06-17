
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../notification/controller/notification_controller.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  void _showComingSoon() {
    Get.toNamed(Routes.COMING_SOON);
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final authService = AuthService.to;

    final notificationController = Get.isRegistered<NotificationController>()
        ? Get.find<NotificationController>()
        : Get.put(NotificationController(), permanent: true);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 380;
        final logoSize = isSmall ? 50.0 : 56.0;
        final titleFont = isSmall ? 13.5 : 15.5;
        final chipHPad = isSmall ? 12.0 : 12.0;
        final chipVPad = isSmall ? 6.0 : 8.0;

        Widget notificationIconBtn() {
          return Obx(() {
            final unread = notificationController.unreadCount;

            return SizedBox(
              width: isSmall ? 32 : 36,
              height: isSmall ? 32 : 36,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: isSmall ? 18 : 20,
                    onPressed: () => Get.toNamed(Routes.NOTIFICATIONS),
                    icon: Icon(
                      Icons.notifications_none,
                      size: isSmall ? 20 : 22,
                      color: Colors.black87,
                    ),
                  ),
                  if (unread > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          unread > 99 ? '99+' : unread.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            height: 1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          });
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
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 6),
              notificationIconBtn(),
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
