import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalPackageView extends StatelessWidget {
  const HospitalPackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: const Color(0xFFC0E2E3),
        surfaceTintColor: Colors.transparent,
        elevation: 10,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: const Text(
          "Hospital's Under BelleVie Guardian\nHealth Protection Packages",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
