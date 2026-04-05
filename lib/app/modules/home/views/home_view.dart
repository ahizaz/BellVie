// app/modules/home/views/home_view.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../foreign_treatment/views/foreign_treatment_view.dart';
import '../../../theme/responsive.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBar(),
              Expanded(child: _TabBody(index: controller.tabIndex.value)),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTab,
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
      );
    });
  }
}

class _TabBody extends StatelessWidget {
  final int index;
  const _TabBody({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _HomeTab();
      case 1:
        return const _PlaceholderScreen(title: 'My Appointments');
      case 2:
        return const _PlaceholderScreen(title: 'My Health');
      case 3:
        return const _PlaceholderScreen(title: 'Cart');
      case 4:
        return const _PlaceholderScreen(title: 'Menu');
      default:
        return const SizedBox.shrink();
    }
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.w(12);
    final topPadding = context.h(12);
    final bottomPadding = context.h(20);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        bottomPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _BannerCarousel(),
          SizedBox(height: 14),
          _EmergencyServicesTab(),
          SizedBox(height: 14),
          _ContactUsTab(),
          SizedBox(height: 14),
          _PopularServicesSection(),
          SizedBox(height: 18),
          _PromoBannerCarousel(),
          SizedBox(height: 18),
          _ForeignTreatmentSection(),
          SizedBox(height: 18),
          _CoreFourSection(),
          SizedBox(height: 18),
          _MedicalAccessoriesSection(),
        ],
      ),
    );
  }
}

class _EmergencyServicesTab extends StatelessWidget {
  const _EmergencyServicesTab();

