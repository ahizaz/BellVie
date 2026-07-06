import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bangladehi_hospital_controller.dart';

class HospitalDetailsPage extends StatelessWidget {
  final int hospitalId;

  const HospitalDetailsPage({
    super.key,
    required this.hospitalId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      HospitalDetailsController(hospitalId: hospitalId),
      tag: hospitalId.toString(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0E2E3),
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          'Hospital Details',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final hospital = controller.hospitalDetails.value;

        if (hospital == null) {
          return const Center(
            child: Text(
              'No details found',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        final name = controller.isBangla ? hospital.nameBn : hospital.nameEn;
        final address =
            controller.isBangla ? hospital.addressBn : hospital.addressEn;
        final facilities = controller.isBangla
            ? hospital.facilitiesBn
            : hospital.facilitiesEn;
        final contact = controller.isBangla
            ? hospital.contactDetailsBn
            : hospital.contactDetailsEn;
        final remark =
            controller.isBangla ? hospital.remarkBn : hospital.remarkEn;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFBEE9FF),
                      Color(0xFFDFF8EF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white54),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 14,
                      offset: Offset(3, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 86,
                      width: 86,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.75),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 14,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: hospital.image.isEmpty
                            ? Container(
                                color: const Color(0xFFEAF8F2),
                                child: const Icon(
                                  Icons.local_hospital,
                                  color: Colors.redAccent,
                                  size: 46,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: hospital.image,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => Container(
                                  color: const Color(0xFFEAF8F2),
                                  child: const Icon(
                                    Icons.local_hospital,
                                    color: Colors.redAccent,
                                    size: 46,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                    if (hospital.area.trim().isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.75),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 17,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              hospital.area,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 18),

              _InfoCard(
                icon: Icons.location_on_outlined,
                title: 'Address',
                value: address,
                iconColor: Colors.redAccent,
                bgColor: const Color(0xFFFFEEF0),
              ),
              _InfoCard(
                icon: Icons.medical_services_outlined,
                title: 'Facilities',
                value: facilities,
                iconColor: const Color(0xFF0E9F6E),
                bgColor: const Color(0xFFEAF8F2),
              ),
              _InfoCard(
                icon: Icons.phone_outlined,
                title: 'Contact Details',
                value: contact,
                iconColor: const Color(0xFF2477C8),
                bgColor: const Color(0xFFEAF4FF),
              ),
              _InfoCard(
                icon: Icons.info_outline_rounded,
                title: 'Remark',
                value: remark,
                iconColor: const Color(0xFFE09A00),
                bgColor: const Color(0xFFFFF6DD),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;
  final Color bgColor;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    if (value.trim().isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 23,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
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