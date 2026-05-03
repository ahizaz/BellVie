part of '../views/foreign_treatment_view.dart';

class _MainBottomNav extends StatelessWidget {
  final HomeController controller;
  const _MainBottomNav({required this.controller});

  @override
  Widget build(BuildContext context) {
    // Crystal-style capsule bottom navigation
    final items = <Map<String, dynamic>>[
      {'icon': Icons.home_filled, 'label': 'Home'},
      {'icon': Icons.calendar_month, 'label': 'Appointment'},
      {'icon': Icons.call, 'label': 'Call'},
      {'icon': Icons.folder_copy, 'label': 'Records'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];
    const selectedColor = Color(0xFF2F6FED);
    const unselectedColor = Color(0xFF7A7A7A);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Obx(() {
        final current = controller.tabIndex.value;
        return SizedBox(
          height: 64,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 44,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFE6EEF7), width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(items.length, (i) {
                    final item = items[i];
                    final selected = i == current;
                    final isCenter = i == 2;
                    return Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(28),
                        onTap: () => controller.changeTab(i),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isCenter)
                                const SizedBox(height: 6)
                              else
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Icon(
                                    item['icon'] as IconData,
                                    size: selected ? 22 : 20,
                                    color: selected
                                        ? selectedColor
                                        : unselectedColor,
                                  ),
                                ),
                              const SizedBox(height: 3),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 220),
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? selectedColor
                                      : unselectedColor,
                                ),
                                child: Text(
                                  item['label'] as String,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 1),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                height: 2,
                                width: selected && !isCenter ? 16 : 0,
                                decoration: BoxDecoration(
                                  color: selectedColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Positioned(
                top: -6,
                child: Material(
                  color: Colors.transparent,
                  child: InkResponse(
                    onTap: () => controller.changeTab(2),
                      radius: 28,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: selectedColor,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x332F6FED),
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        items[2]['icon'] as IconData,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _BottomNavClipper extends CustomClipper<Path> {
  static const double _notchRadius = 26;
  static const double _notchDepth = 12;
  static const double _notchSmooth = 10;

  @override
  Path getClip(Size size) {
    final centerX = size.width / 2;
    final path = Path()..moveTo(0, 0);

    path.lineTo(centerX - _notchRadius - _notchSmooth, 0);
    path.quadraticBezierTo(
      centerX - _notchRadius,
      0,
      centerX - _notchRadius + 4,
      _notchDepth,
    );
    path.arcToPoint(
      Offset(centerX + _notchRadius - 4, _notchDepth),
      radius: const Radius.circular(_notchRadius),
      clockwise: false,
    );
    path.quadraticBezierTo(
      centerX + _notchRadius,
      0,
      centerX + _notchRadius + _notchSmooth,
      0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _PlaceholderScreen extends StatelessWidget {
  final String titleKey;
  const _PlaceholderScreen({required this.titleKey});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              size: 52,
              color: Color(0xFF2F6FED),
            ),
            const SizedBox(height: 12),
            Text(
              titleKey.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'This section is not available yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F6FED),
                foregroundColor: Colors.white,
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTopBarClone extends StatelessWidget {
  const _HomeTopBarClone();

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
              icon: Icon(icon, size: isSmall ? 20 : 22, color: Colors.black87),
            ),
          );
        }

        return Container(
          color: Colors.white,
          padding:
              EdgeInsets.fromLTRB(12, isSmall ? 8 : 10, 12, isSmall ? 10 : 12),
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
