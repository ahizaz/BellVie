part of '../views/foreign_treatment_view.dart';

class _ForeignTreatmentHome extends StatelessWidget {
  const _ForeignTreatmentHome();

  static const _countries = <_CountryCardData>[
    _CountryCardData(
      titleKey: 'india',
      assetPath: 'assets/images/Flag_of_India.png',
    ),
    _CountryCardData(
      titleKey: 'thailand',
      assetPath: 'assets/images/Thailand.jpg',
    ),
    _CountryCardData(
      titleKey: 'turkey',
      assetPath: 'assets/images/Turkey.jpg',
    ),
  ];

  void _openCountry(String title) {
    if (!AuthService.to.requireLogin()) {
      return;
    }

    switch (title) {
      case 'india':
        Get.to(() => const IndiaHospitalsView());
        break;
      case 'thailand':
        Get.to(() => const ThailandHospitalsView());
        break;
      case 'turkey':
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
          Text(
            'foreign_treatment'.tr,
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
                onTap: () => _openCountry(item.titleKey),
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
                        item.titleKey.tr,
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
  final String titleKey;
  final String assetPath;
  const _CountryCardData({required this.titleKey, required this.assetPath});
}
