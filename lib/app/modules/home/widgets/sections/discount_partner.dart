// import 'package:bellevie/app/modules/home/controllers/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class DiscountPartner extends StatefulWidget {
//   const DiscountPartner({super.key});

//   @override
//   State<DiscountPartner> createState() => _DiscountPartnerState();
// }

// class _DiscountPartnerState extends State<DiscountPartner> {
//   late final HomeController homeController;

//   @override
//   void initState() {
//     super.initState();
//     homeController = Get.isRegistered<HomeController>()
//         ? Get.find<HomeController>()
//         : Get.put(HomeController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Row(
//           children: [
//             Text(
//               "Discount Partner",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 12,
//         ),
//         Obx(() {
//           return homeController.isLoading.value == false
//               ? const Center(child: CircularProgressIndicator())
//               : Container(
//                   height: 120,
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(10)),
//                   child: ListView.separated(
//                     padding: const EdgeInsets.symmetric(horizontal: 4),
//                     scrollDirection: Axis.horizontal,
//                     itemCount: homeController
//                             .discountPartnerData.value?.results?.length ??
//                         0,
//                     separatorBuilder: (_, __) => const SizedBox(width: 12),
//                     itemBuilder: (context, index) {
//                       final item = homeController
//                           .discountPartnerData.value?.results?[index];
//                       return SizedBox(
//                         width: 140,
//                         child: Card(
//                           elevation: 2,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           clipBehavior: Clip.hardEdge,
//                           child: Stack(
//                             fit: StackFit.expand,
//                             children: [
//                               if (item?.icon != null && item!.icon!.isNotEmpty)
//                                 CachedNetworkImage(
//                                   imageUrl: item.icon!,
//                                   fit: BoxFit.cover,
//                                   placeholder: (context, url) => Container(
//                                       color: Colors.grey.shade200,
//                                       child: const Center(
//                                           child: CircularProgressIndicator(
//                                               strokeWidth: 2))),
//                                   errorWidget: (context, url, error) =>
//                                       Container(
//                                           color: Colors.grey.shade200,
//                                           child:
//                                               const Icon(Icons.broken_image)),
//                                 )
//                               else
//                                 Container(color: Colors.grey.shade200),
//                               Container(
//                                 alignment: Alignment.bottomCenter,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 10),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     colors: [
//                                       Colors.transparent,
//                                       Colors.black.withOpacity(0.5)
//                                     ],
//                                   ),
//                                 ),
//                                 child: Text(
//                                   item?.name ?? '',
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//         })
//       ],
//     );
//   }
// }
import 'package:bellevie/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DiscountPartner extends StatefulWidget {
  const DiscountPartner({super.key});

  @override
  State<DiscountPartner> createState() => _DiscountPartnerState();
}

class _DiscountPartnerState extends State<DiscountPartner> {
  late final HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              "Discount Partner",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() {
          return homeController.isLoading.value == false
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 125,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController
                            .discountPartnerData.value?.results?.length ??
                        0,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final item = homeController
                          .discountPartnerData.value?.results?[index];

                      return SizedBox(
                        width: 115,
                        child: Column(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  color: Colors.white,
                                  child: item?.icon != null &&
                                          item!.icon!.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: item.icon!,
                                          fit: BoxFit.contain,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.grey.shade200,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey.shade200,
                                            child:
                                                const Icon(Icons.broken_image),
                                          ),
                                        )
                                      : Container(color: Colors.grey.shade200),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Name নিচে
                            Text(
                              item?.name ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
        })
      ],
    );
  }
}
