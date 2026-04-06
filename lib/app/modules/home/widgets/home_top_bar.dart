import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 380;
        final logoSize = isSmall ? 50.0 : 56.0;
        final titleFont = isSmall ? 13.5 : 15.5;
        final chipHPad = isSmall ? 10.0 : 12.0;
        final chipVPad = isSmall ? 5.0 : 6.0;

        Widget iconBtn(IconData icon) {
          return SizedBox(
            width: isSmall ? 32 : 36,
            height: isSmall ? 32 : 36,
            child: IconButton(
              padding: EdgeInsets.zero,
              splashRadius: isSmall ? 18 : 20,
              onPressed: () {},
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
              const SizedBox(width: 8),
              PopupMenuButton<Locale>(
                onSelected: homeController.changeLanguage,
                offset: const Offset(0, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: const Locale('en', 'US'),
                    child: Text('english'.tr),
                  ),
                  PopupMenuItem(
                    value: const Locale('bn', 'BD'),
                    child: Text('bangla'.tr),
                  ),
                ],
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: chipHPad,
                    vertical: chipVPad,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBFEFE2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Obx(() {
                    final isBangla =
                        homeController.currentLocale.value.languageCode == 'bn';
                    return Text(
                      isBangla ? 'bangla'.tr : 'english'.tr,
                      style: TextStyle(
                        fontSize: isSmall ? 11.5 : 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 6),
              iconBtn(Icons.search),
              iconBtn(Icons.notifications_none),
              const SizedBox(width: 6),
              Container(
                width: isSmall ? 32 : 34,
                height: isSmall ? 32 : 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEFEFEF),
                ),
                child: Icon(
                  Icons.person,
                  size: isSmall ? 18 : 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
