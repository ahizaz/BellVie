import 'package:bellevie/app/modules/home/controllers/bangladehi_hospital_controller.dart';
import 'package:bellevie/app/modules/home/data/hospital_details_page.dart';

import 'package:bellevie/app/modules/home/widgets/sections/international_hospital_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalPackageView extends StatelessWidget {
  HospitalPackageView({super.key});

  final HospitalPackageController controller =
      Get.put(HospitalPackageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FF),
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color(0xFFC0E2E3),
        surfaceTintColor: Colors.transparent,
        elevation: 10,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: const Text(
          "Hospital's Under BelleVie Guardian\n"
          "Health Protection Packages",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(185),
          child: Obx(() {
            final bool isInternational =
                controller.isInternational.value;

            return Container(
              color: const Color(0xFFC0E2E3),
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                14,
              ),
              child: Column(
                children: [
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller:
                          controller.searchCtrl,
                      onChanged:
                          controller.onSearchChanged,
                      decoration: InputDecoration(
                        hintText: isInternational
                            ? 'Search International Hospital'
                            : 'Search National Hospital',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _hospitalTypeButton(
                          title: 'National',
                          icon: Icons.flag_rounded,
                          isSelected:
                              !isInternational,
                          onTap:
                              controller.selectNational,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _hospitalTypeButton(
                          title: 'International',
                          icon: Icons.public_rounded,
                          isSelected:
                              isInternational,
                          onTap: controller
                              .selectInternational,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (!isInternational)
                    Row(
                      children: [
                        Expanded(
                          child: _filterButton(
                            title: controller
                                    .selectedDistrict
                                    .value
                                    .isEmpty
                                ? 'District'
                                : controller
                                    .selectedDistrict
                                    .value,
                            onTap: () {
                              _showFilterSheet(
                                context,
                                title:
                                    'Select District',
                                items:
                                    controller.districts,
                                onSelect: controller
                                    .selectDistrict,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _filterButton(
                            title: controller
                                    .selectedDivision
                                    .value
                                    .isEmpty
                                ? 'Division'
                                : controller
                                    .selectedDivision
                                    .value,
                            onTap: () {
                              _showFilterSheet(
                                context,
                                title:
                                    'Select Division',
                                items:
                                    controller.divisions,
                                onSelect: controller
                                    .selectDivision,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 38,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints:
                                const BoxConstraints(),
                            onPressed:
                                controller.clearFilter,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black87,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    const SizedBox(height: 42),
                ],
              ),
            );
          }),
        ),
      ),
      body: Obx(() {
        final bool isInternational =
            controller.isInternational.value;

        final bool loading = isInternational
            ? controller
                .isInternationalLoading.value
            : controller.isLoading.value;

        if (loading &&
            controller.hospitals.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.hospitals.isEmpty) {
          if (isInternational) {
            return _internationalEmptyView();
          }

          return const Center(
            child: Text(
              'No hospital found',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            16,
          ),
          itemCount:
              controller.hospitals.length,
          separatorBuilder: (_, __) {
            return const SizedBox(height: 12);
          },
          itemBuilder: (context, index) {
            final hospital =
                controller.hospitals[index];

            final String displayName =
                controller.isBangla &&
                        hospital.nameBn
                            .trim()
                            .isNotEmpty
                    ? hospital.nameBn
                    : hospital.nameEn;

            final String displayAddress =
                controller.isBangla &&
                        hospital.addressBn
                            .trim()
                            .isNotEmpty
                    ? hospital.addressBn
                    : hospital.addressEn;

            return InkWell(
              borderRadius:
                  BorderRadius.circular(16),
              onTap: () {
                if (isInternational) {
                  Get.to(
                    () =>
                        InternationalHospitalDetailsPage(
                      hospital: hospital,
                    ),
                  );
                } else {
                  Get.to(
                    () => HospitalDetailsPage(
                      hospitalId: hospital.id,
                    ),
                  );
                }
              },
              child: Container(
                height: 110,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFFBEE9FF),
                      Color(0xFFDFF8EF),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius:
                      BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white24,
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33FFFFFF),
                      offset: Offset(-3, -3),
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      color: Color(0x22000000),
                      offset: Offset(3, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient:
                            const LinearGradient(
                          begin:
                              Alignment.topCenter,
                          end:
                              Alignment.bottomCenter,
                          colors: [
                            Color(0xFFE0F7FA),
                            Color(0xFFE8F8FB),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withValues(
                              alpha: 0.08,
                            ),
                            blurRadius: 12,
                            offset:
                                const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: hospital.image.isEmpty
                          ? const Icon(
                              Icons.local_hospital,
                              color:
                                  Colors.redAccent,
                              size: 34,
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(
                                32,
                              ),
                              child:
                                  CachedNetworkImage(
                                imageUrl:
                                    hospital.image,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) {
                                  return const Center(
                                    child: SizedBox(
                                      width: 22,
                                      height: 22,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  );
                                },
                                errorWidget: (
                                  context,
                                  url,
                                  error,
                                ) {
                                  return const Icon(
                                    Icons.local_hospital,
                                    color: Colors
                                        .redAccent,
                                    size: 34,
                                  );
                                },
                              ),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style:
                                const TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.w600,
                              color:
                                  Colors.black87,
                            ),
                          ),
                          if (isInternational) ...[
                            if (hospital.country
                                .trim()
                                .isNotEmpty) ...[
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                hospital.country,
                                maxLines: 1,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  fontSize: 13,
                                  color:
                                      Colors.black54,
                                ),
                              ),
                            ],
                            if (displayAddress
                                .trim()
                                .isNotEmpty) ...[
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                displayAddress,
                                maxLines: 2,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  fontSize: 13,
                                  height: 1.25,
                                  color:
                                      Colors.black54,
                                ),
                              ),
                            ],
                          ] else ...[
                            const SizedBox(height: 4),
                            Text(
                              hospital.district,
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style:
                                  const TextStyle(
                                fontSize: 13,
                                color:
                                    Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              hospital.division,
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style:
                                  const TextStyle(
                                fontSize: 13,
                                color:
                                    Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              displayAddress,
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style:
                                  const TextStyle(
                                fontSize: 13,
                                color:
                                    Colors.black54,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // National এবং International—
                    // দুই card-এই arrow থাকবে।
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 17,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _hospitalTypeButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(12),
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 200),
        height: 44,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4FA8A9)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4FA8A9)
                : Colors.black12,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? Colors.white
                  : Colors.black87,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(12),
      child: Container(
        height: 42,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _internationalEmptyView() {
    return const Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.public_rounded,
              size: 64,
              color: Color(0xFF4FA8A9),
            ),
            SizedBox(height: 16),
            Text(
              'International Hospitals',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'No international hospital found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(
    BuildContext context, {
    required String title,
    required List<String> items,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape:
          const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.all(16),
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ...items.map(
                (item) {
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      Get.back();
                      onSelect(item);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}