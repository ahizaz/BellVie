
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/responsive.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.w(16);
    final verticalPadding = context.h(12);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('book_appointment'.tr),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        children: [
          _AppointmentOptionCard(
            title: 'foreign_treatment'.tr,
            subtitle: 'browse_hospitals_packages_abroad'.tr,
            icon: Icons.public,
            routeName: Routes.FOREIGN_TREATMENT,
          ),
          const SizedBox(height: 12),
          _AppointmentOptionCard(
            title: 'top_doctors'.tr,
            subtitle: 'find_a_specialist_and_book_quickly'.tr,
            icon: Icons.medical_services_outlined,
            routeName: Routes.SPECIALIST_DOCTORS,
            arguments: const {
              'categoryId': 1,
              'categoryLabel': 'Doctor Appointments',
            },
          ),
        ],
      ),
    );
  }
}

class _AppointmentOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String routeName;
  final Map<String, dynamic>? arguments;

  const _AppointmentOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.routeName,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Get.toNamed(routeName, arguments: arguments),
        child: Padding(
          padding: EdgeInsets.all(context.w(16)),
          child: Row(
            children: [
              Container(
                width: context.w(44),
                height: context.w(44),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF2F6FED)),
              ),
              SizedBox(width: context.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Color(0xFF2F6FED),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
