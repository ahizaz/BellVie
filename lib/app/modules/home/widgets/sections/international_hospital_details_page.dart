import 'dart:convert';

import 'package:bellevie/app/modules/home/controllers/bangladehi_hospital_controller.dart';
import 'package:bellevie/app/modules/home/controllers/home_controller.dart';
import 'package:bellevie/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class InternationalHospitalDetails {
  final int id;
  final int guardianHospitalId;
  final int countryId;
  final String countryName;
  final String hospitalNameEn;
  final String hospitalNameBn;
  final String addressEn;
  final String addressBn;
  final String discountEn;
  final String discountBn;
  final String contactPersonEn;
  final String contactPersonBn;
  final String contactDetailsEn;
  final String contactDetailsBn;
  final String cashlessFacilityEn;
  final String cashlessFacilityBn;

  const InternationalHospitalDetails({
    required this.id,
    required this.guardianHospitalId,
    required this.countryId,
    required this.countryName,
    required this.hospitalNameEn,
    required this.hospitalNameBn,
    required this.addressEn,
    required this.addressBn,
    required this.discountEn,
    required this.discountBn,
    required this.contactPersonEn,
    required this.contactPersonBn,
    required this.contactDetailsEn,
    required this.contactDetailsBn,
    required this.cashlessFacilityEn,
    required this.cashlessFacilityBn,
  });

  factory InternationalHospitalDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    final Map<String, dynamic> country =
        json['country'] is Map
            ? Map<String, dynamic>.from(
                json['country'] as Map,
              )
            : <String, dynamic>{};

    return InternationalHospitalDetails(
      id: _parseInt(json['id']),
      guardianHospitalId: _parseInt(
        json['guardian_hospital_id'],
      ),
      countryId: _parseInt(
        country['id'],
      ),
      countryName: _firstText([
        country['name'],
        country['name_en'],
        country['name_bn'],
      ]),
      hospitalNameEn: _firstText([
        json['hospital_name_en'],
        json['hospital_name'],
      ]),
      hospitalNameBn: _firstText([
        json['hospital_name_bn'],
        json['hospital_name_en'],
        json['hospital_name'],
      ]),
      addressEn: _firstText([
        json['address_en'],
        json['address'],
      ]),
      addressBn: _firstText([
        json['address_bn'],
        json['address_en'],
        json['address'],
      ]),
      discountEn: _firstText([
        json['discount_en'],
        json['discount'],
      ]),
      discountBn: _firstText([
        json['discount_bn'],
        json['discount_en'],
        json['discount'],
      ]),
      contactPersonEn: _firstText([
        json['contact_person_en'],
        json['contact_person'],
      ]),
      contactPersonBn: _firstText([
        json['contact_person_bn'],
        json['contact_person_en'],
        json['contact_person'],
      ]),
      contactDetailsEn: _firstText([
        json['contact_details_en'],
        json['contact_details'],
      ]),
      contactDetailsBn: _firstText([
        json['contact_details_bn'],
        json['contact_details_en'],
        json['contact_details'],
      ]),
      cashlessFacilityEn: _firstText([
        json['cashless_facility_en'],
        json['cashless_facility'],
      ]),
      cashlessFacilityBn: _firstText([
        json['cashless_facility_bn'],
        json['cashless_facility_en'],
        json['cashless_facility'],
      ]),
    );
  }

  factory InternationalHospitalDetails.fromHospitalItem(
    HospitalItem hospital,
  ) {
    return InternationalHospitalDetails(
      id: hospital.id,
      guardianHospitalId: 0,
      countryId: 0,
      countryName: hospital.country,
      hospitalNameEn: hospital.nameEn,
      hospitalNameBn: hospital.nameBn,
      addressEn: hospital.addressEn,
      addressBn: hospital.addressBn,
      discountEn: '',
      discountBn: '',
      contactPersonEn: '',
      contactPersonBn: '',
      contactDetailsEn: '',
      contactDetailsBn: '',
      cashlessFacilityEn: '',
      cashlessFacilityBn: '',
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static String _firstText(
    List<dynamic> values,
  ) {
    for (final value in values) {
      final String text =
          value?.toString().trim() ?? '';

      if (text.isNotEmpty) {
        return text;
      }
    }

    return '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guardian_hospital_id': guardianHospitalId,
      'country': {
        'id': countryId,
        'name': countryName,
      },
      'hospital_name_en': hospitalNameEn,
      'hospital_name_bn': hospitalNameBn,
      'address_en': addressEn,
      'address_bn': addressBn,
      'discount_en': discountEn,
      'discount_bn': discountBn,
      'contact_person_en': contactPersonEn,
      'contact_person_bn': contactPersonBn,
      'contact_details_en': contactDetailsEn,
      'contact_details_bn': contactDetailsBn,
      'cashless_facility_en': cashlessFacilityEn,
      'cashless_facility_bn': cashlessFacilityBn,
    };
  }
}

