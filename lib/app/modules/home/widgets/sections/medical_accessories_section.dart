import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class MedicalAccessoriesSection extends StatelessWidget {
  const MedicalAccessoriesSection({super.key});

  static const _items = <_MedicalAccessoryItem>[
    _MedicalAccessoryItem(
        'diagnostic_devices', 'assets/images/Diagnostic devices.png'),
    _MedicalAccessoryItem('home_care_furniture', 'assets/images/Home Care.png'),
    _MedicalAccessoryItem('wound_care_personal_care',
        'assets/images/Wound Care & Personal Care.png'),
    _MedicalAccessoryItem(
        'first_aid_supplies', 'assets/images/First Aid  Supplies.png'),
    _MedicalAccessoryItem(
        'face_masks_and_gloves', 'assets/images/Face Masks and Gloves.png'),
    _MedicalAccessoryItem('mobility_aids', 'assets/images/Mobility Aids.png'),
    _MedicalAccessoryItem(
        'respiratory_units', 'assets/images/Respiratory Units.png'),
    _MedicalAccessoryItem('bed_wedges', 'assets/images/Bed Wedges.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'medical_accessories'.tr,
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
  final String titleKey;
  final String assetPath;
  const _MedicalAccessoryItem(this.titleKey, this.assetPath);
}

class _MedicalAccessoryCard extends StatelessWidget {
  final _MedicalAccessoryItem item;
  const _MedicalAccessoryCard({required this.item});

  void _showComingSoon() {
    Get.toNamed(Routes.COMING_SOON);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _showComingSoon,
      child: Container(
        padding: const EdgeInsets.all(10),
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
                item.titleKey.tr,
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
