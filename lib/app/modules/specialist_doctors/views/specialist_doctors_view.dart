import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/specialist_doctors_controller.dart';
import '../models/subcategory.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/responsive.dart';
import '../../../services/auth_service.dart';

class SpecialistDoctorsView extends GetView<HomeController> {
  const SpecialistDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: const SafeArea(
        child: Column(
          children: [
            _HomeTopBar(),
            Expanded(child: _SpecialistDoctorsGrid()),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.tabIndex.value,
          onTap: (i) {
            if (controller.changeTab(i)) {
              Get.offAllNamed(Routes.HOME);
            }
          },
          selectedItemColor: const Color(0xFF2F6FED),
          unselectedItemColor: const Color(0xFF7A7A7A),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_filled),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.event_note),
              label: 'my_appointments'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: 'my_health'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart),
              label: 'cart'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu),
              label: 'menu'.tr,
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpecialistDoctorsController>();
    final sidePadding = context.w(12);
    final topPadding = context.h(14);
    final bottomPadding = context.h(18);
    final crossAxisSpacing = context.w(8).clamp(6.0, 10.0);

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
            'specialist_doctors_screen'.tr,
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

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: crossAxisSpacing,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _SpecialistServiceCard(
                    subcategory: item,
                    toKey: _toKey(item.name),
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

  const _SpecialistServiceCard({
    required this.subcategory,
    required this.toKey,
  });

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.w(10).clamp(8.0, 12.0);
    final thumbSize = context.w(50).clamp(44.0, 56.0);
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final thumbPx = (thumbSize * dpr).round().clamp(1, 1024);

    final imageProvider =
        subcategory.icon != null && subcategory.icon!.isNotEmpty
            ? NetworkImage(subcategory.icon!)
            : const AssetImage('assets/images/Doctor Services.png')
                as ImageProvider;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Get.toNamed(
          Routes.SPECIALIST_DOCTOR_LIST,
          arguments: {
            'categoryKey': toKey,
            'categoryLabel': subcategory.name,
            'categoryAssetPath': subcategory.icon ?? '',
          },
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
          border: Border.all(color: const Color.fromARGB(255, 185, 218, 213)),
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
                    // cacheWidth/cacheHeight not supported directly for Image with ImageProvider
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subcategory.name,
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

// -------------------- TOP BAR (same as Home) --------------------

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar();

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
        final chipHPad = isSmall ? 10.0 : 12.0;
        final chipVPad = isSmall ? 5.0 : 6.0;

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
                              ? Image.network(
                                  profilePictureUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return Icon(
                                      Icons.person,
                                      size: isSmall ? 18 : 20,
                                      color: Colors.black54,
                                    );
                                  },
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
