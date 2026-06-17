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
    final isBangla = Get.locale?.languageCode == 'bn';
    final name = categoryName.toLowerCase().trim();

    if (name.contains('bed wedge')) {
      return isBangla
          ? 'বেড ওয়েজ হলো বিশেষভাবে তৈরি সাপোর্ট পিলো যা শরীরের উপরের অংশ, পা বা পায়ের পাতাকে উঁচু রাখতে সাহায্য করে। এটি এসিডিটি, নাক ডাকা, পিঠের ব্যথা, ফোলাভাব এবং রক্ত সঞ্চালনের সমস্যায় উপকারী। অস্ত্রোপচারের পর বিশ্রাম ও সুস্থতায়ও এটি সহায়তা করে।'
          : 'Bed Wedges are specially designed support pillows that elevate the upper body, legs, or feet to improve comfort and promote better posture. They help reduce acid reflux, snoring, back pain, swelling, and circulation problems while sleeping, resting, or recovering after surgery. Made from high-density foam, bed wedges provide ergonomic support for enhanced relaxation and health benefits.';
    }

    if (name.contains('respiratory')) {
      return isBangla
          ? 'রেসপিরেটরি ইউনিট শ্বাস-প্রশ্বাসে সহায়তা, অক্সিজেন থেরাপি, নেবুলাইজেশন এবং শ্বাসযন্ত্রের যত্নে ব্যবহৃত হয়। অ্যাজমা, সিওপিডি বা শ্বাসকষ্টে আক্রান্ত রোগীদের জন্য এটি উপকারী।'
          : 'Respiratory Units help patients with breathing support, oxygen therapy, nebulization, and respiratory care. These devices are useful for people with asthma, COPD, breathing difficulty, or post-treatment recovery needs.';
    }

    if (name.contains('mobility')) {
      return isBangla
          ? 'মোবিলিটি এইডস বয়স্ক ব্যক্তি, রোগী এবং অস্ত্রোপচার বা আঘাত থেকে সুস্থ হওয়া ব্যক্তিদের নিরাপদ চলাফেরায় সহায়তা করে। এটি ভারসাম্য, স্বাধীনতা ও আত্মবিশ্বাস বৃদ্ধি করে।'
          : 'Mobility Aids are designed to support safe movement for elderly people, patients, and individuals recovering from injury or surgery. They help improve balance, independence, comfort, and confidence during daily activities.';
    }

    if (name.contains('face mask') || name.contains('glove')) {
      return isBangla
          ? 'ফেস মাস্ক ও গ্লাভস জীবাণু, ধুলোবালি, সংক্রমণ এবং দূষণ থেকে সুরক্ষা দেয়। হাসপাতাল, ক্লিনিক, হোম কেয়ার এবং দৈনন্দিন স্বাস্থ্য সুরক্ষায় ব্যাপকভাবে ব্যবহৃত হয়।'
          : 'Face Masks and Gloves help protect users from germs, dust, infection, and contamination. They are commonly used in hospitals, clinics, home care, and daily hygiene practices to maintain safety and cleanliness.';
    }

    if (name.contains('first aid')) {
      return isBangla
          ? 'ফার্স্ট এইড সামগ্রী ছোটখাটো আঘাত, কাটা, পোড়া বা জরুরি পরিস্থিতিতে প্রাথমিক চিকিৎসা দিতে ব্যবহৃত হয়। এটি বাসা, অফিস, ভ্রমণ ও ক্লিনিকের জন্য গুরুত্বপূর্ণ।'
          : 'First Aid Supplies include essential medical items for treating minor injuries, cuts, burns, wounds, and emergency situations. They are useful for homes, offices, travel, clinics, and quick medical response.';
    }

    if (name.contains('wound')) {
      return isBangla
          ? 'ওয়াউন্ড কেয়ার ও পার্সোনাল কেয়ার পণ্য ক্ষত পরিষ্কার, সুরক্ষা এবং দ্রুত নিরাময়ে সহায়তা করে। এগুলো সংক্রমণ প্রতিরোধ ও দৈনন্দিন রোগী পরিচর্যায় গুরুত্বপূর্ণ ভূমিকা রাখে।'
          : 'Wound Care and Personal Care products help clean, protect, and heal wounds while maintaining personal hygiene. These items support safe recovery, infection prevention, and daily patient care.';
    }

    if (name.contains('home care') || name.contains('furniture')) {
      return isBangla
          ? 'হোম কেয়ার ও মেডিকেল ফার্নিচার রোগীর যত্নকে আরও সহজ, নিরাপদ এবং আরামদায়ক করে। এটি বিশ্রাম, চিকিৎসা ও পুনর্বাসনে সহায়তা করে।'
          : 'Home Care and Furniture products are designed to make patient care easier, safer, and more comfortable at home. They support resting, movement, treatment, and recovery for elderly or physically weak patients.';
    }

    if (name.contains('diagnostic')) {
      return isBangla
          ? 'ডায়াগনস্টিক ডিভাইস রক্তচাপ, শরীরের তাপমাত্রা, অক্সিজেন লেভেল, ব্লাড সুগারসহ বিভিন্ন স্বাস্থ্য সূচক পর্যবেক্ষণে ব্যবহৃত হয়।'
          : 'Diagnostic Devices help monitor important health conditions such as blood pressure, temperature, oxygen level, blood sugar, and other vital signs. They are useful for regular health checking at home, clinics, and hospitals.';
    }

    return isBangla
        ? 'এই মেডিকেল অ্যাক্সেসরিটি স্বাস্থ্য, আরাম, নিরাপত্তা এবং দৈনন্দিন পরিচর্যায় সহায়তা করার জন্য তৈরি। এটি রোগী, সেবাদানকারী, হাসপাতাল ও ক্লিনিকের জন্য উপযোগী।'
        : 'This medical accessory is designed to support better health, comfort, safety, and daily care. It is useful for patients, caregivers, hospitals, clinics, and home medical needs.';
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
