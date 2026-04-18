import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'popular_services'.tr,
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
            ],
          ),
        ),
      ],
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

  void _handleTap() {
    if (item.titleKey == 'specialist_doctors') {
      Get.toNamed(Routes.SPECIALIST_DOCTORS);
      return;
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
                child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: item.whiteIconBackground
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(item.assetPath, fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.titleKey.tr,
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
