import 'package:bellevie/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../views/discount_partners_view.dart';
import 'discount_partner_details.dart';

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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                'Discount Partner',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                Get.to(() => const DiscountPartnersView());
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'See all',
                      style: TextStyle(
                        color: Color(0xFF2F6FED),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color(0xFF2F6FED),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Obx(() {
          return homeController.isLoading.value == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: 120,
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

                      return InkWell(
                        onTap: () {
                          if (item?.id == null) return;

                          Get.to(
                            () => DiscountPartnerDetails(
                              partnerId: item!.id!,
                              name: item.name ?? '',
                              iconUrl: item.icon ?? '',
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: 115,
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
                                child: Center(
                                  child: SizedBox(
                                    height: 55,
                                    width: 78,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: item?.icon != null &&
                                              item!.icon!.isNotEmpty
                                          ? CachedNetworkImage(
                                              imageUrl: item.icon!,
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) =>
                                                  Container(
                                                color: Colors.grey.shade200,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                color: Colors.grey.shade200,
                                                child: const Icon(
                                                  Icons.broken_image,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              color: Colors.grey.shade200,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Builder(builder: (context) {
                                final label = item?.nameEn ?? item?.name ?? '';

                                return Expanded(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      label,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        }),
      ],
    );
  }
}
