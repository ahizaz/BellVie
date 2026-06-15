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

  String get _details {
    final name = categoryName.toLowerCase().trim();

    if (name.contains('bed wedge')) {
      return 'Bed Wedges are specially designed support pillows that elevate the upper body, legs, or feet to improve comfort and promote better posture. They help reduce acid reflux, snoring, back pain, swelling, and circulation problems while sleeping, resting, or recovering after surgery. Made from high-density foam, bed wedges provide ergonomic support for enhanced relaxation and health benefits.';
    }

    if (name.contains('respiratory')) {
      return 'Respiratory Units help patients with breathing support, oxygen therapy, nebulization, and respiratory care. These devices are useful for people with asthma, COPD, breathing difficulty, or post-treatment recovery needs.';
    }

    if (name.contains('mobility')) {
      return 'Mobility Aids are designed to support safe movement for elderly people, patients, and individuals recovering from injury or surgery. They help improve balance, independence, comfort, and confidence during daily activities.';
    }

    if (name.contains('face mask') || name.contains('glove')) {
      return 'Face Masks and Gloves help protect users from germs, dust, infection, and contamination. They are commonly used in hospitals, clinics, home care, and daily hygiene practices to maintain safety and cleanliness.';
    }

    if (name.contains('first aid')) {
      return 'First Aid Supplies include essential medical items for treating minor injuries, cuts, burns, wounds, and emergency situations. They are useful for homes, offices, travel, clinics, and quick medical response.';
    }

    if (name.contains('wound')) {
      return 'Wound Care and Personal Care products help clean, protect, and heal wounds while maintaining personal hygiene. These items support safe recovery, infection prevention, and daily patient care.';
    }

    if (name.contains('home care') || name.contains('furniture')) {
      return 'Home Care and Furniture products are designed to make patient care easier, safer, and more comfortable at home. They support resting, movement, treatment, and recovery for elderly or physically weak patients.';
    }

    if (name.contains('diagnostic')) {
      return 'Diagnostic Devices help monitor important health conditions such as blood pressure, temperature, oxygen level, blood sugar, and other vital signs. They are useful for regular health checking at home, clinics, and hospitals.';
    }

    return 'This medical accessory is designed to support better health, comfort, safety, and daily care. It is useful for patients, caregivers, hospitals, clinics, and home medical needs.';
  }

  @override
  Widget build(BuildContext context) {
    const productName = 'Premium Medical Product';
    const price = '৳ 1,250';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    price,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2F6FED),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _details,
                    style: const TextStyle(
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
    );
  }
}