class InternationalHospitalDetailsController
    extends GetxController {
  final HospitalItem initialHospital;

  InternationalHospitalDetailsController({
    required this.initialHospital,
  });

  static final Map<int, InternationalHospitalDetails>
      _memoryCache = {};

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final hospitalDetails =
      Rxn<InternationalHospitalDetails>();

  int get hospitalId => initialHospital.id;

  String get _cacheKey {
    return 'international_guardian_hospital_'
        'details_v1_$hospitalId';
  }

  bool get isBangla {
    return Get.find<HomeController>()
            .currentLocale
            .value
            .languageCode ==
        'bn';
  }

  @override
  void onInit() {
    super.onInit();
    loadHospitalDetails();
  }

  Future<void> loadHospitalDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _loadDetailsCache();

      // Cache না থাকলেও list card থেকে পাওয়া
      // name, country এবং address দেখাবে।
      hospitalDetails.value ??=
          InternationalHospitalDetails
              .fromHospitalItem(
        initialHospital,
      );

      isLoading.value = false;

      // Cached/initial data দেখিয়ে background-এ
      // latest API response নিয়ে আসবে।
      await fetchHospitalDetails(
        backgroundRefresh: true,
      );
    } catch (error) {
      isLoading.value = false;

      hospitalDetails.value ??=
          InternationalHospitalDetails
              .fromHospitalItem(
        initialHospital,
      );

      debugPrint(
        'International hospital details loading error: '
        '$error',
      );
    }
  }

  Future<void> fetchHospitalDetails({
    bool backgroundRefresh = false,
  }) async {
    try {
      if (!backgroundRefresh) {
        isLoading.value = true;
      }

      errorMessage.value = '';

      final url = Uri.parse(
        '${AppApiService.baseUrl}'
        '/api/v1/foreign-treatments/'
        'international-guardian-hospitals/'
        '$hospitalId/',
      );

      debugPrint(
        'International details URL: $url',
      );

      final response = await http.get(url);

      debugPrint(
        'International details status: '
        '${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(
          response.body,
        );

        if (body is Map) {
          final details =
              InternationalHospitalDetails.fromJson(
            Map<String, dynamic>.from(body),
          );

          hospitalDetails.value = details;

          _memoryCache[hospitalId] = details;

          await _saveDetailsCache(
            details,
          );
        }
      } else {
        if (hospitalDetails.value == null) {
          errorMessage.value =
              'Unable to load hospital details.';
        }

        debugPrint(
          'International details API error: '
          '${response.statusCode}',
        );

        debugPrint(
          'International details response: '
          '${response.body}',
        );
      }
    } catch (error) {
      // Internet না থাকলেও cached data
      // remove বা clear হবে না।
      if (hospitalDetails.value == null) {
        errorMessage.value =
            'Please check your internet connection.';
      }

      debugPrint(
        'International details fetching error: $error',
      );
    } finally {
      if (!backgroundRefresh) {
        isLoading.value = false;
      }
    }
  }

  Future<void> _saveDetailsCache(
    InternationalHospitalDetails details,
  ) async {
    try {
      final SharedPreferences prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
        _cacheKey,
        jsonEncode(
          details.toJson(),
        ),
      );
    } catch (error) {
      debugPrint(
        'International details cache saving error: '
        '$error',
      );
    }
  }

  Future<void> _loadDetailsCache() async {
    try {
      final InternationalHospitalDetails?
          memoryDetails =
          _memoryCache[hospitalId];

      if (memoryDetails != null) {
        hospitalDetails.value =
            memoryDetails;
        return;
      }

      final SharedPreferences prefs =
          await SharedPreferences.getInstance();

      final String? cached =
          prefs.getString(_cacheKey);

      if (cached == null || cached.isEmpty) {
        return;
      }

      final dynamic body =
          jsonDecode(cached);

      if (body is! Map) {
        return;
      }

      final details =
          InternationalHospitalDetails.fromJson(
        Map<String, dynamic>.from(body),
      );

      hospitalDetails.value = details;

      _memoryCache[hospitalId] = details;
    } catch (error) {
      debugPrint(
        'International details cache loading error: '
        '$error',
      );
    }
  }
}

