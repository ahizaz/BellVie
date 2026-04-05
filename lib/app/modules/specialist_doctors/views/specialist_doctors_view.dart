import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/responsive.dart';

class SpecialistDoctorsView extends GetView<HomeController> {
  const SpecialistDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final sidePadding = context.w(12);
    final topPadding = context.h(14);
    final bottomPadding = context.h(18);
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: const [
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              label: 'My Appointments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'My Health',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecialistDoctorsGrid extends StatelessWidget {
  const _SpecialistDoctorsGrid();

  static const List<_SpecialistCategoryItem> _items = [
    _SpecialistCategoryItem(
      title: 'Internal Medicine',
      assetPath: 'assets/images/Internal Medicine.png',
    ),
    _SpecialistCategoryItem(
      title: 'General Physician',
      assetPath: 'assets/images/special doctors/3.General Physician.png',
    ),
    _SpecialistCategoryItem(
      title: 'Neuromedicine',
      assetPath: 'assets/images/special doctors/4.Neuromedicine.png',
    ),
    _SpecialistCategoryItem(
      title: 'Gastroenterology',
      assetPath: 'assets/images/special doctors/Gastroenterology.png',
    ),
    _SpecialistCategoryItem(
      title: 'Urology',
      assetPath: 'assets/images/special doctors/6.urology .png',
    ),
    _SpecialistCategoryItem(
      title: 'Oncology',
      assetPath: 'assets/images/special doctors/7.oncology.png',
    ),
    _SpecialistCategoryItem(
      title: 'Rheumatology',
      assetPath: 'assets/images/special doctors/8.rheumatology .png',
    ),
    _SpecialistCategoryItem(
      title: 'Family Medicine',
      assetPath: 'assets/images/special doctors/9.family medicine.png',
    ),
    _SpecialistCategoryItem(
      title: 'Cardiology',
      assetPath: 'assets/images/special doctors/10.Cardiology .png',
    ),
    _SpecialistCategoryItem(
      title: 'Endocrinology',
      assetPath: 'assets/images/special doctors/11.Endocrinology.png',
    ),
    _SpecialistCategoryItem(
        title: 'Gynaecology and Obstetrics',
        assetPath:
            'assets/images/special doctors/12.Gynaecology and Obstetric.png'),
  ];

  @override
  Widget build(BuildContext context) {
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
          const Text(
            'Specialist Doctors',
            textAlign: TextAlign.center,
            style: TextStyle(
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
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: crossAxisSpacing,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                return _SpecialistServiceCard(item: _items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialistCategoryItem {
  final String title;
  final String assetPath;

  const _SpecialistCategoryItem({
    required this.title,
    required this.assetPath,
  });
}

class _SpecialistServiceCard extends StatelessWidget {
  final _SpecialistCategoryItem item;

  const _SpecialistServiceCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.w(10).clamp(8.0, 12.0);
    final thumbSize = context.w(50).clamp(44.0, 56.0);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // later navigation add korba
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
                  child: Image.asset(
                    item.assetPath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.title,
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

  @override
  Widget build(BuildContext context) {
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
                  'BelleVie Global Health Services',
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: chipHPad,
                  vertical: chipVPad,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFBFEFE2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'বাংলা',
                  style: TextStyle(
                    fontSize: isSmall ? 11.5 : 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
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
