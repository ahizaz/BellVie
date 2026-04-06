import 'package:flutter/material.dart';

class MedicalAccessoriesSection extends StatelessWidget {
  const MedicalAccessoriesSection({super.key});

  static const _items = <_MedicalAccessoryItem>[
    _MedicalAccessoryItem(
        'Diagnostic\nDevices', 'assets/images/Diagnostic devices.png'),
    _MedicalAccessoryItem(
        'Home Care/\nFurniture', 'assets/images/Home Care.png'),
    _MedicalAccessoryItem('Wound Care &\nPersonal Care',
        'assets/images/Wound Care & Personal Care.png'),
    _MedicalAccessoryItem(
        'First Aid\nSupplies', 'assets/images/First Aid  Supplies.png'),
    _MedicalAccessoryItem(
        'Face Masks and Gloves', 'assets/images/Face Masks and Gloves.png'),
    _MedicalAccessoryItem('Mobility Aids', 'assets/images/Mobility Aids.png'),
    _MedicalAccessoryItem(
        'Respiratory Units', 'assets/images/Respiratory Units.png'),
    _MedicalAccessoryItem('Bed Wedges', 'assets/images/Bed Wedges.png'),
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
  final String title;
  final String assetPath;
  const _MedicalAccessoryItem(this.title, this.assetPath);
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