  @override
  Widget build(BuildContext context) {
    final cardRadius = context.w(18).clamp(16.0, 20.0);
    final iconSize = context.w(54).clamp(46.0, 58.0);
    final gap = context.w(12).clamp(10.0, 14.0);
    return InkWell(
      borderRadius: BorderRadius.circular(cardRadius),
      onTap: () {
        // Get.toNamed(Routes.EMERGENCY_SERVICES);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.w(12),
          context.w(12),
          context.w(12),
          context.w(12),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD6D6),
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(color: const Color(0xFFFFB3B3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(context.w(8)),
              child: Image.asset(
                'assets/images/Emergency.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: gap),
            const Expanded(
              child: Text(
                'Emergency Services',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

//-------------------- Contact Us Services -------------------------------

class _ContactUsTab extends StatelessWidget {
  const _ContactUsTab();

  @override
  Widget build(BuildContext context) {
    final cardHeight = context.h(70).clamp(62.0, 78.0);
    final iconSize = context.w(50).clamp(44.0, 54.0);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // ekhane pore route dite paro
        // Get.toNamed(Routes.CONTACT_US);
      },
      child: Container(
        height: cardHeight,
        padding: EdgeInsets.symmetric(horizontal: context.w(14)),
        decoration: BoxDecoration(
          color: const Color(0xFFCDEFF2),
          borderRadius: BorderRadius.circular(context.w(16)),
          border: Border.all(color: const Color.fromARGB(255, 160, 212, 208)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 6,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: iconSize,
              height: iconSize,
              child: Image.asset(
                'assets/images/Contact Us.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: context.w(14)),
            const Expanded(
              child: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- POPULAR SERVICES --------------------

class _PopularServicesSection extends StatelessWidget {
  const _PopularServicesSection();

  static const _services = <_ServiceItem>[
    _ServiceItem(
      title: 'Specialist Doctors',
      assetPath: 'assets/images/Doctor Services.png',
    ),
    _ServiceItem(
      title: 'Hospitals Booking',
      assetPath: 'assets/images/Hospitals Booking.png',
    ),
    _ServiceItem(
      title: 'Telemedicine',
      assetPath: 'assets/images/Telemedicine.png',
    ),
    _ServiceItem(
      title: 'Pharmacy',
      assetPath: 'assets/images/Pharmacy.png',
    ),
    _ServiceItem(
      title: 'Video Consultancy',
      assetPath: 'assets/images/Video Consultancy.png',
    ),
    _ServiceItem(
      title: 'Ambulance Services',
      assetPath: 'assets/images/Ambulance.png',
    ),
    _ServiceItem(
      title: 'Community Health Care',
      assetPath: 'assets/images/Community health Care.png',
    ),
    _ServiceItem(
      title: 'Hospital Support Services',
      assetPath: 'assets/images/Hopital Support Services.png',
    ),
    _ServiceItem(
      title: 'Health Insurance',
      assetPath: 'assets/images/Health Insurance.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Popular Services',
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
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, i) => _ServiceCard(item: _services[i]),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFDADADA),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w(16)),
                    ),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ServiceItem {
  final String title;
  final String assetPath;
  const _ServiceItem({required this.title, required this.assetPath});
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem item;
  const _ServiceCard({required this.item});

  void _handleTap() {
    if (item.title == 'Specialist Doctors') {
      Get.toNamed(Routes.SPECIALIST_DOCTORS);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
        decoration: BoxDecoration(
          color: const Color(0xFFCFEDEA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFB3DAD6)),
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
                  height: 50,
                  width: 50,
                  child: Image.asset(item.assetPath, fit: BoxFit.contain),
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
                fontSize: 10,
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

// -------------------- PLACEHOLDER --------------------

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// -------------------- TOP BAR --------------------

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

// -------------------- TOP BANNER (AUTO SCROLL) --------------------

class _BannerCarousel extends StatefulWidget {
  const _BannerCarousel();

  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  static const _banners = <String>[
    'assets/images/banners/bannar_update_1.png',
    'assets/images/banners/bannar_update_2.png',
    'assets/images/banners/Third.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;

      final next = (_index + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 165,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView.builder(
              controller: _controller,
              itemCount: _banners.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) {
                return Image.asset(
                  _banners[i],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 16 : 7,
              height: 7,
              decoration: BoxDecoration(
                color:
                    active ? const Color(0xFF6B6B6B) : const Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// -------------------- PROMO BANNER (AUTO SCROLL) --------------------

class _PromoBannerCarousel extends StatefulWidget {
  const _PromoBannerCarousel();

  @override
  State<_PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<_PromoBannerCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  static const _banners = <String>[
    'assets/images/banners/promo1.png',
    'assets/images/banners/promo2.png',
    'assets/images/banners/promo3.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;

      final next = (_index + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView.builder(
              controller: _controller,
              itemCount: _banners.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) {
                return Image.asset(
                  _banners[i],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 16 : 7,
              height: 7,
              decoration: BoxDecoration(
                color:
                    active ? const Color(0xFF6B6B6B) : const Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// -------------------- FOREIGN TREATMENT --------------------

class _ForeignTreatmentSection extends StatelessWidget {
  const _ForeignTreatmentSection();

  static const _countries = <_ForeignTreatmentItem>[
    _ForeignTreatmentItem(
      title: 'Hospitals in India',
      assetPath: 'assets/images/Flag_of_India.png',
    ),
    _ForeignTreatmentItem(
      title: 'Hospitals in Chaina',
      assetPath: 'assets/images/Chaina.png',
    ),
    _ForeignTreatmentItem(
      title: 'Hospitals in Thailand',
      assetPath: 'assets/images/Thailand.jpg',
    ),
    _ForeignTreatmentItem(
      title: 'Hospitals in Turkey',
      assetPath: 'assets/images/Turkey.jpg',
    ),
    _ForeignTreatmentItem(
      title: 'Hospitals in Singapore',
      assetPath: 'assets/images/Singapore.jpg',
    ),
    _ForeignTreatmentItem(
      title: 'Hospitals in Malaysia',
      assetPath: 'assets/images/Malaysia.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Foreign Treatment',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _countries.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.32,
          ),
          itemBuilder: (context, i) {
            return _ForeignTreatmentCard(item: _countries[i]);
          },
        ),
      ],
    );
  }
}

class _ForeignTreatmentItem {
  final String title;
  final String assetPath;
  const _ForeignTreatmentItem({required this.title, required this.assetPath});
}

class _ForeignTreatmentCard extends StatelessWidget {
  final _ForeignTreatmentItem item;
  const _ForeignTreatmentCard({required this.item});

  void _handleTap() {
    switch (item.title) {
      case 'Hospitals in India':
        Get.to(() => const IndiaHospitalsView());
        break;

      case 'Hospitals in Chaina':
        Get.to(() => const ChainaHospitalsView());
        break;

      case 'Hospitals in Thailand':
        Get.to(() => const ThailandHospitalsView());
        break;

      case 'Hospitals in Turkey':
        Get.to(() => const TurkeyHospitalsView());
        break;

      case 'Hospitals in Singapore':
        Get.to(() => const SingaporeHospitalsView());
        break;

      case 'Hospitals in Malaysia':
        Get.to(() => const MalaysiaHospitalsView());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
        decoration: BoxDecoration(
          color: const Color(0xFFCFEDEA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 52,
                  width: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Image.asset(
                      item.assetPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                height: 1.15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoreFourSection extends StatelessWidget {
  const _CoreFourSection();

  static const _items = <_CoreFourItemData>[
    _CoreFourItemData(
      title: 'Telemedicine /\nVideo Consultancy',
      assetPath: 'assets/images/core_four/telemedicine_video.png',
      bgColor: Color(0xFFCFEDEA),
    ),
    _CoreFourItemData(
      title: 'ENT Doctor Services',
      assetPath: 'assets/images/core_four/ent_doctor.png',
      bgColor: Color.fromARGB(255, 175, 204, 238),
    ),
    _CoreFourItemData(
      title: 'Diagnostic Services',
      assetPath: 'assets/images/core_four/Diagnostic Services.png',
      bgColor: Color.fromARGB(255, 175, 204, 238),
    ),
    _CoreFourItemData(
      title: 'Doctors Services',
      assetPath: 'assets/images/core_four/Doctor Services.png',
      bgColor: Color(0xFFCFEDEA),
    ),
  ];

  Widget _otherMedicalTile(String title, String assetPath,
      {VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F0F2),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                assetPath,
                width: 44,
                height: 44,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomTabsRow() {
    final items = const [
      _BottomTabItem(
        'Air\nAmbulance',
        'assets/images/air_ambulance_logo.png',
      ),
      _BottomTabItem(
        'Palliative\nCare Services',
        'assets/images/palliative care services.png',
      ),
      _BottomTabItem(
        'Geriatric Health\nServices',
        'assets/images/geriatric_health_logo.png',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 10.0;
        final itemW = (constraints.maxWidth - gap * 2) / 3;
        final itemH = itemW * 0.95;

        return Row(
          children: List.generate(items.length, (i) {
            final it = items[i];
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Container(
                  height: itemH,
                  margin: EdgeInsets.only(right: i == 2 ? 0 : gap),
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCFEDEA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFB3DAD6)),
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
                      SizedBox(
                        height: itemH * 0.45,
                        child: Image.asset(
                          it.assetPath,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Center(
                          child: Text(
                            it.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              height: 1.15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Core Four',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, i) => _CoreFourCard(item: _items[i]),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Other Medical Services',
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
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.9,
            children: [
              _otherMedicalTile(
                'Psychiatrist',
                'assets/images/Psychiatrist.png',
              ),
              _otherMedicalTile(
                'Counseling Psychologist',
                'assets/images/Counselling Psychologist.png',
              ),
              _otherMedicalTile(
                'Dentists',
                'assets/images/Dentists.png',
              ),
              _otherMedicalTile(
                'Stem Therapy',
                'assets/images/Stem Therapy.png',
              ),
              _otherMedicalTile(
                'Caregiver Services',
                'assets/images/Caregiver Services.png',
              ),
              _otherMedicalTile(
                'Physiotherapist',
                'assets/images/Physiotherapist.png',
              ),
              _otherMedicalTile(
                'Chiropractic  Services',
                'assets/images/Chiropractic Sertvices.png',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _bottomTabsRow(),
      ],
    );
  }
}

class _BottomTabItem {
  final String title;
  final String assetPath;
  const _BottomTabItem(this.title, this.assetPath);
}

class _CoreFourItemData {
  final String title;
  final String assetPath;
  final Color bgColor;

  const _CoreFourItemData({
    required this.title,
    required this.assetPath,
    required this.bgColor,
  });
}

class _CoreFourCard extends StatelessWidget {
  final _CoreFourItemData item;
  const _CoreFourCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
        decoration: BoxDecoration(
          color: item.bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFB3DAD6)),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 72,
              child: Center(
                child: Image.asset(
                  item.assetPath,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                height: 1.2,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- MEDICAL ACCESSORIES --------------------

class _MedicalAccessoriesSection extends StatelessWidget {
  const _MedicalAccessoriesSection();

  static const _items = <_MedicalAccessoryItem>[
    _MedicalAccessoryItem(
      title: 'Diagnostic\nDevices',
      assetPath: 'assets/images/Diagnostic devices.png',
    ),
    _MedicalAccessoryItem(
      title: 'Home Care/\nFurniture',
      assetPath: 'assets/images/Home Care.png',
    ),
    _MedicalAccessoryItem(
      title: 'Wound Care &\nPersonal Care',
      assetPath: 'assets/images/Wound Care & Personal Care.png',
    ),
    _MedicalAccessoryItem(
      title: 'First Aid\nSupplies',
      assetPath: 'assets/images/First Aid  Supplies.png',
    ),
    _MedicalAccessoryItem(
      title: 'Face Masks and Gloves',
      assetPath: 'assets/images/Face Masks and Gloves.png',
    ),
    _MedicalAccessoryItem(
      title: 'Mobility Aids',
      assetPath: 'assets/images/Mobility Aids.png',
    ),
    _MedicalAccessoryItem(
      title: 'Respiratory Units',
      assetPath: 'assets/images/Respiratory Units.png',
    ),
    _MedicalAccessoryItem(
      title: 'Bed Wedges',
      assetPath: 'assets/images/Bed Wedges.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Medical accessories',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.0,
            ),
            itemBuilder: (context, i) {
              return _MedicalAccessoryCard(item: _items[i]);
            },
          ),
        ),
      ],
    );
  }
}

class _MedicalAccessoryItem {
  final String title;
  final String assetPath;
  const _MedicalAccessoryItem({required this.title, required this.assetPath});
}

class _MedicalAccessoryCard extends StatelessWidget {
  final _MedicalAccessoryItem item;
  const _MedicalAccessoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 221, 241, 240),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color.fromARGB(255, 197, 228, 225),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              height: 46,
              width: 46,
              child: Image.asset(item.assetPath, fit: BoxFit.contain),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9,
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
