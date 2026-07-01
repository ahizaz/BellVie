import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/sections/discount_partner_details.dart';

class DiscountPartnersView extends StatelessWidget {
  const DiscountPartnersView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Discount Partner'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        final partners =
            homeController.discountPartnerData.value?.results ?? [];
        final isLoading = homeController.discountPartnerData.value == null &&
            homeController.isLoading.value == false;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (partners.isEmpty) {
          return const Center(
            child: Text(
              'No discount partners found',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          itemCount: partners.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.92,
          ),
          itemBuilder: (context, index) {
            final item = partners[index];

            return InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                if (item.id == null) return;

                Get.to(
                  () => DiscountPartnerDetails(
                    partnerId: item.id!,
                    name: item.name ?? '',
                    iconUrl: item.icon ?? '',
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFBEE9FF),
                      Color(0xFFDFF8EF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 96,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: item.icon != null && item.icon!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: item.icon!,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.broken_image),
                                )
                              : const Icon(
                                  Icons.local_offer,
                                  size: 44,
                                  color: Colors.black38,
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.nameEn ?? item.name ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
