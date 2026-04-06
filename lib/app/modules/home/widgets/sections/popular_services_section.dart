import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/auth_service.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  static const _services = <_ServiceItem>[
    _ServiceItem('Specialist Doctors', 'assets/images/Doctor Services.png'),
    _ServiceItem('Hospitals Booking', 'assets/images/Hospitals Booking.png'),
    _ServiceItem('Telemedicine', 'assets/images/Telemedicine.png'),
    _ServiceItem('Pharmacy', 'assets/images/Pharmacy.png'),
    _ServiceItem('Video Consultancy', 'assets/images/Video Consultancy.png'),
    _ServiceItem('Ambulance Services', 'assets/images/Ambulance.png'),
    _ServiceItem(
        'Community Health Care', 'assets/images/Community health Care.png'),
    _ServiceItem('Hospital Support Services',
        'assets/images/Hopital Support Services.png'),
    _ServiceItem('Health Insurance', 'assets/images/Health Insurance.png'),
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
                      borderRadius: BorderRadius.circular(16),
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
  const _ServiceItem(this.title, this.assetPath);
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem item;
  const _ServiceCard({required this.item});

  void _handleTap() {
    if (item.title == 'Specialist Doctors') {
      if (!AuthService.to.requireLogin()) return;
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
