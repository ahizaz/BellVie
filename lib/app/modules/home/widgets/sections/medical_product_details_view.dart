
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

    final name = categoryName.toLowerCase().trim().replaceAll('য়', 'য়');

    bool hasAny(List<String> keys) {
      return keys.any((key) {
        final normalizedKey = key.toLowerCase().trim().replaceAll('য়', 'য়');
        return name.contains(normalizedKey);
      });
    }

    if (hasAny([
      'bed wedge',
      'bed wedges',
      'wedge',
      'বেড ওয়েজ',
      'বেড ওয়েজ',
      'বেড ওয়েজেস',
      'বেড ওয়েজেস',
    ])) {
      return isBangla
          ? 'বেড ওয়েজ শরীরের উপরের অংশ, পা বা পায়ের পাতাকে আরামদায়কভাবে উঁচু রাখতে সাহায্য করে। এটি এসিডিটি, নাক ডাকা, পিঠের ব্যথা, ফোলাভাব এবং অস্ত্রোপচারের পর বিশ্রামে উপকারী।'
          : 'Bed Wedges help elevate the upper body, legs, or feet for better comfort, posture, and recovery support.';
    }

    if (hasAny([
      'respiratory',
      'respiratory units',
      'oxygen',
      'nebulizer',
      'শ্বাসযন্ত্র',
      'শ্বাসযন্ত্র ইউনিট',
      'অক্সিজেন',
      'নেবুলাইজার',
    ])) {
      return isBangla
          ? 'শ্বাসযন্ত্র ইউনিট শ্বাস-প্রশ্বাসে সহায়তা, অক্সিজেন থেরাপি, নেবুলাইজেশন এবং শ্বাসযন্ত্রের যত্নে ব্যবহৃত হয়। অ্যাজমা, সিওপিডি বা শ্বাসকষ্টে আক্রান্ত রোগীদের জন্য এটি উপকারী।'
          : 'Respiratory Units help patients with breathing support, oxygen therapy, nebulization, and respiratory care.';
    }

    if (hasAny([
      'mobility',
      'mobility aids',
      'walker',
      'wheelchair',
      'cane',
      'গতিশীলতা',
      'গতিশীলতা সহায়ক',
      'গতিশীলতা সহায়ক',
      'হুইলচেয়ার',
      'ওয়াকার',
    ])) {
      return isBangla
          ? 'গতিশীলতা সহায়ক পণ্য বয়স্ক ব্যক্তি, রোগী এবং আঘাত বা অস্ত্রোপচার থেকে সুস্থ হওয়া ব্যক্তিদের নিরাপদ চলাফেরায় সহায়তা করে। এটি ভারসাম্য, স্বাধীনতা ও আত্মবিশ্বাস বাড়ায়।'
          : 'Mobility Aids support safe movement, balance, independence, and confidence.';
    }

    if (hasAny([
      'face mask',
      'face masks',
      'mask',
      'glove',
      'gloves',
      'মুখের মাস্ক',
      'মাস্ক',
      'গ্লাভস',
    ])) {
      return isBangla
          ? 'ফেস মাস্ক ও গ্লাভস জীবাণু, ধুলোবালি, সংক্রমণ এবং দূষণ থেকে সুরক্ষা দেয়। হাসপাতাল, ক্লিনিক, হোম কেয়ার এবং দৈনন্দিন ব্যবহারে এটি উপযোগী।'
          : 'Face Masks and Gloves help protect users from germs, dust, infection, and contamination.';
    }

    if (hasAny([
      'first aid',
      'first aid supplies',
      'bandage',
      'ফার্স্ট এইড',
      'ফাস্ট এইড',
      'প্রাথমিক চিকিৎসা',
      'প্রাথমিক চিকিৎসার সরঞ্জাম',
      'ব্যান্ডেজ',
    ])) {
      return isBangla
          ? 'ফার্স্ট এইড সামগ্রী ছোটখাটো আঘাত, কাটা, পোড়া বা জরুরি পরিস্থিতিতে প্রাথমিক চিকিৎসা দিতে ব্যবহৃত হয়। এটি বাসা, অফিস, ভ্রমণ ও ক্লিনিকের জন্য গুরুত্বপূর্ণ।'
          : 'First Aid Supplies include essential medical items for treating minor injuries, cuts, burns, wounds, and emergency situations.';
    }

    if (hasAny([
      'wound',
      'wound care',
      'personal care',
      'ওয়াউন্ড',
      'ক্ষত',
      'ক্ষত পরিচর্যা',
      'ব্যক্তিগত পরিচর্যা',
      'পার্সোনাল কেয়ার',
    ])) {
      return isBangla
          ? 'ওয়াউন্ড কেয়ার ও পার্সোনাল কেয়ার পণ্য ক্ষত পরিষ্কার, সুরক্ষা এবং দ্রুত নিরাময়ে সহায়তা করে। এগুলো সংক্রমণ প্রতিরোধ ও দৈনন্দিন রোগী পরিচর্যায় গুরুত্বপূর্ণ ভূমিকা রাখে।'
          : 'Wound Care and Personal Care products help clean, protect, and heal wounds while maintaining personal hygiene.';
    }

    if (hasAny([
      'home care',
      'home care/furniture',
      'furniture',
      'hospital bed',
      'গৃহ',
      'গৃহ পরিচর্যা',
      'গৃহ পরিচর্যা/আসবাবপত্র',
      'পরিচর্যা/আসবাবপত্র',
      'আসবাবপত্র',
      'হোম',
      'হোম কেয়ার',
      'হোম কেয়ার',
      'ফার্নিচার',
      'মেডিকেল ফার্নিচার',
      'রোগীর বেড',
      'হাসপাতাল বেড',
    ])) {
      return isBangla
          ? 'গৃহ পরিচর্যা ও মেডিকেল আসবাবপত্র রোগীর যত্নকে আরও সহজ, নিরাপদ এবং আরামদায়ক করে। এটি বিশ্রাম, চিকিৎসা ও পুনর্বাসনে সহায়তা করে।'
          : 'Home Care and Medical Furniture products make patient care easier, safer, and more comfortable.';
    }

    if (hasAny([
      'diagnostic',
      'diagnostic devices',
      'bp',
      'pressure',
      'thermometer',
      'glucometer',
      'ডায়াগনস্টিক',
      'ডায়াগনস্টিক',
      'ডায়াগনস্টিক ডিভাইস',
      'প্রেশার',
      'রক্তচাপ',
      'থার্মোমিটার',
      'গ্লুকোমিটার',
      'সুগার',
    ])) {
      return isBangla
          ? 'ডায়াগনস্টিক ডিভাইস রক্তচাপ, শরীরের তাপমাত্রা, অক্সিজেন লেভেল, ব্লাড সুগারসহ বিভিন্ন স্বাস্থ্য সূচক পর্যবেক্ষণে ব্যবহৃত হয়।'
          : 'Diagnostic Devices help monitor blood pressure, body temperature, oxygen level, blood sugar, and other vital signs.';
    }

    return isBangla
        ? '$categoryName স্বাস্থ্য, আরাম, নিরাপত্তা এবং দৈনন্দিন পরিচর্যায় সহায়তা করার জন্য উপযোগী।'
        : '$categoryName is useful for better health, comfort, safety, and daily care.';
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
