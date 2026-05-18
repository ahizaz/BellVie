import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/specialist_doctor_list_controller.dart';
import '../models/specialist_doctor_item.dart';
import '../widgets/doctor_info_button.dart';
import '../../../services/api_service.dart';

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
              ? 'specialist_doctors'.tr
              : controller.categoryLabel,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: Obx(() {
        // Only show "No doctors" message if explicitly confirmed no data
        if (controller.showNoData.value && controller.doctors.isEmpty) {
          return Center(
            child: Text(
              'no_doctors_available'.tr,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        // Show list if doctors exist, or empty space if loading
        // If no doctors yet, show placeholder cards so UI is built immediately
        if (controller.doctors.isEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index > 0) {
                return const Column(
                  children: [
                    SizedBox(height: 10),
                    _DoctorPlaceholderCard(),
                  ],
                );
              }
              return const _DoctorPlaceholderCard();
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
          itemCount:
              controller.doctors.length + (controller.hasMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < controller.doctors.length) {
              if (index > 0) {
                // spacing between items
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    _DoctorListCard(item: controller.doctors[index]),
                  ],
                );
              }
              return _DoctorListCard(item: controller.doctors[index]);
            }

            // footer: More button or loading indicator
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Obx(() {
                  return ElevatedButton(
                    onPressed: controller.loadMore,
                    child: Text('more'.tr),
                  );
                }),
              ),
            );
          },
        );
      }),
    );
  }
}

class _DoctorListCard extends StatelessWidget {
  const _DoctorListCard({required this.item});

  final SpecialistDoctorItem item;

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    if (value.startsWith('/')) {
      return '${AppApiService.baseUrl}$value';
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    const avatarIcon = Icons.person;
    final imagePath = item.imageAssetPath.trim();
    final resolvedImageUrl = _resolveImageUrl(imagePath);
    final isNetworkImage = resolvedImageUrl.startsWith('http://') ||
        resolvedImageUrl.startsWith('https://');

    // parse id (API expects numeric id like 18)
    final parsedId = int.tryParse(item.id);

    final card = Container(
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
                    ? CachedNetworkImage(
                        imageUrl: resolvedImageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const Center(
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
                if (item.experience.isNotEmpty || item.fees.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Builder(builder: (context) {
                    final parts = <String>[];
                    if (item.experience.isNotEmpty) {
                      parts.add('${'experience'.tr}: ${item.experience}');
                    }
                    if (item.fees.isNotEmpty) {
                      parts.add('${'fees'.tr}: ${item.fees}');
                    }
                    return Text(
                      parts.join('  •  '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    );
                  }),
                ],
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

          // <<< HERE: add the info button if id is numeric
          if (parsedId != null) ...[
            const SizedBox(width: 12),
            DoctorInfoButton(doctorId: parsedId),
          ],
        ],
      ),
    );

    if (parsedId == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => DoctorInfoButton.openDoctorDetails(context, parsedId),
        child: card,
      ),
    );
  }
}

class _DoctorPlaceholderCard extends StatelessWidget {
  const _DoctorPlaceholderCard();

  @override
  Widget build(BuildContext context) {
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
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 14,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 12,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
