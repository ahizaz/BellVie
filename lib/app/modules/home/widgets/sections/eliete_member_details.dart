import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EliteMembershipPage extends StatelessWidget {
  const EliteMembershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isBangla = Get.locale?.languageCode == 'bn';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isBangla ? 'বেলভি এলিট সদস্য' : 'BelleVie Elite Members',
        ),
        backgroundColor: const Color(0xFF2F6FED),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          isBangla ? _banglaContent : _englishContent,
          style: const TextStyle(
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}

const String _englishContent = '''
BelleVie Elite Membership

BelleVie Elite Membership is our premium membership program, designed for individuals and families who seek greater healthcare assurance, faster service, and personalized support.

Through this membership, you will enjoy an enhanced healthcare experience where every service is delivered with greater convenience, speed, and priority.

Exclusive Benefits for BelleVie Elite Members

• Priority-based medical assistance
• Faster access to doctors and hospitals
• Dedicated personal care support
• Rapid coordination during emergencies
• Professional healthcare guidance and consultation
• Personalized assistance whenever needed

Dedicated Support Services

Every Elite Member receives access to exclusive support services, including:

• Direct communication with the BelleVie Support Team
• Guidance for healthcare-related decisions
• Assistance with hospital selection and appointment scheduling
• Fast, reliable, and hassle-free support

A Faster & Smoother Healthcare Experience

As a BelleVie Elite Member, you will benefit from:

• Reduced waiting times
• Faster response and assistance
• Access to a trusted healthcare network
• Simplified healthcare management

Why Become an Elite Member?

• Enhanced protection for yourself and your family
• Immediate support during emergencies
• Premium healthcare service experience
• Hassle-free medical coordination
• Greater peace of mind and confidence

Who Can Become an Elite Member?

• Individuals
• Families
• Business owners and professionals
• Corporate teams
• Anyone seeking a higher standard of healthcare support

Our Commitment

For every BelleVie Elite Member, we are committed to providing:

• Fast and efficient service
• Personalized care and attention
• Reliable healthcare coordination
• The highest standard of service experience

BelleVie Elite Membership — Premium Care, Priority Access, Complete Peace of Mind.
''';

const String _banglaContent = '''
BelleVie Elite Members হলো:

আমাদের প্রিমিয়াম সদস্যপদ,
যা তাদের জন্য তৈরি করা হয়েছে যারা স্বাস্থ্য সুরক্ষায় আরও বেশি নিশ্চয়তা, দ্রুততা এবং ব্যক্তিগত সহায়তা চান।

এই সদস্যপদের মাধ্যমে আপনি পাবেন একটি উন্নতমানের স্বাস্থ্য সুরক্ষা অভিজ্ঞতা, যেখানে প্রতিটি সেবা হবে আরও সহজ, দ্রুত এবং অগ্রাধিকার ভিত্তিতে।

BelleVie Elite Members দের জন্য থাকছে বিশেষ সুবিধাসমূহ—

• অগ্রাধিকার ভিত্তিতে চিকিৎসা সহায়তা
• দ্রুত ডাক্তার ও হাসপাতাল সংযোগ
• ব্যক্তিগত কেয়ার সাপোর্ট (Dedicated Support)
• জরুরি অবস্থায় দ্রুত সেবা সমন্বয়
• উন্নতমানের গাইডলাইন ও পরামর্শ
• ব্যক্তিগত সহায়তা (Dedicated Support)

প্রতিটি Elite Member এর জন্য থাকবে বিশেষ সাপোর্ট সুবিধা, যেখানে—

• প্রয়োজন অনুযায়ী সরাসরি BelleVie সাপোর্ট টিমের সাথে যোগাযোগ
• চিকিৎসা সংক্রান্ত সিদ্ধান্তে দিকনির্দেশনা
• হাসপাতাল নির্বাচন ও অ্যাপয়েন্টমেন্ট সেটআপে সহায়তা
• দ্রুত ও নির্ভরযোগ্য সেবা

Elite Members দের জন্য সেবা গ্রহণ হবে আরও সহজ ও দ্রুত—

• কম অপেক্ষার সময়
• দ্রুত রেসপন্স
• নির্ভরযোগ্য নেটওয়ার্কের মাধ্যমে চিকিৎসা সুবিধা

কেন Elite Member হবেন?

• নিজের এবং পরিবারের জন্য বাড়তি নিরাপত্তা
• জরুরি মুহূর্তে দ্রুত সাপোর্ট
• প্রিমিয়াম লেভেলের স্বাস্থ্যসেবা অভিজ্ঞতা
• ঝামেলাহীন চিকিৎসা ব্যবস্থাপনা
• মানসিক স্বস্তি ও নিশ্চয়তা

কারা Elite Member হতে পারবেন?

• ব্যক্তি বা পরিবার
• ব্যবসায়ী ও পেশাজীবী
• কর্পোরেট টিম
• যারা উন্নতমানের স্বাস্থ্যসেবা চান

আমাদের প্রতিশ্রুতি

BelleVie Elite Members দের জন্য আমরা প্রতিশ্রুতিবদ্ধ—

• দ্রুত সেবা
• ব্যক্তিগত যত্ন
• নির্ভরযোগ্য সহযোগিতা
• সর্বোচ্চ মানের অভিজ্ঞতা
''';
