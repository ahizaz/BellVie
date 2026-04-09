import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class CoreFourSection extends StatelessWidget {
  const CoreFourSection({super.key});

  static const _items = <_CoreFourItemData>[
    _CoreFourItemData(
      titleKey: 'telemedicine_video_consultancy',
      assetPath: 'assets/images/core_four/telemedicine_video.png',
      bgColor: Color(0xFFCFEDEA),
    ),
    _CoreFourItemData(
      titleKey: 'ent_doctor_services',
      assetPath: 'assets/images/core_four/ent_doctor.png',
      bgColor: Color.fromARGB(255, 175, 204, 238),
    ),
    _CoreFourItemData(
      titleKey: 'diagnostic_services',
      assetPath: 'assets/images/core_four/Diagnostic Services.png',
      bgColor: Color.fromARGB(255, 175, 204, 238),
    ),
    _CoreFourItemData(
      titleKey: 'doctors_services',
      assetPath: 'assets/images/core_four/Doctor Services.png',
      bgColor: Color(0xFFCFEDEA),
    ),
  ];

  Widget _otherMedicalTile(String titleKey, String assetPath,
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
                  titleKey.tr,
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
      _BottomTabItem('air_ambulance', 'assets/images/air_ambulance_logo.png'),
      _BottomTabItem('palliative_care_services',
          'assets/images/palliative care services.png'),
      _BottomTabItem('geriatric_health_services',
          'assets/images/geriatric_health_logo.png'),
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
                            it.titleKey.tr,
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
        Text(
          'core_four'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
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
        Text(
          'other_medical_services'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
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
                  'psychiatrist', 'assets/images/Psychiatrist.png'),
              _otherMedicalTile('counseling_psychologist',
                  'assets/images/Counselling Psychologist.png'),
              _otherMedicalTile('dentists', 'assets/images/Dentists.png'),
              _otherMedicalTile(
                  'stem_therapy', 'assets/images/Stem Therapy.png'),
              _otherMedicalTile('regenerative_therapy',
                  'assets/images/regenerative_therapy.jpeg'),
              _otherMedicalTile(
                  'caregiver_services', 'assets/images/Caregiver Services.png'),
              _otherMedicalTile(
                  'physiotherapist', 'assets/images/Physiotherapist.png'),
              _otherMedicalTile('chiropractic_services',
                  'assets/images/Chiropractic Sertvices.png'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _bottomTabsRow(),
      ],
    );
  }
}

class _CoreFourItemData {
  final String titleKey;
  final String assetPath;
  final Color bgColor;

  const _CoreFourItemData({
    required this.titleKey,
    required this.assetPath,
    required this.bgColor,
  });
}

class _CoreFourCard extends StatelessWidget {
  final _CoreFourItemData item;
  const _CoreFourCard({required this.item});

  void _handleTap() {
    if (item.titleKey == 'diagnostic_services') {
      Get.toNamed(Routes.PATHOLOGY_TEST);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _handleTap,
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
              item.titleKey.tr,
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

class _BottomTabItem {
  final String titleKey;
  final String assetPath;
  const _BottomTabItem(this.titleKey, this.assetPath);
}
