import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailableLabView extends StatelessWidget {
  const AvailableLabView({super.key});

  static const _labs = <_LabItem>[
    _LabItem('Birdem', 'assets/images/birdem.jpeg'),
    _LabItem('Ibn Sina', 'assets/images/ibnsina.png'),
    _LabItem('Popular', 'assets/images/popular.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDEFF2),
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'available_lab'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
        itemCount: _labs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _LabCard(item: _labs[index]);
        },
      ),
    );
  }
}

class _LabItem {
  final String title;
  final String assetPath;

  const _LabItem(this.title, this.assetPath);
}

class _LabCard extends StatelessWidget {
  final _LabItem item;

  const _LabCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFCFEDEA),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFB3DAD6)),
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
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  item.assetPath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
