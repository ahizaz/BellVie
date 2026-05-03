import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/popular_services_controller.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  static const _services = <_ServiceItem>[
    _ServiceItem('specialist_doctors', 'assets/images/Doctor Services.png'),
    _ServiceItem(
      'hospitals_booking',
      'assets/images/Hospitals Booking.png',
      whiteIconBackground: true,
    ),
    _ServiceItem('telemedicine', 'assets/images/Telemedicine.png'),
    _ServiceItem('pharmacy', 'assets/images/Pharmacy.png'),
    _ServiceItem('video_consultancy', 'assets/images/Video Consultancy.png'),
    _ServiceItem('ambulance_services', 'assets/images/Ambulance.png'),
    _ServiceItem(
        'community_health_care', 'assets/images/Community health Care.png'),
    _ServiceItem('hospital_support_services',
        'assets/images/Hopital Support Services.png'),
    _ServiceItem('health_insurance', 'assets/images/Health Insurance.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PopularServicesController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'popular_services'.tr,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => Get.toNamed(Routes.POPULAR_SERVICES),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F6FED),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F6FED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            Obx(() {
              final apiItems = controller.items;
              final isLoading = controller.isLoading.value;
              final useApi = apiItems.isNotEmpty;
              final count = useApi ? apiItems.length : _services.length;

              if (isLoading && apiItems.isEmpty) {
                return const SizedBox(
                  height: 112,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }

              return LayoutBuilder(builder: (context, constraints) {
                final totalWidth = constraints.maxWidth;
                const crossCount = 4;
                const spacing = 10.0;
                const childAspect = 0.88;

                final availableWidth = totalWidth;
                final itemWidth =
                    (availableWidth - (crossCount - 1) * spacing) / crossCount;
                final itemHeight = itemWidth / childAspect;
                final rows = (count / crossCount).ceil();
                final gridHeight = rows * itemHeight +
                    (rows - 1) * spacing +
                    2; // small buffer

                // Use the computed grid height so the grid takes full space
                // instead of being artificially capped which caused clipping.
                final cappedHeight = gridHeight.toDouble();

                return SizedBox(
                  height: cappedHeight,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: count,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: childAspect,
                    ),
                    itemBuilder: (context, i) {
                      if (useApi) {
                        final svc = apiItems[i];
                        return _ServiceCardFromApi(
                          name: svc.name,
                          iconUrl: svc.iconUrl,
                          titleKey: svc.name,
                          serviceId: svc.id,
                        );
                      }
                      return _ServiceCard(item: _services[i]);
                    },
                  ),
                );
              });
            }),
          ],
        ),
      ],
    );
  }
}

class _ServiceCardFromApi extends StatelessWidget {
  final String name;
  final String iconUrl;
  final String titleKey;
  final int serviceId;

  const _ServiceCardFromApi({
    required this.name,
    required this.iconUrl,
    required this.titleKey,
    required this.serviceId,
  });

  void _handleTap() {
    final key = titleKey.toLowerCase();
    debugPrint('Popular service tapped: $titleKey');
    if (key.contains('specialist') || key.contains('doctor')) {
      Get.toNamed(
        Routes.SPECIALIST_DOCTORS,
        arguments: {
          'categoryId': serviceId,
          'categoryLabel': name,
          'categoryAssetPath': iconUrl,
        },
      );
      return;
    }

    Get.toNamed(Routes.COMING_SOON);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _handleTap,
      child: SizedBox(
        width: 78,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE4E8F2)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 36,
                width: 36,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: iconUrl.isNotEmpty
                    ? Image.network(
                        iconUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            Image.asset('assets/images/Doctor Services.png'),
                      )
                    : Image.asset('assets/images/Doctor Services.png'),
              ),
              const SizedBox(height: 6),
              Flexible(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
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
}

class _ServiceItem {
  final String titleKey;
  final String assetPath;
  final bool whiteIconBackground;

  const _ServiceItem(
    this.titleKey,
    this.assetPath, {
    this.whiteIconBackground = false,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem item;
  const _ServiceCard({required this.item});

  void _showComingSoon() {
    Get.toNamed(Routes.COMING_SOON);
  }

  void _handleTap() {
    if (item.titleKey == 'specialist_doctors') {
      Get.toNamed(Routes.SPECIALIST_DOCTORS);
      return;
    }

    _showComingSoon();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _handleTap,
      child: SizedBox(
        width: 78,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE4E8F2)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 36,
                width: 36,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(item.assetPath, fit: BoxFit.contain),
              ),
              const SizedBox(height: 6),
              Flexible(
                child: Text(
                  item.titleKey.tr,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
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
}
