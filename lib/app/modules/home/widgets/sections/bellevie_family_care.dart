import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BellevieFamilyCare extends StatelessWidget {
  const BellevieFamilyCare({super.key});

  @override
  Widget build(BuildContext context) {
    final isBangla = Get.locale?.languageCode == 'bn';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isBangla ? 'বেলেভি ফ্যামিলি কেয়ার' : 'BelleVie Family Care',
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
BelleVie Family Care Package

This is a service where all members of a family can receive healthcare services, medical assistance, and financial protection benefits under a single membership or health protection package.

This package is designed based on globally successful family health plans. Its key feature is the inclusion of multiple family members under one membership, providing preventive healthcare services, health screenings, medical coordination, and exclusive discounts.

Who Can Be Included in This Package?

* Husband and Wife
* Up to 2–3 Children
* Parents (Optional)

 Membership Fees

* **Basic Family:** BDT 299/month
* **Premium Family:** BDT 499/month
* **Elite Family:** BDT 999/month

 Benefits

 1. 24/7 Health Assistance

 * BelleVie Health Hotline
 * Medical guidance and consultation support
 * Hospital and doctor referral services

 2. Digital Health Records

* Secure storage of health information for all family members
* Prescription and medical report archive

 3. Telemedicine Services

* A specified number of free video/audio consultations
* Specialist doctor appointment assistance

4. Annual Health Check-Up

* **Basic:** 1 family member
* **Premium:** 2 family members
* **Elite:** All adult family members

5. Hospital Assistance

* Admission process support
* Estimated treatment cost guidance
* Second Opinion services

6. Discount Benefits

* 10–30% discount on diagnostic tests
* 5–15% discount on medicines
* Special discounts at partner hospitals and clinics

7. Critical Illness Support Fund

Opportunity to apply for emergency financial assistance through the BelleVie Charity Fund.

8. Family Health Score

Through the BelleVie App:

* BMI Assessment
* Diabetes Risk Assessment
* Heart Disease Risk Assessment
* Health Awareness Report

Additional Income Opportunities

For BelleVie Community Leaders & Partners

* Commission on every Family Package sale
* Renewal commissions
* Incentives from family member upgrades

The Strongest Model for BelleVie

One Family, One Health Protection Umbrella

For a small monthly subscription, the entire family will receive:

* Health consultation and guidance
* Medical coordination services
* Health check-ups
* Hospital assistance
* Exclusive discounts
* Priority access to emergency support funds
''';

const String _banglaContent = '''
BelleVie- Family Care Package

এটি এমন একটি সেবা যেখানে একটি পরিবারের সকল সদস্য একটি সদস্যপদ বা স্বাস্থ্য সুরক্ষা প্যাকেজের আওতায় থেকে স্বাস্থ্যসেবা, চিকিৎসা সহায়তা এবং আর্থিক সুরক্ষার সুবিধা পাবে। 

এটি বিশ্বব্যাপী সফল ফ্যামিলি হেলথ প্ল্যানগুলোর আদলেই তৈরি করা একটি প্যাকেজ। এই প্যাকেজের সাধারণ বৈশিষ্ট্য হলো এক সদস্যপদে একাধিক পরিবারের সদস্যকে এই প্যাকেজে অন্তর্ভুক্ত করা, 

এতে প্রতিরোধমূলক স্বাস্থ্যসেবা, স্বাস্থ্য পরীক্ষা, চিকিৎসা সমন্বয় এবং বিশেষ ছাড় প্রদান। 

কারা এই প্যাকেজের অন্তর্ভুক্ত হবে?

* স্বামী ও স্ত্রী
* সর্বোচ্চ ২-৩ জন সন্তান
* ঐচ্ছিকভাবে বাবা-মা

সদস্যপদ ফীঃ

* Basic Family: ২৯৯ টাকা/মাস
* Premium Family: ৪৯৯ টাকা/মাস
* Elite Family: ৯৯৯ টাকা/মাস

সুবিধাসমূহ

১. ২৪/৭ স্বাস্থ্য সহায়তা

* BelleVie Health Hotline
* চিকিৎসা সংক্রান্ত পরামর্শ
* হাসপাতাল ও ডাক্তার রেফারেন্স।

 ২. ডিজিটাল হেলথ রেকর্ড।

* পরিবারের সকল সদস্যের স্বাস্থ্য তথ্য সংরক্ষণ।
* প্রেসক্রিপশন ও রিপোর্ট আর্কাইভ।

৩. টেলিমেডিসিন।

* নির্দিষ্ট সংখ্যক ফ্রি ভিডিও/অডিও কনসালটেশন
* বিশেষজ্ঞ চিকিৎসকের অ্যাপয়েন্টমেন্ট সুবিধা।

৪. বার্ষিক স্বাস্থ্য পরীক্ষা

* Basic: ১ জন
* Premium: ২ জন
* Elite: পরিবারের সকল প্রাপ্তবয়স্ক সদস্য

৫. হাসপাতাল সহায়তা

* ভর্তি প্রক্রিয়ায় সহায়তা
* চিকিৎসা খরচের আনুমানিক হিসাব
* দ্বিতীয় মতামত (Second Opinion)

৬. ডিসকাউন্ট সুবিধা

* ডায়াগনস্টিক টেস্টে ১০-৩০%
* ওষুধে ৫-১৫%
* পার্টনার হাসপাতাল ও ক্লিনিকে বিশেষ ছাড়

৭. Critical Illness Support Fund

BelleVie Charity Fund থেকে জরুরি আর্থিক সহায়তার জন্য আবেদন করার সুযোগ।

৮. পরিবার স্বাস্থ্য স্কোর

অ্যাপের মাধ্যমে:

* BMI
* ডায়াবেটিস ঝুঁকি
* হৃদরোগ ঝুঁকি
* স্বাস্থ্য সচেতনতা রিপোর্ট

অতিরিক্ত আয়ের সুযোগ

BelleVie Community Leaders ও Partners:

* প্রতি Family Package বিক্রয়ে কমিশন
* নবায়নে কমিশন
* পরিবারের সদস্যদের আপগ্রেড থেকে ইনসেনটিভ

BelleVie-এর জন্য সবচেয়ে শক্তিশালী মডেল

একটি পরিবার, একটি স্বাস্থ্য নিরাপত্তা ছাতা

প্রতি মাসে একটি ছোট সাবস্ক্রিপশনের বিনিময়ে পুরো পরিবার পাবে:

* স্বাস্থ্য পরামর্শ
* চিকিৎসা সমন্বয়
* স্বাস্থ্য পরীক্ষা
* হাসপাতাল সহায়তা
* বিশেষ ছাড়
* জরুরি সহায়তা ফান্ডে অগ্রাধিকার।
''';
