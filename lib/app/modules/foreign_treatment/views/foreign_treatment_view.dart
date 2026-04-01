import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

/// ===============================
/// FOREIGN TREATMENT (MAIN) PAGE
/// ===============================
class ForeignTreatmentView extends GetView<HomeController> {
  const ForeignTreatmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child:
                    _ForeignTreatmentTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

class _ForeignTreatmentTabBody extends StatelessWidget {
  final int index;
  const _ForeignTreatmentTabBody({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _ForeignTreatmentHome();
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

class _ForeignTreatmentHome extends StatelessWidget {
  const _ForeignTreatmentHome();

  static const _countries = <_CountryCardData>[
    _CountryCardData(
      title: 'India',
      assetPath: 'assets/images/Flag_of_India.png',
    ),
    _CountryCardData(
      title: 'Thailand',
      assetPath: 'assets/images/Thailand.jpg',
    ),
    _CountryCardData(
      title: 'Turkey',
      assetPath: 'assets/images/Turkey.jpg',
    ),
  ];

  void _openCountry(String title) {
    switch (title) {
      case 'India':
        Get.to(() => const IndiaHospitalsView());
        break;
      case 'Thailand':
        Get.to(() => const ThailandHospitalsView());
        break;
      case 'Turkey':
        Get.to(() => const TurkeyHospitalsView());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Foreign Treatment',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
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
            itemBuilder: (context, index) {
              final item = _countries[index];
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _openCountry(item.title),
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
                          fontSize: 10,
                          height: 1.15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

class _CountryCardData {
  final String title;
  final String assetPath;
  const _CountryCardData({required this.title, required this.assetPath});
}

/// ===============================
/// INDIA HOSPITALS PAGE
/// ===============================
class IndiaHospitalsView extends GetView<HomeController> {
  const IndiaHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _IndiaHospitalsTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

class _IndiaHospitalsTabBody extends StatelessWidget {
  final int index;
  const _IndiaHospitalsTabBody({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _IndiaHospitalsHome();
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

class _IndiaHospitalsHome extends StatelessWidget {
  const _IndiaHospitalsHome();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'India Hospitals',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: const [
                _HospitalTile(
                  hospital: 'Jaslok (All India)',
                  status: 'Done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Nanavati Max (All India)',
                  status: 'Done',
                  countText: 'Max Healthcare: 22',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Apollo pan India (All India)',
                  status: 'Done',
                  countText: '71',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'HCG pan India (All India)',
                  status: 'Done',
                  countText: '22',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'KIMS (All India)',
                  status: 'Done',
                  countText: '25',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Fortis pan India (All India)',
                  status: 'Done',
                  countText: '~28',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Fortis Raheja (All India)',
                  status: 'Done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Rainbow child Hospital (All India)',
                  status: 'Done',
                  countText: '10',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Manipal Whitefield Bangalore (All India)',
                  status: 'Done',
                  countText: '33',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Rela (All India)',
                  status: 'Done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Gangaram Delhi (All India)',
                  status: 'Through Doctor',
                  countText: '1*',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Wockhardt (All India)',
                  status: 'pending',
                  countText: '4',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Lokmanya Pune (All India)',
                  status: 'Done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Birla IVF (All India)',
                  status: 'Done',
                  countText: '52',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Artemis (All India)',
                  status: 'Done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Medanta (All India)',
                  status: 'WIP',
                  countText: '10',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Neurogeon. Stem cell (All India)',
                  status: 'WIP',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Stem RX stem cell (All India)',
                  status: 'WIP',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Narayana Hrudayalaya (All India)',
                  status: 'WIP',
                  countText: '23',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Surya pan India (All India)',
                  status: 'Done',
                  countText: '4',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Hiranandani (All India)',
                  status: 'Done',
                  countText: 'Not publicly aggregated',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HospitalTile extends StatelessWidget {
  final String hospital;
  final String status;
  final String countText;

  const _HospitalTile({
    required this.hospital,
    required this.status,
    required this.countText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFBFEFE2),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(Icons.local_hospital, color: Colors.black87),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Agreement Status: $status',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Public Number of Hospitals: $countText',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black38),
        ],
      ),
    );
  }
}

/// ===============================
/// CHAINA HOSPITALS PAGE
/// ===============================
class ChainaHospitalsView extends GetView<HomeController> {
  const ChainaHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _BlankCountryTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

/// ===============================
/// THAILAND HOSPITALS PAGE
/// ===============================
class ThailandHospitalsView extends GetView<HomeController> {
  const ThailandHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _HospitalListTabBody(
                  index: controller.tabIndex.value,
                  hospitals: const [
                    'MedPark Hospital',
                    'Sukhumvit Hospital',
                    'Nakhonthon Hospital',
                    'Bangkok Hospital',
                    'Bumrungrad International Hospital',
                    'Samitivej Hospital',
                    'Vejthani Hospital',
                    'Phyathai 2 Hospital',
                    'Rutnin Eye Hospital',
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

class _HospitalListTabBody extends StatelessWidget {
  final int index;
  final List<String> hospitals;

  const _HospitalListTabBody({
    required this.index,
    required this.hospitals,
  });

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _HospitalListHome(hospitals: hospitals);
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

class _HospitalListHome extends StatelessWidget {
  final List<String> hospitals;

  const _HospitalListHome({
    required this.hospitals,
  });

  Widget _hospitalCard(String hospital) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        // pore details page add korba
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFCFEDEA),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            hospital,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.25,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: ListView.separated(
        itemCount: hospitals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return _hospitalCard(hospitals[index]);
        },
      ),
    );
  }
}

/// ===============================
/// TURKEY HOSPITALS PAGE
/// ===============================
class TurkeyHospitalsView extends GetView<HomeController> {
  const TurkeyHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _BlankCountryTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

/// ===============================
/// SINGAPORE HOSPITALS PAGE
/// ===============================
class SingaporeHospitalsView extends GetView<HomeController> {
  const SingaporeHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _BlankCountryTabBody(index: controller.tabIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

/// ===============================
/// MALAYSIA HOSPITALS PAGE
/// ===============================
class MalaysiaHospitalsView extends GetView<HomeController> {
  const MalaysiaHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _HospitalListTabBody(
                  index: controller.tabIndex.value,
                  hospitals: const [
                    'Sunway Medical Centre Damansara',
                    'Revival Clinic',
                    'Primecare Clinic',
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

class _BlankCountryTabBody extends StatelessWidget {
  final int index;

  const _BlankCountryTabBody({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const SizedBox.shrink();
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

/// ===============================
/// SHARED WIDGETS
/// ===============================
class _MainBottomNav extends StatelessWidget {
  final HomeController controller;
  const _MainBottomNav({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.tabIndex.value,
      onTap: controller.changeTab,
      selectedItemColor: const Color(0xFF2F6FED),
      unselectedItemColor: const Color(0xFF7A7A7A),
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note),
          label: 'My Appointments',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'My Health'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
      ],
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _HomeTopBarClone extends StatelessWidget {
  const _HomeTopBarClone();

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
