import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/specialist_doctor_list_controller.dart';
import '../models/specialist_doctor_item.dart';

class SpecialistDoctorListView extends GetView<SpecialistDoctorListController> {
  const SpecialistDoctorListView({super.key});

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
          controller.categoryLabel.isEmpty
              ? 'Specialist Doctors'
              : controller.categoryLabel,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && !controller.showNoData.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.doctors.isEmpty) {
          return const Center(
            child: Text(
              'No doctors available right now.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
          itemCount: controller.doctors.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return _DoctorListCard(item: controller.doctors[index]);
          },
        );
      }),
    );
  }
}

class _DoctorListCard extends StatelessWidget {
  const _DoctorListCard({required this.item});

  final SpecialistDoctorItem item;

  @override
  Widget build(BuildContext context) {
    const avatarIcon = Icons.person;
    final imagePath = item.imageAssetPath.trim();
    final isNetworkImage =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFCDEFF2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFB7D9D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: const Color(0xFFCDEFF2),
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: imagePath.isEmpty
                ? const Center(
                    child: Icon(
                      avatarIcon,
                      size: 40,
                      color: Colors.black45,
                    ),
                  )
                : isNetworkImage
                    ? Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(
                            avatarIcon,
                            size: 40,
                            color: Colors.black45,
                          ),
                        ),
                      )
                    : Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(
                            avatarIcon,
                            size: 40,
                            color: Colors.black45,
                          ),
                        ),
                      ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.designation,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.hospitalName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.1,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
