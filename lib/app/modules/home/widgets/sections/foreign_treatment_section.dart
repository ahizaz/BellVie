import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/auth_service.dart';
import '../../../foreign_treatment/views/foreign_treatment_view.dart';

class ForeignTreatmentSection extends StatelessWidget {
  const ForeignTreatmentSection({super.key});

  static const _countries = <_ForeignTreatmentItem>[
    _ForeignTreatmentItem(
        'Hospitals in India', 'assets/images/Flag_of_India.png'),
    _ForeignTreatmentItem('Hospitals in Chaina', 'assets/images/Chaina.png'),
    _ForeignTreatmentItem(
        'Hospitals in Thailand', 'assets/images/Thailand.jpg'),
    _ForeignTreatmentItem('Hospitals in Turkey', 'assets/images/Turkey.jpg'),
    _ForeignTreatmentItem(
        'Hospitals in Singapore', 'assets/images/Singapore.jpg'),
    _ForeignTreatmentItem(
        'Hospitals in Malaysia', 'assets/images/Malaysia.jpg'),
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
  const _ForeignTreatmentItem(this.title, this.assetPath);
}

class _ForeignTreatmentCard extends StatelessWidget {
  final _ForeignTreatmentItem item;
  const _ForeignTreatmentCard({required this.item});

  void _handleTap() {
    if (!AuthService.to.requireLogin()) return;

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
                    child: Image.asset(item.assetPath, fit: BoxFit.cover),
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