class InternationalHospitalDetailsPage
    extends StatelessWidget {
  final HospitalItem hospital;

  const InternationalHospitalDetailsPage({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    final String controllerTag =
        'international-hospital-${hospital.id}';

    final InternationalHospitalDetailsController
        controller = Get.put(
      InternationalHospitalDetailsController(
        initialHospital: hospital,
      ),
      tag: controllerTag,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0E2E3),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: Obx(
          () => Text(
            controller.isBangla
                ? 'আন্তর্জাতিক হাসপাতালের বিস্তারিত'
                : 'International Hospital Details',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Obx(() {
        final details =
            controller.hospitalDetails.value;

        if (controller.isLoading.value &&
            details == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (details == null) {
          return _errorView(
            controller,
          );
        }

        final bool isBangla =
            controller.isBangla;

        final String hospitalName =
            _localizedText(
          isBangla: isBangla,
          english: details.hospitalNameEn,
          bangla: details.hospitalNameBn,
        );

        final String address =
            _localizedText(
          isBangla: isBangla,
          english: details.addressEn,
          bangla: details.addressBn,
        );

        final String discount =
            _localizedText(
          isBangla: isBangla,
          english: details.discountEn,
          bangla: details.discountBn,
        );

        final String contactPerson =
            _localizedText(
          isBangla: isBangla,
          english: details.contactPersonEn,
          bangla: details.contactPersonBn,
        );

        final String contactNumber =
            _localizedText(
          isBangla: isBangla,
          english: details.contactDetailsEn,
          bangla: details.contactDetailsBn,
        );

        final String cashlessFacility =
            _localizedText(
          isBangla: isBangla,
          english: details.cashlessFacilityEn,
          bangla: details.cashlessFacilityBn,
        );

        return RefreshIndicator(
          onRefresh: () {
            return controller
                .fetchHospitalDetails();
          },
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              16,
              18,
              16,
              24,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                _hospitalHeader(
                  hospitalName: hospitalName,
                  country: details.countryName,
                ),
                const SizedBox(height: 18),
                if (address.isNotEmpty)
                  _informationCard(
                    icon:
                        Icons.location_on_rounded,
                    title: isBangla
                        ? 'ঠিকানা'
                        : 'Address',
                    value: address,
                  ),
                if (discount.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _informationCard(
                    icon:
                        Icons.local_offer_rounded,
                    title: isBangla
                        ? 'ছাড়ের বিবরণ'
                        : 'Discount',
                    value: discount,
                  ),
                ],
                if (contactPerson.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _informationCard(
                    icon: Icons.person_rounded,
                    title: isBangla
                        ? 'যোগাযোগের ব্যক্তি'
                        : 'Contact Person',
                    value: contactPerson,
                  ),
                ],
                if (contactNumber.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _informationCard(
                    icon: Icons.phone_rounded,
                    title: isBangla
                        ? 'যোগাযোগ নম্বর'
                        : 'Contact Number',
                    value: contactNumber,
                  ),
                ],
                if (cashlessFacility.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _informationCard(
                    icon: Icons
                        .account_balance_wallet_rounded,
                    title: isBangla
                        ? 'ক্যাশলেস সুবিধা'
                        : 'Cashless Facility',
                    value: cashlessFacility,
                  ),
                ],
                if (contactNumber.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _callNumber(
                          contactNumber,
                        );
                      },
                      icon: const Icon(
                        Icons.phone_rounded,
                        color: Colors.white,
                      ),
                      label: Text(
                        isBangla
                            ? 'কল করুন'
                            : 'Call Now',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFF4FA8A9,
                        ),
                        foregroundColor:
                            Colors.white,
                        elevation: 2,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _hospitalHeader({
    required String hospitalName,
    required String country,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFBEE9FF),
            Color(0xFFDFF8EF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            offset: Offset(3, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8FB),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withValues(
                    alpha: 0.08,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.local_hospital,
              color: Colors.redAccent,
              size: 38,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  hospitalName,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight:
                        FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                if (country.trim().isNotEmpty) ...[
                  const SizedBox(height: 7),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Colors.white.withValues(
                        alpha: 0.75,
                      ),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.public_rounded,
                          size: 15,
                          color:
                              Color(0xFF4FA8A9),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            country,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style:
                                const TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w500,
                              color:
                                  Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5EEEE),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F4F4),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4FA8A9),
              size: 23,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w500,
                    height: 1.45,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorView(
    InternationalHospitalDetailsController
        controller,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 60,
              color: Color(0xFF4FA8A9),
            ),
            const SizedBox(height: 14),
            Text(
              controller
                      .errorMessage.value.isEmpty
                  ? 'Unable to load hospital details.'
                  : controller
                      .errorMessage.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller
                    .fetchHospitalDetails();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF4FA8A9),
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  static String _localizedText({
    required bool isBangla,
    required String english,
    required String bangla,
  }) {
    if (isBangla &&
        bangla.trim().isNotEmpty) {
      return bangla.trim();
    }

    return english.trim();
  }

  static Future<void> _callNumber(
    String number,
  ) async {
    final String cleanNumber =
        number.replaceAll(' ', '').trim();

    if (cleanNumber.isEmpty) {
      return;
    }

    final Uri uri = Uri(
      scheme: 'tel',
      path: cleanNumber,
    );

    try {
      final bool launched =
          await launchUrl(
        uri,
        mode:
            LaunchMode.externalApplication,
      );

      if (!launched) {
        Get.snackbar(
          'Unable to call',
          'Could not open the phone dialer.',
          snackPosition:
              SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Unable to call',
        'Could not open the phone dialer.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    }
  }
}