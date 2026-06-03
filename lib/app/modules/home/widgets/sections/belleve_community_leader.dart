import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BelleveCommunityLeader extends StatelessWidget {
  const BelleveCommunityLeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isBangla = Get.locale?.languageCode == 'bn';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isBangla ? 'বেলভি কমিউনিটি লিডার' : 'BelleVie Community leader',
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
Who is a BelleVie Community Leader?

A BelleVie Community Leader is a locally respected individual who leads a team of BelleVie Health Volunteers. Their primary responsibility is to promote health awareness and distribute BelleVie Health Protection Cards among local people.

A Community Leader acts as a bridge between the community and BelleVie, ensuring that every family can access health protection and medical assistance easily and affordably.

Main Responsibilities of a Community Leader

1. Team Building

• Recruit and develop BelleVie Health Volunteers within their local area.
• Provide training on BelleVie services, health protection benefits, and customer support.

2. Community Awareness

• Organize health awareness meetings, courtyard gatherings, and local campaigns.
• Educate families about preventive healthcare and the benefits of the BelleVie Health Protection Card.

3. Card Distribution & Membership Growth

• Promote and distribute BelleVie Health Protection Cards.
• Ensure proper member registration and accurate record keeping.

4. Member Support

• Assist cardholders in accessing healthcare services according to their needs.
• Coordinate with the BelleVie support team to ensure quality service delivery.

5. Leadership & Performance Monitoring

• Guide volunteers in achieving their monthly targets.
• Maintain service quality and uphold community trust.

Proposed Commission Structure

BelleVie Health Protection Card Price: BDT 120

Community Leader's Own Sale → BDT 20
Volunteer's Direct Sale → BDT 15
Leadership Commission (from Volunteer Sales) → BDT 5
BelleVie Operations & Service Fund → BDT 80

Income Examples

Example 1: Leader's Own Sales

If a Community Leader sells 100 cards in a month:

100 × BDT 20 = BDT 2,000

Example 2: Team Sales

Suppose a Community Leader has 10 Volunteers under their team.

Each Volunteer sells 50 cards per month.

Total Sales:

10 × 50 = 500 cards

Leadership Commission:

500 × BDT 5 = BDT 2,500

Total Monthly Income

Own Sales Commission → BDT 2,000
Leadership Commission from Team → BDT 2,500
Total → BDT 4,500

Performance Incentives

🥈 Silver Leader
• Team Sales: 1,000 cards/month
• Bonus: BDT 1,000

🥇 Gold Leader
• Team Sales: 3,000 cards/month
• Bonus: BDT 5,000

💎 Platinum Leader
• Team Sales: 5,000+ cards/month
• Bonus: BDT 10,000+

Policy

Community Leaders earn commissions through:

• Their own direct sales
• Training, supervising, and supporting Volunteers

The primary focus is on expanding healthcare access and community development, where income is generated through actual card distribution and service delivery—not merely through recruiting people.

BelleVie Leaders' Motto

Leading people toward better health protection, earning through service, and contributing to the creation of a healthier and safer society.
''';

const String _banglaContent = '''
BelleVie Community Leader কে?

BelleVie Community Leader হলেন স্থানীয়ভাবে সম্মানিত একজন ব্যক্তি, যিনি BelleVie Health Volunteers-এর একটি দল পরিচালনা করেন।

তাদের মূল কাজ হলো স্বাস্থ্য সচেতনতা বৃদ্ধি করা এবং স্থানীয় মানুষের মধ্যে BelleVie Health Protection Card পৌঁছে দেওয়া।

Community Leader স্থানীয় জনগণ এবং BelleVie-এর মধ্যে একটি সেতুবন্ধন হিসেবে কাজ করেন, যাতে প্রতিটি পরিবার সহজে ও সাশ্রয়ী মূল্যে স্বাস্থ্য সুরক্ষা এবং চিকিৎসা সহায়তা পেতে পারে।

Community Leader-এর প্রধান দায়িত্বসমূহ:

১. টিম গঠন

• নিজ এলাকার মধ্যে BelleVie Health Volunteers নিয়োগ ও উন্নয়ন করা।
• BelleVie সেবা, স্বাস্থ্য সুরক্ষা সুবিধা এবং গ্রাহক সহায়তা বিষয়ে প্রশিক্ষণ প্রদান করা।

২. কমিউনিটি সচেতনতা

• স্বাস্থ্য সচেতনতা সভা, উঠান বৈঠক এবং স্থানীয় ক্যাম্পেইন আয়োজন করা।
• পরিবারগুলোকে প্রতিরোধমূলক স্বাস্থ্যসেবা এবং BelleVie Health Protection Card-এর সুবিধা সম্পর্কে জানানো।

৩. কার্ড বিতরণ ও সদস্য বৃদ্ধি

• BelleVie Health Protection Card প্রচার ও বিতরণ করা।
• সদস্যদের সঠিক নিবন্ধন ও তথ্য সংরক্ষণ নিশ্চিত করা।

৪. সদস্য সহায়তা

• কার্ডধারীদের প্রয়োজন অনুযায়ী স্বাস্থ্যসেবা গ্রহণে সহায়তা করা।
• BelleVie সাপোর্ট টিমের সাথে সমন্বয় করে মানসম্মত সেবা নিশ্চিত করা।

৫. নেতৃত্ব ও পারফরম্যান্স পর্যবেক্ষণ

• ভলান্টিয়ারদের মাসিক লক্ষ্য পূরণে দিকনির্দেশনা দেওয়া।
• সেবার মান বজায় রাখা এবং কমিউনিটির আস্থা ধরে রাখা।

প্রস্তাবিত কমিশন কাঠামো

BelleVie Health Protection Card-এর মূল্য: ১২০ টাকা

Community Leader-এর নিজস্ব বিক্রয় → ৳২০

Volunteer-এর সরাসরি বিক্রয় → ৳১৫

Leadership কমিশন (Volunteer-এর বিক্রয় থেকে) → ৳৫

BelleVie অপারেশন ও সার্ভিস ফান্ড → ৳৮০

আয়ের উদাহরণ

উদাহরণ ১: Leader-এর নিজস্ব বিক্রয়

যদি একজন Community Leader এক মাসে ১০০টি কার্ড বিক্রি করেন:

১০০ × ৳২০ = ৳২,০০০

উদাহরণ ২: টিমের বিক্রয়

ধরা যাক, একজন Leader-এর অধীনে ১০ জন Volunteer রয়েছে।

প্রতিজন মাসে ৫০টি করে কার্ড বিক্রি করে।

মোট বিক্রয়:

১০ × ৫০ = ৫০০টি কার্ড

Leadership কমিশন:

৫০০ × ৳৫ = ৳২,৫০০

মোট মাসিক আয়

নিজস্ব বিক্রয় কমিশন → ৳২,০০০

টিম থেকে Leadership কমিশন → ৳২,৫০০

মোট → ৳৪,৫০০

পারফরম্যান্স ইনসেনটিভ

🥈 Silver Leader

• টিম বিক্রয়: ১,০০০ কার্ড/মাস
• বোনাস: ৳১,০০০

🥇 Gold Leader

• টিম বিক্রয়: ৩,০০০ কার্ড/মাস
• বোনাস: ৳৫,০০০

💎 Platinum Leader

• টিম বিক্রয়: ৫,০০০+ কার্ড/মাস
• বোনাস: ৳১০,০০০+

নীতিমালা

Community Leader কমিশন পাবেন—

• নিজের সরাসরি বিক্রয় থেকে
• ভলান্টিয়ারদের প্রশিক্ষণ, তদারকি ও সহায়তা করার মাধ্যমে

👉 এখানে মূল গুরুত্ব দেওয়া হয় স্বাস্থ্যসেবা সম্প্রসারণ ও কমিউনিটি উন্নয়নে, যেখানে আয় হয় বাস্তব কার্ড বিতরণ ও সেবা প্রদানের মাধ্যমে — শুধু লোক নিয়োগের উপর নয়।

BelleVie নেতাদের মূলমন্ত্র

মানুষের স্বাস্থ্য সুরক্ষার পথে নেতৃত্ব দেয়া, সেবার মাধ্যমে আয় করা এবং একটি সুস্থ ও নিরাপদ সমাজ গঠনে ভূমিকা রাখা।
''';
