import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalAccessoryProductDetailsView extends StatelessWidget {
  const MedicalAccessoryProductDetailsView({
    super.key,
    required this.categoryName,
    required this.categoryImage,
  });

  final String categoryName;
  final String categoryImage;

  @override
  Widget build(BuildContext context) {
    const productName = 'Premium Medical Product';
    const price = '৳ 1,250';
    const oldPrice = '৳ 1,500';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 190,
                    child: categoryImage.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: categoryImage,
                            fit: BoxFit.contain,
                            errorWidget: (_, __, ___) => const Icon(
                              Icons.image_not_supported,
                              size: 70,
                              color: Colors.black26,
                            ),
                          )
                        : const Icon(
                            Icons.medical_services_outlined,
                            size: 90,
                            color: Colors.black26,
                          ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    productName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    categoryName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2F6FED),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Text(
                      //   oldPrice,
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.black38,
                      //     decoration: TextDecoration.lineThrough,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This is a static medical accessory product details design. Product image, name, description and price will be loaded from API in future.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: ElevatedButton(
      //       onPressed: () {},
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: const Color(0xFF2F6FED),
      //         minimumSize: const Size(double.infinity, 52),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(14),
      //         ),
      //       ),
      //       child: const Text(
      //         'Add to Cart',
      //         style: TextStyle(
      //           fontSize: 15,
      //           fontWeight: FontWeight.w800,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
