// import 'package:bellevie/app/modules/home/controllers/bangladehi_hospital_controller.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HospitalPackageView extends StatelessWidget {
//   HospitalPackageView({super.key});

//   final HospitalPackageController controller =
//       Get.put(HospitalPackageController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFDF7FF),
//       appBar: AppBar(
//         toolbarHeight: 75,
//         backgroundColor: const Color(0xFFC0E2E3),
//         surfaceTintColor: Colors.transparent,
//         elevation: 10,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black87),
//         title: const Text(
//           "Hospital's Under BelleVie Guardian\nHealth Protection Packages",
//           textAlign: TextAlign.center,
//           maxLines: 2,
//           style: TextStyle(
//             color: Colors.black87,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             height: 1.2,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(75),
//           child: Container(
//             color: const Color(0xFFC0E2E3),
//             padding: const EdgeInsets.only(bottom: 16),
//             child: Center(
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.90,
//                 child: Container(
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: controller.searchCtrl,
//                     onChanged: controller.onSearchChanged,
//                     decoration: const InputDecoration(
//                       hintText: "Search Hospital",
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(vertical: 14),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value && controller.hospitals.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return ListView.separated(
//           padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
//           itemCount: controller.hospitals.length + (controller.hasMore ? 1 : 0),
//           separatorBuilder: (_, __) => const SizedBox(height: 12),
//           itemBuilder: (context, index) {
//             if (index == controller.hospitals.length) {
//               return Center(
//                 child: ElevatedButton(
//                   onPressed: controller.isMoreLoading.value
//                       ? null
//                       : controller.loadMoreHospitals,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFC0E2E3),
//                     foregroundColor: Colors.black87,
//                     elevation: 2,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 34,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: controller.isMoreLoading.value
//                       ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: Colors.black87,
//                           ),
//                         )
//                       : const Text(
//                           'More',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                 ),
//               );
//             }

//             final hospital = controller.hospitals[index];

//             return Container(
//               height: 88,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xFFBEE9FF),
//                     Color(0xFFDFF8EF),
//                   ],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.white24, width: 1),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x33FFFFFF),
//                     offset: Offset(-3, -3),
//                     blurRadius: 6,
//                   ),
//                   BoxShadow(
//                     color: Color(0x22000000),
//                     offset: Offset(3, 4),
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 60,
//                     width: 60,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [Color(0xFFE0F7FA), Color(0xFFE8F8FB)],
//                       ),
//                       borderRadius: BorderRadius.circular(32),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: .08),
//                           blurRadius: 12,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: hospital.image.isEmpty
//                         ? const Icon(
//                             Icons.local_hospital,
//                             color: Colors.redAccent,
//                             size: 34,
//                           )
//                         : ClipRRect(
//                             borderRadius: BorderRadius.circular(32),
//                             child: CachedNetworkImage(
//                               imageUrl: hospital.image,
//                               fit: BoxFit.cover,
//                               errorWidget: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.local_hospital,
//                                   color: Colors.redAccent,
//                                   size: 34,
//                                 );
//                               },
//                             ),
//                           ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           controller.isBangla
//                               ? hospital.nameBn
//                               : hospital.nameEn,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           hospital.area,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 13,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           controller.isBangla
//                               ? hospital.addressBn
//                               : hospital.addressEn,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 13,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   const Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     size: 17,
//                     color: Colors.black54,
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
import 'package:bellevie/app/modules/home/controllers/bangladehi_hospital_controller.dart';
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
        iconTheme: const IconThemeData(color: Colors.black87),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Container(
            color: const Color(0xFFC0E2E3),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Column(
              children: [
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller.searchCtrl,
                    onChanged: controller.onSearchChanged,
                    decoration: const InputDecoration(
                      hintText: "Search Hospital",
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Obx(() {
                  return Row(
                    children: [
                      Expanded(
                        child: _filterButton(
                          title: controller.selectedDistrict.value.isEmpty
                              ? 'District'
                              : controller.selectedDistrict.value,
                          onTap: () => _showFilterSheet(
                            context,
                            title: 'Select District',
                            items: controller.districts,
                            onSelect: controller.selectDistrict,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _filterButton(
                          title: controller.selectedDivision.value.isEmpty
                              ? 'Division'
                              : controller.selectedDivision.value,
                          onTap: () => _showFilterSheet(
                            context,
                            title: 'Select Division',
                            items: controller.divisions,
                            onSelect: controller.selectDivision,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: controller.clearFilter,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.hospitals.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hospitals.isEmpty) {
          return const Center(
            child: Text(
              'No hospital found',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
          itemCount: controller.hospitals.length + (controller.hasMore ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == controller.hospitals.length) {
              return Center(
                child: ElevatedButton(
                  onPressed: controller.isMoreLoading.value
                      ? null
                      : controller.loadMoreHospitals,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC0E2E3),
                    foregroundColor: Colors.black87,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 34,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isMoreLoading.value
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black87,
                          ),
                        )
                      : const Text(
                          'More',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              );
            }

            final hospital = controller.hospitals[index];

            return Container(
              height: 110,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFBEE9FF),
                    Color(0xFFDFF8EF),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24, width: 1),
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
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFE0F7FA), Color(0xFFE8F8FB)],
                      ),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: hospital.image.isEmpty
                        ? const Icon(
                            Icons.local_hospital,
                            color: Colors.redAccent,
                            size: 34,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: CachedNetworkImage(
                              imageUrl: hospital.image,
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.local_hospital,
                                  color: Colors.redAccent,
                                  size: 34,
                                );
                              },
                            ),
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.isBangla
                              ? hospital.nameBn
                              : hospital.nameEn,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          hospital.district,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          hospital.division,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          controller.isBangla
                              ? hospital.addressBn
                              : hospital.addressEn,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 17,
                    color: Colors.black54,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _filterButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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

  void _showFilterSheet(
    BuildContext context, {
    required String title,
    required List<String> items,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ...items.map(
                (item) => ListTile(
                  title: Text(item),
                  onTap: () {
                    Get.back();
                    onSelect(item);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
