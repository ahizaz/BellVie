import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../controllers/popular_services_controller.dart';

class PopularServicesView extends StatelessWidget {
  const PopularServicesView({super.key});

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
      'community_health_care',
      'assets/images/Community health Care.png',
    ),
    _ServiceItem(
      'hospital_support_services',
      'assets/images/Hopital Support Services.png',
    ),
    _ServiceItem('health_insurance', 'assets/images/Health Insurance.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PopularServicesController());

    return Scaffold(
      appBar: AppBar(
        title: Text('popular_services'.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final apiItems = controller.items;
        final useApi = apiItems.isNotEmpty;
        final count = useApi ? apiItems.length : _services.length;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          itemCount: count,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.92,
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
        );
      }),
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
    debugPrint('Popular service tapped: $titleKey');
    Get.toNamed(
      Routes.SPECIALIST_DOCTORS,
      arguments: {
        'categoryId': serviceId,
        'categoryLabel': name,
        'categoryAssetPath': iconUrl,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _handleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 42,
              width: 42,
              child: iconUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: iconUrl,
                      fit: BoxFit.contain,
                      errorWidget: (_, __, ___) =>
                          Image.asset('assets/images/Doctor Services.png'),
                    )
                  : Image.asset('assets/images/Doctor Services.png'),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                height: 1.15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 42,
              width: 42,
              child: Image.asset(item.assetPath, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(
              item.titleKey.tr,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                height: 1.15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
