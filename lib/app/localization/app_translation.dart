import 'package:get/get.dart';

String localizedPremiumPlanName(String key) {
  final isBn = Get.locale?.languageCode == 'bn';
  if (isBn) {
    final bnName = '${key}_bn'.tr;
    final enName = Get.translations['en_US']?[key] ?? key;
    return '$bnName ($enName)';
  }
  final enName = key.tr;
  final bnName = '${key}_bn'.tr;
  return '$enName ($bnName)';
}

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'my_account': 'My Account',

          'bellevie_compassion_fund_title': 'BelleVie Compassion Fund',

          'bellevie_compassion_fund_description':
              '''Together for Health, Together for Humanity…

Every day, countless families face the harsh reality of serious illnesses, yet many lack the financial means to access timely medical treatment.

For many people, a critical illness is not only a threat to their health—it also jeopardizes their dignity, stability, and hope.

To address this urgent social need, BelleVie is establishing the BelleVie Compassion Fund, a dedicated charitable initiative aimed at providing financial assistance and medical support to underprivileged individuals suffering from serious illnesses.

The purpose of this fund is to bridge the gap between medical needs and financial capability. By harnessing the collective generosity of individuals, businesses, and organizations, we aspire to build a society where access to healthcare is not determined by economic status.

Why is this Fund Important?

Life-threatening diseases such as cancer, heart disease, stroke, kidney failure, and other critical illnesses place an unbearable burden on families.

Many patients delay treatment or discontinue it midway simply because they cannot afford the cost of medical care.

Through the BelleVie Compassion Fund, our goals are to:

• Help financially disadvantaged patients access the medical treatment they need
• Restore hope and dignity to families facing health crises
• Foster a culture of social responsibility and mutual support
• Create a sustainable platform where every contribution can make a meaningful difference

Categories of Donors

Corporate Partners

Corporate organizations, businesses, and institutions are invited to join the BelleVie Compassion Fund as Corporate Partners. Through financial contributions, sponsorships, and CSR initiatives, they can play a vital role in making healthcare more accessible to underserved communities while demonstrating their commitment to social responsibility.

Individual Donors

Individuals who wish to make a difference can contribute to this fund according to their capacity. Every donation—large or small—gives someone renewed hope for life. By participating in this initiative, individuals become part of a compassionate community committed to standing beside people during their most difficult times.

Join This Noble Initiative

Healthcare is not merely a service—it is a shared humanitarian responsibility.

By contributing to the BelleVie Compassion Fund, you become part of a movement that transforms compassion into action and generosity into healing.

Together, we can ensure that no one is deprived of a life-saving opportunity because of financial hardship.

Join us today as a Corporate Partner or Individual Donor and help build a healthier, more compassionate society.''',
          // Premium Plans
          'shohay': 'Shohay',
          'nirbhor': 'Nirbhor',
          'shoshti': 'Shoshti',
          'aastha': 'Aastha',
          'prottoy': 'Prottoy',

          'shohay_bn': 'সহায়',
          'nirbhor_bn': 'নির্ভর',
          'shoshti_bn': 'স্বস্তি',
          'aastha_bn': 'আস্থা',
          'prottoy_bn': 'প্রত্যয়',
          'community_health_services_title':
              'BelleVie Community Health Service',

          'community_health_services_description':
              '''BelleVie Community Health Service

Together for Health Protection, Towards a Safer Future

BelleVie Community Health Service is a people-centered healthcare protection initiative designed to provide affordable, accessible, and reliable healthcare support at the doorstep of every community.

Through this service, individuals, families, friends, social organizations, and communities can collectively enroll in the BelleVie Health Protection Card program and become part of a strong network of mutual support.

Members within this network are protected from unexpected healthcare-related financial risks. This means that when illness strikes unexpectedly, they do not have to worry about the financial burden of medical treatment.

How It Works

Through community-based registration, members of society can collectively obtain BelleVie Health Protection Cards, making healthcare protection more accessible, organized, and effective.

Community Volunteer Support

Each community will be supported by trained BelleVie Community Volunteers who will assist members in:

• Understanding the benefits and features of the Health Protection Card
• Completing the registration process
• Collecting and activating their cards
• Receiving guidance on accessing healthcare services when needed
• Connecting with the BelleVie Support Team whenever required

Support When It Matters Most

Whenever a cardholder requires medical assistance, healthcare consultation, hospital-related support, or service coordination, BelleVie Volunteers and our Support Team will be there to assist them.

The Role of Community Volunteers

The driving force behind BelleVie Community Health Service is our dedicated Community Volunteers.

They help spread awareness about healthcare protection within their communities and provide support whenever needed.

In recognition of their valuable contribution, volunteers receive commission benefits based on the designated tariff of the Health Protection Cards they distribute.

This creates a sustainable ecosystem where:

• Communities benefit from affordable healthcare protection.
• Cardholders benefit from reliable support and easy access to healthcare services.
• Volunteers benefit from fair compensation for their service and dedication.

Why Join?

• Affordable healthcare protection
• Trusted support from your own community
• Quick assistance when needed
• Simple registration and guidance process
• Opportunity to serve society while earning an income

Our Commitment

We believe that healthcare protection is a fundamental right for everyone.

BelleVie Community Health Service is committed to building a new culture of mutual support, awareness, and healthcare security within communities.

BelleVie Community Health Service

Together in Protection, Together in Support, Together in Prosperity.''',

          'yearly_premium': 'Yearly Premium',
          'life_coverage': 'Life Coverage',
          'accidental_death_benefit': 'Accidental Death Benefit',
          'permanent_disability':
              'Permanent Partial Disability & Permanent Total Disability',
          'critical_illness': 'Critical Illness',
          'hospicash': 'Hospicash',
          'opd': 'OPD',
          'telemedicine': 'Telemedicine',
          'discount_facilities': 'Discount Facilities',

          // Probashi
          'yearly_premium_bdt': 'Annual Premium (BDT)',
          'life': 'Life',
          'permanent_total_disability': 'Permanent Total Disability',
          'permanent_partial_disability': 'Permanent Partial Disability',
          'funeral_benefit': 'Funeral Benefit',
          'dead_body_repatriation': 'Repatriation of Mortal Remains',
          'loss_of_income': 'Loss of Income (max six months)',
          'hospitalization': 'Hospitalization',
          'telemedicine_24_7': 'Telemedicine',
          'probashi_value_funeral': 'Up to 20,000',
          'probashi_value_hospitalization':
              '50,000 (BDT 5000/day, up to 5 days in a row)',
          'probashi_value_telemedicine':
              '24/7 Unlimited Audio & Video Doctor Consultancy (Up to Six member of Family)',
          'bellevie_guardian_nrb': 'Bellevie Guardian NRB Health Support',
          'bellevie_guardian': 'Bellevie Guardian Health Programme',
          'app_title': 'BelleVie Global Health Services',
          'login': 'Login',
          'sign_in': 'Sign In',
          'dont_have_account': "Don't have an account?",
          'registration': 'Registration',
          'country_code': 'Country code',
          'phone_number': 'Phone number',
          'password': 'Password',
          'name': 'Name',
          'email_optional': 'Email (optional)',
          'district': 'District',
          'confirm_password': 'Confirm password',
          'register': 'Register',
          'already_have_account': 'Already have an account?',
          'home': 'Home',
          'my_appointments': 'My Appointments',
          'my_health': 'My Health',
          'cart': 'Cart',
          'records': 'Records',
          'menu': 'Menu',
          'english': 'English',
          'bangla': 'Bangla',
          'emergency_services': 'Emergency Services',
          'emergency_services_screen': 'Emergency Services',
          'emergency_fast_response': 'Fast response, 24/7',
          'emergency_subtitle':
              'Choose the right emergency transport service when every minute matters.',
          'available_services': 'Available Services',
          'ambulance': 'Ambulance',
          'ambulance_subtitle':
              'Basic emergency transport with rapid dispatch.',
          'air_ambulance_subtitle':
              'Critical transfer support for long-distance cases.',
          'icu_ambulance': 'ICU Ambulance',
          'icu_ambulance_subtitle':
              'Advanced care transport with monitoring support.',
          'patient_transfer': 'Patient Transfer',
          'patient_transfer_subtitle':
              'Safe movement between hospital and home or clinic.',
          'need_immediate_help': 'Need immediate help?',
          'emergency_contact_guidance':
              'Contact the BelleVie support team immediately for guidance and booking.',
          'emergency_call_instruction':
              'Call the numbers listed on the Contact Us page if this is an urgent case.',
          'contact_us': 'Contact Us',
          'popular_services': 'Popular Services',
          'view_all': 'View All',
          'specialist_doctors': 'Specialist Doctors',
          'hospitals_booking': 'Hospitals Booking',
          'telemedicine': 'Telemedicine',
          'pathology_test': 'Pathology Test',
          'pathology_test_screen': 'Pathology Test',
          'amar_lab': 'Amar Lab',
          'pathology_test_card_subtitle':
              'Pathology test collection and reports',
          'available_lab': 'Available Lab',
          'birdem': 'Birdem',
          'ibn_sina': 'Ibn Sina',
          'popular_lab': 'Popular',
          'thyrocare': 'Thyrocare',
          'continental_hospital': 'Continental Hospital',
          'islami_hospital': 'Islami Hospital',
          'medinova': 'Medinova',
          'oncosmolbiol': 'Oncosmolbiol',
          'pharmacy': 'Pharmacy',
          'video_consultancy': 'Video Consultancy',
          'ambulance_services': 'Ambulance Services',
          'community_health_care': 'Community Health Care',
          'hospital_support_services': 'Hospital Support Services',
          'health_insurance': 'Health Insurance',
          'core_four': 'Core Four',
          'other_medical_services': 'Other Medical Services',
          'more': 'More',
          'brand_name': 'BelleVie',
          'app_tagline':
              'Global Health Services\nYour Global Healthcare Companion',
          'all': 'All',
          'no_doctors_available': 'No doctors available right now.',
          'book_appointment': 'Book Appointment',
          'experience': 'Experience',
          'fees': 'Fees',
          'close': 'Close',
          'show_more': 'Show More',
          'no_categories_found': 'No categories found',
          'feature_unavailable': 'Feature Unavailable',
          'this_feature_not_available': 'This feature is not available yet.',
          'feature_continue_home':
              'You can continue using the currently available sections from Home.',
          'go_to_home': 'Go to Home',
          'payment': 'Payment',
          'payment_number': 'Payment Number',
          'booking_id': 'Booking ID',
          'not_available': 'Not available',
          'select_payment_method': 'Select payment method',
          'bkash': 'bKash',
          'nagad': 'Nagad',
          'rocket': 'Rocket',
          'amount': 'Amount',
          'enter_amount': 'Enter amount',
          'transaction_id': 'Transaction ID',
          'enter_transaction_id': 'Enter transaction id',
          'submitting': 'Submitting...',
          'submit': 'Submit',
          'booking_id_missing': 'Booking id is missing.',
          'please_enter_amount': 'Please enter amount.',
          'please_select_payment_method': 'Please select a payment method.',
          'please_enter_transaction_id': 'Please enter transaction id.',
          'payment_submitted_successfully': 'Payment submitted successfully.',
          'payment_failed_try_again': 'Payment failed. Please try again.',
          'invalid_doctor_id': 'Invalid doctor id',
          'could_not_load_details': 'Could not load details.',
          'forgot_password': 'Forgot Password',
          'forgot_password_question': 'Forgot Password?',
          'reset_password': 'Reset Password',
          'reset_your_password': 'Reset your password',
          'search_country': 'Search country',
          'new_password': 'New Password',
          'no_additional_details_available': 'No additional details available.',
          'no_contact_details_available': 'No contact details available.',
          'subscription_package': 'Subscription package',
          'bellevie_healthsaver_scheme': 'Bellevie HealthSaver Scheme',
          'freemium_package': 'Freemium Package',
          'premium_package': 'Premium Package',
          'probashi_package': 'Probashi Package',
          'benefits': 'Benefits',
          'hospital_discounts': 'Hospital Discounts',
          'discount_on_diagnostics': 'Discount on Diagnostics',
          'free_consultancy': 'Free Consultancy',
          'other_discount_services': 'Other Discount Services',
          'platinum': 'Platinum',
          'gold': 'Gold',
          'silver': 'Silver',
          'bronze': 'Bronze',
          'social_services': 'Social Services',
          'community_health_services': 'Community Health Services',
          'bellevie_health_club': 'Bellevie Health Club',
          'charity_partners': 'Charity Partners',
          'health_tourism': 'Health Tourism',
          'section_not_available_yet': 'This section is not available yet.',
          'appointment': 'Appointment',
          'call': 'Call',
          'profile': 'Profile',
          'discount_partner': 'Discount Partner',
          'banners_unavailable': 'Banners unavailable',
          'no_banners_found': 'No banners found',
          'telemedicine_video_consultancy': 'Telemedicine / Video Consultancy',
          'ent_doctor_services': 'ENT Doctor Services',
          'diagnostic_services': 'Diagnostic Services',
          'doctors_services': 'Doctors Services',
          'air_ambulance': 'Air Ambulance',
          'palliative_care_services': 'Palliative Care Services',
          'geriatric_health_services': 'Geriatric Health Services',
          'medical_accessories': 'Medical accessories',
          'diagnostic_devices': 'Diagnostic Devices',
          'home_care_furniture': 'Home Care / Furniture',
          'wound_care_personal_care': 'Wound Care & Personal Care',
          'first_aid_supplies': 'First Aid Supplies',
          'face_masks_and_gloves': 'Face Masks and Gloves',
          'mobility_aids': 'Mobility Aids',
          'respiratory_units': 'Respiratory Units',
          'bed_wedges': 'Bed Wedges',
          'foreign_treatment': 'Foreign Treatment',
          'hospitals_in_india': 'Hospitals in India',
          'hospitals_in_china': 'Hospitals in China',
          'hospitals_in_thailand': 'Hospitals in Thailand',
          'hospitals_in_turkey': 'Hospitals in Turkey',
          'hospitals_in_singapore': 'Hospitals in Singapore',
          'hospitals_in_malaysia': 'Hospitals in Malaysia',
          'india_hospitals': 'India Hospitals',
          'agreement_status': 'Agreement Status: @status',
          'public_number_of_hospitals':
              'Public Number of Hospitals: @countText',
          'status_done': 'Done',
          'status_pending': 'Pending',
          'status_wip': 'WIP',
          'status_through_doctor': 'Through Doctor',
          'status_not_publicly_aggregated': 'Not publicly aggregated',
          'specialist_doctors_screen': 'Specialist Doctors',
          'internal_medicine': 'Internal Medicine',
          'general_physician': 'General Physician',
          'neuromedicine': 'Neuromedicine',
          'gastroenterology': 'Gastroenterology',
          'urology': 'Urology',
          'oncology': 'Oncology',
          'radio_therapy': 'Radio Therapy',
          'rheumatology': 'Rheumatology',
          'family_medicine': 'Family Medicine',
          'cardiology': 'Cardiology',
          'endocrinology': 'Endocrinology',
          'gynaecology_and_obstetrics': 'Gynaecology and Obstetrics',
          'psychiatrist': 'Psychiatrist',
          'counseling_psychologist': 'Counseling Psychologist',
          'dentists': 'Dentists',
          'stem_therapy': 'Stem Therapy',
          'regenerative_therapy': 'Regenerative Therapy',
          'caregiver_services': 'Caregiver Services',
          'physiotherapist': 'Physiotherapist',
          'chiropractic_services': 'Chiropractic Services',
          'please_enter_phone_password':
              'Please enter phone number and password.',
          'please_fill_required_fields': 'Please fill all required fields.',
          'please_enter_password_confirm_password':
              'Please enter password and confirm password.',
          'passwords_do_not_match': 'Passwords do not match.',
          'registration_successful': 'Registration successful.',
          'india': 'India',
          'select_date': 'Select date',
          'select_time': 'Select time',
          'enter_patient_name': 'Enter patient name',
          'enter_phone_number': 'Enter phone number',
          'doctor_id': 'Doctor ID',
          'date': 'Date',
          'time': 'Time',
          'patient_name': 'Patient Name',
          'please_select_date': 'Please select a date.',
          'please_select_time': 'Please select a time.',
          'please_enter_patient_name': 'Please enter patient name.',
          'please_enter_phone_number': 'Please enter phone number.',
          'appointment_submitted_successfully':
              'Appointment submitted successfully.',
          'booking_failed_try_again': 'Booking failed. Please try again.',
          'doctor_id_missing': 'Doctor id is missing.',
          'browse_hospitals_packages_abroad':
              'Browse hospitals and packages abroad.',
          'find_a_specialist_and_book_quickly':
              'Find a specialist and book quickly.',
          'top_doctors': 'Top Doctors',
          'payment_method': 'Payment Method',
          'thailand': 'Thailand',
          'turkey': 'Turkey',
          'china': 'China',
          'singapore': 'Singapore',
          'malaysia': 'Malaysia',
          // Subscription package items
          'bellevie_family_care': 'BelleVie Family Care',
          'bellevie_elit_members': 'BelleVie Elit Members',
          'grow_with_bellevie': 'Grow with BelleVie',
          'bellevie_area_leaders': 'BelleVie Area Leaders',
          'bellevie_health_club_title': 'BelleVie Health Club',

          'bellevie_health_club_description':
              '''BelleVie Health Club is a Community-Based Health & Wellness Ecosystem. It is a health-focused social network that combines health protection, health education, medical assistance, and discount benefits, making it easier for people to access safe and affordable healthcare services.

Key Roles of BelleVie Health Club

1. Health Protection Platform

• Affordable Health Protection Cards
• Hospital Admission Assistance
• Telemedicine Services
• Health Consultation
• Second Opinion Services
• Local and International Medical Assistance

2. Community Health Network

• Health Ambassadors in Every Community
• Health Awareness Programs
• Free Health Camps
• Family-Based Health Registration

3. Preventive Healthcare Movement

• Regular Health Checkups
• Screening for Diabetes, Hypertension, and Heart Disease
• Nutrition and Lifestyle Counseling
• Maternal and Child Healthcare Services

4. Health Concierge Service

• Doctor Appointment Scheduling
• Hospital Booking Assistance
• Ambulance Support
• Medical Report Interpretation
• Medical Tourism Assistance''',
        },
        'bn_BD': {
          'bellevie_health_club_title': 'বেলেভি হেলথ ক্লাব',

          'bellevie_health_club_description':
              '''BelleVie Health Club একটি Community-Based Health & Wellness Ecosystem. এটি স্বাস্থ্য সুরক্ষা, স্বাস্থ্য শিক্ষা, চিকিৎসা সহায়তা, ডিসকাউন্ট সুবিধা সম্বলিত একটি স্বাস্থ্য বিষয়ক সামাজিক নেটওয়ার্ক যার মাধ্যমে অতি সহজেই নিরাপদ চিকিৎসা নিশ্চিত করা সম্ভব।

BelleVie Health Club-এর মূল ভূমিকাঃ

১. Health Protection Platform

• কম খরচে স্বাস্থ্য সুরক্ষা কার্ড
• হাসপাতাল ভর্তি সহায়তা
• টেলিমেডিসিন
• স্বাস্থ্য পরামর্শ
• দ্বিতীয় মতামত (Second Opinion)
• দেশ ও বিদেশে চিকিৎসা সহায়তা

২. Community Health Network

• প্রতিটি এলাকায় Health Ambassador
• স্বাস্থ্য সচেতনতা সভা
• ফ্রি স্বাস্থ্য ক্যাম্প
• পরিবারভিত্তিক স্বাস্থ্য নিবন্ধন

৩. Preventive Healthcare Movement

• নিয়মিত স্বাস্থ্য পরীক্ষা
• ডায়াবেটিস, উচ্চ রক্তচাপ ও হৃদরোগ স্ক্রিনিং
• পুষ্টি ও জীবনযাপন পরামর্শ
• মাতৃ ও শিশু স্বাস্থ্য সেবা

৪. Health Concierge Service

• ডাক্তার অ্যাপয়েন্টমেন্ট
• হাসপাতাল বুকিং
• অ্যাম্বুলেন্স সাপোর্ট
• মেডিকেল রিপোর্ট ব্যাখ্যা
• চিকিৎসা ভ্রমণ (Medical Tourism)''',
          'community_health_services_title': 'বেলভি কমিউনিটি হেলথ সার্ভিস',

          'community_health_services_description':
              '''একসাথে স্বাস্থ্য সুরক্ষা, নিরাপদ আগামী.....

বেলভি কমিউনিটি হেলথ সার্ভিস হলো একটি জনকেন্দ্রিক স্বাস্থ্য সুরক্ষা উদ্যোগ, যার লক্ষ্য হলো সাশ্রয়ী, সহজলভ্য এবং নির্ভরযোগ্য স্বাস্থ্য সুরক্ষা সেবা মানুষের দোরগোড়ায় পৌঁছে দেওয়া।

এই সেবার মাধ্যমে একটি এলাকার মানুষ, পরিবার, বন্ধু-বান্ধব, সামাজিক সংগঠন বা কমিউনিটি একসাথে যুক্ত হয়ে বেলভি হেলথ প্রোটেকশন কার্ড গ্রহণ করতে পারবেন এবং একটি শক্তিশালী পারস্পরিক সহায়তার নেটওয়ার্ক গড়ে তুলতে পারবেন।

এই নেটওয়ার্কে যুক্ত সদস্যদের স্বাস্থ্যগত আর্থিক ঝুঁকি থাকবে না। অর্থাৎ হঠাৎ অসুস্থ হলে চিকিৎসার ব্যয় নিয়ে ভাবতে হবে না।

কীভাবে কাজ করেঃ

কমিউনিটিভিত্তিক নিবন্ধনের মাধ্যমে সমাজের সদস্যরা সম্মিলিতভাবে বেলভি হেলথ প্রোটেকশন কার্ড গ্রহণ করবেন, যাতে স্বাস্থ্য সুরক্ষা আরও সহজ ও কার্যকর হবে।

কমিউনিটি ভলান্টিয়ার সহায়তাঃ

প্রতিটি কমিউনিটির জন্য থাকবেন প্রশিক্ষিত বেলভি কমিউনিটি ভলান্টিয়ার, যারা সদস্যদের সহায়তা করবেন—

• হেলথ কার্ড সম্পর্কে বিস্তারিত বুঝতে
• নিবন্ধন সম্পন্ন করতে
• কার্ড সংগ্রহ ও সক্রিয় করতে
• প্রয়োজনের সময় স্বাস্থ্যসেবা গ্রহণে দিকনির্দেশনা দিতে
• প্রয়োজন অনুযায়ী বেলভির সাপোর্ট টিমের সঙ্গে সংযুক্ত করতে

প্রয়োজনের সময় পাশে থাকা:

যখন কোনো কার্ডধারী চিকিৎসা সহায়তা, পরামর্শ, হাসপাতাল সংক্রান্ত সহযোগিতা বা সেবা গ্রহণে সহায়তা চাইবেন, তখন বেলভি ভলান্টিয়ার ও আমাদের সাপোর্ট টিম তার পাশে থাকবে।

কমিউনিটি ভলান্টিয়ারদের ভূমিকা

বেলভি কমিউনিটি হেলথ সার্ভিসের প্রাণশক্তি হলেন আমাদের কমিউনিটি ভলান্টিয়াররা।

তারা নিজ নিজ এলাকার মানুষের কাছে স্বাস্থ্য সুরক্ষার বার্তা পৌঁছে দেন এবং তাদের প্রয়োজনের সময় সহায়তা করেন।

তাদের এই গুরুত্বপূর্ণ অবদানের স্বীকৃতি হিসেবে, তারা বিতরণকৃত হেলথ কার্ডের নির্ধারিত ট্যারিফ থেকে কমিশন সুবিধা লাভ করেন।

এর ফলে একটি টেকসই ব্যবস্থা গড়ে ওঠে যেখানেঃ

• কমিউনিটি লাভবান হবে সাশ্রয়ী স্বাস্থ্য সুরক্ষার মাধ্যমে।
• কার্ডধারীরা লাভবান হন নির্ভরযোগ্য সহায়তা ও সহজ সেবা প্রাপ্তিতে।
• ভলান্টিয়াররা লাভবান হন তাদের সেবার ন্যায্য সম্মানী পেয়ে।

কেন যুক্ত হবেন?

• সাশ্রয়ী স্বাস্থ্য সুরক্ষা।
• নিজ কমিউনিটির বিশ্বস্ত সহায়তা।
• প্রয়োজনের সময় দ্রুত সহযোগিতা।
• সহজ নিবন্ধন ও দিকনির্দেশনা।
• সমাজসেবা করার পাশাপাশি আয়ের সুযোগ।

আমাদের অঙ্গীকার

আমরা বিশ্বাস করি, স্বাস্থ্য সুরক্ষা সবার অধিকার।

বেলভি কমিউনিটি হেলথ সার্ভিস মানুষের মাঝে পারস্পরিক সহযোগিতা, সচেতনতা ও স্বাস্থ্য নিরাপত্তার এক নতুন সংস্কৃতি গড়ে তুলতে কাজ করছে।

বেলভি কমিউনিটি হেলথ সার্ভিস

একসাথে সুরক্ষা, একসাথে সহায়তা, একসাথে সমৃদ্ধি।''',
          'yearly_premium_bdt': 'বার্ষিক প্রিমিয়াম (বিডিটি)',
          'life': 'লাইফ',
          'permanent_total_disability': 'স্থায়ী সম্পূর্ণ প্রতিবন্ধকতা',
          'permanent_partial_disability': 'স্থায়ী আংশিক প্রতিবন্ধকতা',
          'funeral_benefit': 'অন্ত্যেষ্টিক্রিয়া সুবিধা',
          'dead_body_repatriation': 'মৃতদেহ দেশে ফেরত',
          'loss_of_income': 'আয়ের ক্ষতি (সর্বোচ্চ ছয় মাস)',
          'hospitalization': 'হাসপাতালে ভর্তি',
          'telemedicine_24_7': 'টেলিমেডিসিন',
          'probashi_value_funeral': 'সর্বোচ্চ ২০,০০০',
          'probashi_value_hospitalization':
              '৫০,০০০ (দৈনিক ৫,০০০ টাকা, একটানা সর্বোচ্চ ৫ দিন)',
          'probashi_value_telemedicine':
              '২৪/৭ আনলিমিটেড অডিও ও ভিডিও ডাক্তার পরামর্শ (পরিবারের সর্বোচ্চ ছয়জন সদস্য)',

          // (আপনার আগের _bn কীগুলো রাখতে পারেন, কিন্তু মূল কীগুলোই যথেষ্ট)
          'yearly_premium_bdt_bn': 'বার্ষিক প্রিমিয়াম (বিডিটি)',
          'life_bn': 'লাইফ',
          'permanent_total_disability_bn': 'স্থায়ী সম্পূর্ণ প্রতিবন্ধকতা',
          // Premium Plans
          'shohay': 'সহায়',
          'nirbhor': 'নির্ভর',
          'shoshti': 'শস্তি',
          'aastha': 'আস্থা',
          'prottoy': 'প্রত্যয়',

          'shohay_bn': 'সহায়',
          'nirbhor_bn': 'নির্ভর',
          'shoshti_bn': 'শস্তি',
          'aastha_bn': 'আস্থা',
          'prottoy_bn': 'প্রত্যয়',

          'yearly_premium': 'বার্ষিক প্রিমিয়াম',
          'life_coverage': 'লাইফ কভারেজ',
          'accidental_death_benefit': 'দুর্ঘটনাজনিত মৃত্যু সুবিধা',
          'permanent_disability': 'স্থায়ী আংশিক ও সম্পূর্ণ প্রতিবন্ধকতা',
          'critical_illness': 'ক্রিটিক্যাল ইলনেস',
          'hospicash': 'হসপিক্যাশ',
          'opd': 'ওপিডি',
          'telemedicine': 'টেলিমেডিসিন',
          'discount_facilities': 'ডিসকাউন্ট সুবিধা',

          // Probashi
          'bellevie_guardian_nrb': 'বেলেভি গার্ডিয়ান এনআরবি হেলথ সাপোর্ট',
          'bellevie_guardian': 'বেলেভি গার্ডিয়ান হেলথ প্রোগ্রাম',
          'app_title': 'BelleVie Global Health Services',
          'login': 'লগইন',
          'sign_in': 'সাইন ইন',
          'dont_have_account': 'অ্যাকাউন্ট নেই?',
          'registration': 'রেজিস্ট্রেশন',
          'country_code': 'Country code',
          'phone_number': 'ফোন নম্বর',
          'password': 'পাসওয়ার্ড',
          'name': 'নাম',
          'email_optional': 'ইমেইল (ঐচ্ছিক)',
          'district': 'জেলা',
          'confirm_password': 'পাসওয়ার্ড নিশ্চিত করুন',
          'register': 'রেজিস্টার',
          'already_have_account': 'ইতিমধ্যে অ্যাকাউন্ট আছে?',
          'home': 'হোম',
          'my_appointments': 'আমার অ্যাপয়েন্টমেন্ট',
          'my_health': 'আমার স্বাস্থ্য',
          'cart': 'কার্ট',
          'records': 'রেকর্ড',
          'menu': 'মেনু',
          'english': 'ইংরেজি',
          'bangla': 'বাংলা',
          'emergency_services': 'জরুরি সেবা',
          'emergency_services_screen': 'জরুরি সেবা',
          'emergency_fast_response': 'দ্রুত সাড়া, ২৪/৭',
          'emergency_subtitle':
              'প্রতি মিনিট গুরুত্বপূর্ণ হলে সঠিক জরুরি পরিবহন সেবা বেছে নিন।',
          'available_services': 'উপলব্ধ সেবা',
          'ambulance': 'অ্যাম্বুলেন্স',
          'ambulance_subtitle': 'দ্রুত প্রেরণসহ প্রাথমিক জরুরি পরিবহন।',
          'air_ambulance_subtitle':
              'দূরপাল্লার ক্ষেত্রে জরুরি স্থানান্তরের সহায়তা।',
          'icu_ambulance': 'আইসিইউ অ্যাম্বুলেন্স',
          'icu_ambulance_subtitle': 'মনিটরিং সহ উন্নত চিকিৎসা পরিবহন।',
          'patient_transfer': 'রোগী স্থানান্তর',
          'patient_transfer_subtitle':
              'হাসপাতাল, বাড়ি বা ক্লিনিকের মধ্যে নিরাপদ স্থানান্তর।',
          'need_immediate_help': 'তাৎক্ষণিক সাহায্য দরকার?',
          'emergency_contact_guidance':
              'নির্দেশনা ও বুকিংয়ের জন্য সঙ্গে সঙ্গে BelleVie সাপোর্ট টিমের সাথে যোগাযোগ করুন।',
          'emergency_call_instruction':
              'এটি জরুরি হলে Contact Us পেজে দেওয়া নম্বরে কল করুন।',
          'contact_us': 'যোগাযোগ করুন',
          'popular_services': 'জনপ্রিয় সেবা',
          'view_all': 'সব দেখুন',
          'specialist_doctors': 'বিশেষজ্ঞ ডাক্তার',
          'hospitals_booking': 'হাসপাতাল বুকিং',
          'telemedicine': 'টেলিমেডিসিন',
          'pathology_test': 'প্যাথলজি টেস্ট',
          'pathology_test_screen': 'প্যাথলজি টেস্ট',
          'amar_lab': 'আমার ল্যাব',
          'pathology_test_card_subtitle':
              'Pathology test collection and reports',
          'available_lab': 'সহজলভ্য',
          'birdem': 'বারডেম',
          'ibn_sina': 'ইবনে সিনা',
          'popular_lab': 'পপুলার',
          'thyrocare': 'থাইরোকেয়ার',
          'continental_hospital': 'কন্টিনেন্টাল হাসপাতাল',
          'islami_hospital': 'ইসলামী হাসপাতাল',
          'medinova': 'মেডিনোভা',
          'oncosmolbiol': 'অনকোসমলবায়োল',
          'pharmacy': 'ফার্মেসি',
          'video_consultancy': 'ভিডিও কনসালটেন্সি',
          'ambulance_services': 'অ্যাম্বুলেন্স সেবা',
          'community_health_care': 'কমিউনিটি হেলথ কেয়ার',
          'hospital_support_services': 'হাসপাতাল সাপোর্ট সেবা',
          'health_insurance': 'স্বাস্থ্য বীমা',
          'core_four': 'কোর ফোর',
          'other_medical_services': 'অন্যান্য চিকিৎসা সেবা',
          'more': 'আরও',
          'brand_name': 'বেলে ভাই',
          'app_tagline':
              'গ্লোবাল হেলথ সার্ভিসেস\nআপনার গ্লোবাল হেলথকেয়ার সঙ্গী',
          'all': 'সব',
          'no_doctors_available': 'এখন কোন ডাক্তার উপলব্ধ নেই।',
          'book_appointment': 'অ্যাপয়েন্টমেন্ট বুক করুন',
          'experience': 'অভিজ্ঞতা',
          'fees': 'ফি',
          'close': 'বন্ধ',
          'show_more': 'আরও দেখুন',
          'no_categories_found': 'কোন ক্যাটাগরি পাওয়া যায়নি',
          'feature_unavailable': 'ফিচার উপলব্ধ নয়',
          'this_feature_not_available': 'এই ফিচারটি এখনো উপলব্ধ নেই।',
          'feature_continue_home':
              'হোম থেকে বর্তমানে উপলব্ধ অংশগুলো ব্যবহার চালিয়ে যেতে পারেন।',
          'go_to_home': 'হোমে যান',
          'payment': 'পেমেন্ট',
          'payment_number': 'পেমেন্ট নম্বর',
          'booking_id': 'বুকিং আইডি',
          'not_available': 'উপলব্ধ নেই',
          'select_payment_method': 'পেমেন্ট পদ্ধতি নির্বাচন করুন',
          'bkash': 'বিকাশ',
          'nagad': 'নগদ',
          'rocket': 'রকেট',
          'amount': 'পরিমাণ',
          'enter_amount': 'পরিমাণ লিখুন',
          'transaction_id': 'লেনদেন আইডি',
          'enter_transaction_id': 'লেনদেন আইডি লিখুন',
          'submitting': 'জমা দেওয়া হচ্ছে...',
          'submit': 'জমা করুন',
          'booking_id_missing': 'বুকিং আইডি মিসিং আছে।',
          'please_enter_amount': 'পরিমাণ লিখুন।',
          'please_select_payment_method':
              'অনুগ্রহ করে একটি পেমেন্ট পদ্ধতি নির্বাচন করুন।',
          'please_enter_transaction_id': 'লেনদেন আইডি লিখুন।',
          'payment_submitted_successfully': 'পেমেন্ট সফল হয়েছে।',
          'payment_failed_try_again':
              'পেমেন্ট ব্যর্থ হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।',
          'invalid_doctor_id': 'অবৈধ ডাক্তার আইডি',
          'could_not_load_details': 'বিস্তারিত লোড করা সম্ভব হয়নি।',
          'forgot_password': 'পাসওয়ার্ড ভুলে গেছেন',
          'forgot_password_question': 'পাসওয়ার্ড ভুলে গেছেন?',
          'reset_password': 'পাসওয়ার্ড রিসেট করুন',
          'reset_your_password': 'আপনার পাসওয়ার্ড রিসেট করুন',
          'search_country': 'কountry অনুসন্ধান',
          'new_password': 'নতুন পাসওয়ার্ড',
          'no_additional_details_available': 'অতিরিক্ত ডিটেইল পাওয়া যায়নি।',
          'no_contact_details_available':
              'কোনো কন্ট্যাক্ট ডিটেইল পাওয়া যায়নি।',
          'subscription_package': 'সাবস্ক্রিপশন প্যাকেজ',
          'bellevie_healthsaver_scheme': 'বেলেভি হেলথসেভার স্কিম',
          'freemium_package': 'ফ্রিমিয়াম প্যাকেজ',
          'premium_package': 'প্রিমিয়াম প্যাকেজ',
          'probashi_package': 'প্রবাসী প্যাকেজ',
          'benefits': 'সুবিধাসমূহ',
          'hospital_discounts': 'হাসপাতালে ছাড়',
          'discount_on_diagnostics': 'ডায়াগনস্টিকে ছাড়',
          'free_consultancy': 'বিনামূল্যে পরামর্শ',
          'other_discount_services': 'অন্যান্য ছাড় সেবা',
          'platinum': 'প্লাটিনাম',
          'gold': 'গোল্ড',
          'silver': 'সিলভার',
          'bronze': 'ব্রোঞ্জ',
          'social_services': 'সামাজিক সেবা',
          'community_health_services': 'কমিউনিটি হেলথ সার্ভিসেস',
          'bellevie_health_club': 'বেলেভি হেলথ ক্লাব',
          'charity_partners': 'দাতব্য অংশীদার',
          'health_tourism': 'হেলথ ট্যুরিজম',
          'section_not_available_yet': 'এই অংশটি এখনও উপলব্ধ নেই।',
          'appointment': 'অ্যাপয়েন্টমেন্ট',
          'call': 'কল',
          'profile': 'প্রোফাইল',
          'discount_partner': 'ডিসকাউন্ট পার্টনার',
          'banners_unavailable': 'ব্যানারগুলো পাওয়া যায়নি',
          'no_banners_found': 'কোনো ব্যানার পাওয়া যায়নি',
          'telemedicine_video_consultancy': 'টেলিমেডিসিন / ভিডিও কনসালটেন্সি',
          'ent_doctor_services': 'ইএনটি ডাক্তার সেবা',
          'diagnostic_services': 'ডায়াগনস্টিক সেবা',
          'doctors_services': 'ডাক্তার সেবা',
          'air_ambulance': 'এয়ার অ্যাম্বুলেন্স',
          'palliative_care_services': 'প্যালিয়েটিভ কেয়ার সেবা',
          'geriatric_health_services': 'বয়স্ক স্বাস্থ্য সেবা',
          'medical_accessories': 'মেডিকেল অ্যাক্সেসরিজ',
          'diagnostic_devices': 'ডায়াগনস্টিক ডিভাইস',
          'home_care_furniture': 'হোম কেয়ার / ফার্নিচার',
          'wound_care_personal_care': 'ওয়াউন্ড কেয়ার ও পার্সোনাল কেয়ার',
          'first_aid_supplies': 'ফার্স্ট এইড সরঞ্জাম',
          'face_masks_and_gloves': 'ফেস মাস্ক ও গ্লাভস',
          'mobility_aids': 'মোবিলিটি এইডস',
          'respiratory_units': 'রেসপিরেটরি ইউনিট',
          'bed_wedges': 'বেড ওয়েজ',
          'foreign_treatment': 'বিদেশি চিকিৎসা',
          'hospitals_in_india': 'ভারতের হাসপাতাল',
          'hospitals_in_china': 'চীনের হাসপাতাল',
          'hospitals_in_thailand': 'থাইল্যান্ডের হাসপাতাল',
          'hospitals_in_turkey': 'তুরস্কের হাসপাতাল',
          'hospitals_in_singapore': 'সিঙ্গাপুরের হাসপাতাল',
          'hospitals_in_malaysia': 'মালয়েশিয়ার হাসপাতাল',
          'india_hospitals': 'ভারতের হাসপাতাল',
          'agreement_status': 'চুক্তির অবস্থা: @status',
          'public_number_of_hospitals':
              'হাসপাতালের প্রকাশিত সংখ্যা: @countText',
          'status_done': 'সম্পন্ন',
          'status_pending': 'অপেক্ষমাণ',
          'status_wip': 'চলমান',
          'status_through_doctor': 'ডাক্তারের মাধ্যমে',
          'status_not_publicly_aggregated': 'সর্বজনীনভাবে একত্রিত নয়',
          'specialist_doctors_screen': 'বিশেষজ্ঞ ডাক্তার',
          'internal_medicine': 'ইন্টারনাল মেডিসিন',
          'general_physician': 'সাধারণ চিকিৎসক',
          'neuromedicine': 'নিউরোমেডিসিন',
          'gastroenterology': 'গ্যাস্ট্রোএন্টারোলজি',
          'urology': 'ইউরোলজি',
          'oncology': 'অনকোলজি',
          'radio_therapy': 'Radio Therapy',
          'rheumatology': 'রিউমাটোলজি',
          'family_medicine': 'ফ্যামিলি মেডিসিন',
          'cardiology': 'কার্ডিওলজি',
          'endocrinology': 'এন্ডোক্রিনোলজি',
          'gynaecology_and_obstetrics': 'গাইনোকোলজি ও অবস্টেট্রিক্স',
          'psychiatrist': 'সাইকিয়াট্রিস্ট',
          'counseling_psychologist': 'কাউন্সেলিং সাইকোলজিস্ট',
          'dentists': 'ডেন্টিস্ট',
          'stem_therapy': 'স্টেম থেরাপি',
          'regenerative_therapy': 'রিজেনারেটিভ থেরাপি',
          'caregiver_services': 'কেয়ারগিভার সেবা',
          'physiotherapist': 'ফিজিওথেরাপিস্ট',
          'chiropractic_services': 'কাইরোপ্র্যাকটিক সেবা',
          'please_enter_phone_password': 'ফোন নম্বর ও পাসওয়ার্ড দিন।',
          'please_fill_required_fields':
              'দয়া করে সব প্রয়োজনীয় ঘর পূরণ করুন।',
          'please_enter_password_confirm_password':
              'পাসওয়ার্ড ও নিশ্চিত পাসওয়ার্ড দিন।',
          'passwords_do_not_match': 'পাসওয়ার্ড মেলেনি।',
          'registration_successful': 'রেজিস্ট্রেশন সফল হয়েছে।',
          'india': 'ভারত',
          'select_date': 'তারিখ নির্বাচন করুন',
          'select_time': 'সময় নির্বাচন করুন',
          'enter_patient_name': 'রোগীর নাম লিখুন',
          'enter_phone_number': 'ফোন নম্বর লিখুন',
          'doctor_id': 'ডাক্তার আইডি',
          'date': 'তারিখ',
          'time': 'সময়',
          'patient_name': 'রোগীর নাম',
          'please_select_date': 'দয়া করে একটি তারিখ নির্বাচন করুন।',
          'please_select_time': 'দয়া করে একটি সময় নির্বাচন করুন।',
          'please_enter_patient_name': 'রোগীর নাম লিখুন।',
          'please_enter_phone_number': 'ফোন নম্বর লিখুন।',
          'appointment_submitted_successfully':
              'অ্যাপয়েন্টমেন্ট সফলভাবে সাবমিট হয়েছে।',
          'booking_failed_try_again':
              'বুকিং ব্যর্থ হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।',
          'doctor_id_missing': 'ডাক্তার আইডি মিসিং আছে।',
          'browse_hospitals_packages_abroad':
              'বিদেশে হাসপাতাল এবং প্যাকেজ ব্রাউজ করুন।',
          'find_a_specialist_and_book_quickly':
              'একজন বিশেষজ্ঞ খুঁজুন এবং দ্রুত বুক করুন।',
          'top_doctors': 'শীর্ষ ডাক্তার',
          'payment_method': 'পেমেন্ট পদ্ধতি',
          'thailand': 'থাইল্যান্ড',
          'turkey': 'তুরস্ক',
          'china': 'চীন',
          'singapore': 'সিঙ্গাপুর',
          'malaysia': 'মালয়েশিয়া',
          // Subscription package items
          'bellevie_family_care': 'বেলেভি ফ্যামিলি কেয়ার',
          'bellevie_elit_members': 'বেলেভি এলিট মেম্বার্স',
          'grow_with_bellevie': 'বেলেভি-র সাথে বৃদ্ধি',
          'bellevie_area_leaders': 'বেলেভি এরিয়া লিডারস',

          'bellevie_compassion_fund_title': 'বেলভি কমপ্যাশন ফান্ড',

          'bellevie_compassion_fund_description':
              '''একসাথে স্বাস্থ্য, একসাথে মানবতা…

প্রতিদিন অসংখ্য পরিবার গুরুতর রোগের কঠিন বাস্তবতার মুখোমুখি হয়, অথচ সময়মতো চিকিৎসা নেওয়ার মতো আর্থিক সামর্থ্য তাদের থাকে না।

অনেকের জন্য একটি গুরুতর অসুস্থতা শুধু স্বাস্থ্যের জন্য হুমকি নয়—এটি তাদের মর্যাদা, স্থিতিশীলতা এবং আশাকেও হুমকির মুখে ফেলে।

এই জরুরি সামাজিক প্রয়োজন মোকাবিলায়, বেলভি প্রতিষ্ঠা করছে বেলভি কমপ্যাশন ফান্ড, যা একটি নিবেদিত দাতব্য উদ্যোগ। এর লক্ষ্য হলো গুরুতর অসুস্থতায় আক্রান্ত অসচ্ছল মানুষের জন্য আর্থিক সহায়তা ও চিকিৎসা সহায়তা প্রদান করা।

এই ফান্ডের উদ্দেশ্য হলো চিকিৎসার প্রয়োজন এবং আর্থিক সামর্থ্যের মধ্যে যে ব্যবধান রয়েছে তা দূর করা। ব্যক্তি, ব্যবসা প্রতিষ্ঠান এবং সংগঠনের সম্মিলিত উদারতা কাজে লাগিয়ে আমরা এমন একটি সমাজ গড়ে তুলতে চাই, যেখানে স্বাস্থ্যসেবা পাওয়ার অধিকার অর্থনৈতিক অবস্থার উপর নির্ভর করবে না।

এই ফান্ড কেন গুরুত্বপূর্ণ?

ক্যান্সার, হৃদরোগ, স্ট্রোক, কিডনি ফেইলিওরসহ বিভিন্ন জীবন-ঝুঁকিপূর্ণ রোগ পরিবারগুলোর উপর অসহনীয় চাপ সৃষ্টি করে।

অনেক রোগী শুধুমাত্র চিকিৎসার খরচ বহন করতে না পারার কারণে চিকিৎসা নিতে দেরি করেন অথবা মাঝপথে বন্ধ করে দেন।

বেলভি কমপ্যাশন ফান্ডের মাধ্যমে আমাদের লক্ষ্য:

• আর্থিকভাবে অসচ্ছল রোগীদের প্রয়োজনীয় চিকিৎসা পেতে সহায়তা করা
• স্বাস্থ্য সংকটে থাকা পরিবারগুলোর মাঝে আশা ও মর্যাদা ফিরিয়ে আনা
• সামাজিক দায়িত্ববোধ ও পারস্পরিক সহযোগিতার সংস্কৃতি গড়ে তোলা
• এমন একটি টেকসই প্ল্যাটফর্ম তৈরি করা, যেখানে প্রতিটি অবদান অর্থবহ পরিবর্তন আনতে পারে

দাতাদের বিভাগসমূহ

কর্পোরেট পার্টনার

কর্পোরেট প্রতিষ্ঠান, ব্যবসা ও বিভিন্ন সংগঠনকে বেলভি কমপ্যাশন ফান্ডের কর্পোরেট পার্টনার হিসেবে যুক্ত হওয়ার আমন্ত্রণ জানানো হচ্ছে। আর্থিক অনুদান, স্পন্সরশিপ এবং CSR কার্যক্রমের মাধ্যমে তারা সমাজের সুবিধাবঞ্চিত মানুষের জন্য স্বাস্থ্যসেবা সহজলভ্য করতে গুরুত্বপূর্ণ ভূমিকা রাখতে পারে এবং একই সাথে তাদের সামাজিক দায়বদ্ধতা প্রদর্শন করতে পারে।

ব্যক্তিগত দাতা

যারা পরিবর্তন আনতে চান, তারা নিজেদের সামর্থ্য অনুযায়ী এই ফান্ডে অনুদান দিতে পারেন। প্রতিটি অনুদান—ছোট বা বড়—কাউকে নতুন করে বাঁচার আশা দেয়। এই উদ্যোগে অংশগ্রহণের মাধ্যমে ব্যক্তিরা একটি সহানুভূতিশীল সমাজের অংশ হয়ে ওঠেন, যারা কঠিন সময়ে মানুষের পাশে দাঁড়াতে প্রতিশ্রুতিবদ্ধ।

এই মহৎ উদ্যোগে যুক্ত হোন

স্বাস্থ্যসেবা শুধুমাত্র একটি সেবা নয়—এটি আমাদের সবার সম্মিলিত মানবিক দায়িত্ব।

বেলভি কমপ্যাশন ফান্ডে অবদান রেখে আপনি এমন একটি আন্দোলনের অংশ হয়ে উঠবেন, যা সহানুভূতিকে বাস্তব কর্মে রূপান্তর করে এবং উদারতাকে আরোগ্যে পরিণত করে।

একসাথে আমরা নিশ্চিত করতে পারি, আর্থিক সংকটের কারণে যেন কোনো মানুষ জীবন রক্ষার সুযোগ থেকে বঞ্চিত না হয়।

কর্পোরেট পার্টনার বা ব্যক্তিগত দাতা হিসেবে আজই আমাদের সাথে যুক্ত হোন এবং একটি সুস্থ, সহানুভূতিশীল সমাজ গড়ে তুলতে সহায়তা করুন।''',
          'my_account': 'আমার অ্যাকাউন্ট',
        },
      };
}
