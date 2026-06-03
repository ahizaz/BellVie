import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrowthWithBellevie extends StatelessWidget {
  const GrowthWithBellevie({super.key});

  @override
  Widget build(BuildContext context) {
    final isBangla = Get.locale?.languageCode == 'bn';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isBangla ? 'বেলেভির সাথে বেড়ে উঠুন' : 'Grow with Bellevie',
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
Grow with BelleVie

Your Health, Your Service, Your Path to Income

BelleVie believes that good health is not just a service—it is a social movement. That is why we have created a platform where you can not only access healthcare services but also build a respectable source of income by helping bring healthcare solutions to your community.

Who Can Become a BelleVie Community Leader or Partner?

BelleVie Community Leaders and Partners serve as our local representatives. They introduce family members, friends, neighbors, and community members to the benefits of the BelleVie Health Protection Card and the BelleVie App, while also assisting them in accessing healthcare services whenever needed.

To become a BelleVie Community Leader or Partner, simply apply through the WhatsApp number provided in the BelleVie App.

How Can You Earn?
Commission on Every Health Protection Card Sale

Earn attractive commissions for every member you successfully register through your efforts.

Additional Incentives Through Team Building

As a Community Leader, you can build and manage an active team. Based on your team’s performance and achievements, you will have opportunities to earn additional leadership allowances and performance incentives.

Income from App Subscriptions

By encouraging members to subscribe to various services available on the BelleVie App, you can earn regular commissions and performance-based bonuses.

Monthly and Annual Rewards

High-performing Community Leaders and Partners who achieve designated targets may qualify for special cash rewards, recognition awards, gifts, and opportunities for local and international travel.

More Than Just Income

When you join BelleVie, you also enjoy a range of additional benefits:

Recognition as a health-conscious leader in your community.
Access to exclusive BelleVie training and skill development programs.
Priority access to healthcare services, medical assistance, and special benefits.
Opportunities for leadership development and career growth.
Access to BelleVie’s expanding social and business networks.
Our Mission

Our mission is to build a healthier, more informed, and protected society where every family can easily access healthcare services while community leaders create sustainable income opportunities for themselves.

Join BelleVie. Spread the message of health protection, support your community, and build a successful future for yourself.

BelleVie Global Health Services
Caring for Health, Creating Opportunities.
''';
const String _banglaContent = '''
Grow with BelleVie

আপনার সুস্বাস্থ্য, আপনার সেবা, আপনার আয়ের পথ হতে পারে।

BelleVie বিশ্বাস করে যে সুস্বাস্থ্য শুধুমাত্র একটি সেবা নয়, বরং একটি সামাজিক আন্দোলন। তাই আমরা তৈরি করেছি এমন একটি প্ল্যাটফর্ম যেখানে আপনি শুধু স্বাস্থ্যসেবা গ্রহণই করবেন না, বরং সমাজে স্বাস্থ্যসেবা পৌঁছে দেওয়ার মাধ্যমে নিজের জন্যও একটি সম্মানজনক আয়ের সুযোগ তৈরি করতে পারবেন।

BelleVie Community Leader ও Partner হবেন কারা?

BelleVie Community Leader এবং Partner হবেন আমাদের স্থানীয় প্রতিনিধি, যারা তাদের পরিবার, বন্ধু, প্রতিবেশী এবং কমিউনিটির মানুষদের BelleVie Health Protection Card ও BelleVie App-এর সুবিধার সাথে পরিচিত করেন এবং প্রয়োজনে তাদের সেবা গ্রহণে সহায়তা করেন। 
Bellevie Community Leader বা Partner হতে হলে আবেদন করুন BelleVie এর 
App এ দেয়া হোয়াটসআপ নাম্বারে।

কীভাবে আয় করবেন?

প্রতিটি Health Protection Card বিক্রয়ের উপর কমিশনঃ

আপনার মাধ্যমে নিবন্ধিত প্রতিটি সদস্যের জন্য আকর্ষণীয় কমিশন প্রদান করা হবে।

টিম গঠন করে অতিরিক্ত ইনসেনটিভঃ

Community Leader হিসেবে আপনি একটি সক্রিয় টিম গড়ে তুলতে পারবেন। আপনার টিমের সদস্যদের কার্যক্রম ও সাফল্যের ভিত্তিতে অতিরিক্ত নেতৃত্ব ভাতা ও ইনসেনটিভ অর্জনের সুযোগ থাকবে।

App Subscription থেকে আয়ঃ

BelleVie App-এর বিভিন্ন সাবস্ক্রিপশন সেবা গ্রহণে উৎসাহিত করে আপনি নিয়মিত কমিশন ও পারফরম্যান্স বোনাস পেতে পারেন।

মাসিক ও বার্ষিক পুরস্কারঃ

নির্ধারিত লক্ষ্য অর্জনকারীদের জন্য থাকবে বিশেষ নগদ পুরস্কার, সম্মাননা, উপহার এবং দেশ-বিদেশ ভ্রমণের সুযোগ।

শুধু আয় নয়, আরও অনেক সুবিধা পাচ্ছেন যা হলোঃ

সমাজে একজন স্বাস্থ্যসচেতন নেতা হিসেবে পরিচিতি।

BelleVie-এর বিশেষ প্রশিক্ষণ ও দক্ষতা উন্নয়ন কর্মসূচিতে অংশগ্রহণ।

স্বাস্থ্যসেবা, চিকিৎসা সহায়তা এবং বিশেষ সুবিধায় অগ্রাধিকার

নেতৃত্ব বিকাশ ও ক্যারিয়ার উন্নয়নের সুযোগ।

BelleVie-এর বিভিন্ন সামাজিক ও ব্যবসায়িক নেটওয়ার্কের সাথে সংযুক্ত হওয়ার সুযোগ।

আমাদের লক্ষ্যঃ

আমরা এমন একটি স্বাস্থ্যবান, সচেতন ও সুরক্ষিত সমাজ গড়ে তুলতে চাই যেখানে প্রতিটি পরিবার সহজে স্বাস্থ্যসেবার আওতায় আসবে এবং সেই সঙ্গে কমিউনিটির নেতারা নিজেদের জন্য একটি টেকসই আয়ের পথ তৈরি করতে পারবেন।

BelleVie-এর সঙ্গে যুক্ত হোন। স্বাস্থ্য সুরক্ষার বার্তা ছড়িয়ে দিন, মানুষের পাশে দাঁড়ান, এবং নিজের সফল ভবিষ্যৎ গড়ে তুলুন।

BelleVie Global Health Services...Caring for Health, Creating Opportunities.
''';
