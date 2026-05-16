import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../data/discount_partner_repository.dart';
import '../data/slider_two_repository.dart';
import '../data/special_doctor_repository.dart';
import '../models/discount_partner.dart';
import '../models/slider_two.dart';
import '../models/special_doctor.dart';

class HomeController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final Rx<Locale> currentLocale = const Locale('en', 'US').obs;
  final Rxn<DailyTip> dailyTip = Rxn<DailyTip>();
  final RxBool dailyTipShown = false.obs;
  final RxBool _isFetchingDailyTip = false.obs;
  final AppApiService _apiService = AppApiService();
  final DiscountPartnerRepository discountPartnerRepository =
      DiscountPartnerRepository();
  final SliderTwoRepository sliderTwoRepository = SliderTwoRepository();
  final SpecialDoctorRepository specialDoctorRepository =
      SpecialDoctorRepository();
  final discountPartnerData = Rxn<DiscountPartner>();
  final sliderTwoData = Rxn<SliderTwo>();
  final specialDoctorData = Rxn<SpecialDoctor>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
//==============discount partner start===============
    discountPartner();
    sliderTwo();
    specialDoctor();
//==============discount partner end===============

    currentLocale.value = Get.locale ?? const Locale('en', 'US');
    _fetchDailyTip();

    // If the Home route was opened with a `tab` query parameter or argument,
    // initialize the tab index accordingly (used for redirect-after-login).
    try {
      final tabParam = Get.parameters['tab'] ??
          (Get.arguments is Map
              ? (Get.arguments as Map)['tab']?.toString()
              : null);
      if (tabParam != null && tabParam.isNotEmpty) {
        final parsed = int.tryParse(tabParam);
        if (parsed != null) {
          tabIndex.value = parsed;
        }
      }
    } catch (_) {
      // ignore parameter parsing errors
    }
  }

  discountPartner() async {
    final result = await discountPartnerRepository.fetchDiscountPartner();
    if (result != null) {
      discountPartnerData.value = result;
    }
    isLoading.value = true;
    try {
      if (discountPartnerData.value?.results?.isNotEmpty == true) {
        debugPrint(
            "==================================discountPartnerData==================   ${discountPartnerData.value!.results![0].name}");
      }
    } catch (_) {
      // ignore print errors
    }
  }

  sliderTwo() async {
    sliderTwoData.value = await sliderTwoRepository.fetchSliderTwo();

    debugPrint(
        "==================================sliderTwoData==================   ${sliderTwoData}");
  }

  specialDoctor() async {
    specialDoctorData.value =
        await specialDoctorRepository.fetchSpecialDoctor();
    debugPrint(
        "==================================specialDoctorData==================   ${specialDoctorData}");
  }

  bool changeTab(int index) {
    tabIndex.value = index;
    return true;
  }

  void changeLanguage(Locale locale) {
    currentLocale.value = locale;
    Get.updateLocale(locale);
  }

  bool get shouldShowDailyTip =>
      dailyTip.value != null && dailyTipShown.value == false;

  void markDailyTipShown() {
    dailyTipShown.value = true;
  }

  Future<void> _fetchDailyTip() async {
    if (_isFetchingDailyTip.value) return;
    _isFetchingDailyTip.value = true;

    try {
      final listResponse = await _apiService.get(
        path: '/api/v1/notifications/quote-wiserd/',
      );

      if (listResponse.statusCode < 200 || listResponse.statusCode >= 300) {
        _isFetchingDailyTip.value = false;
        return;
      }

      final listDecoded = jsonDecode(listResponse.body);
      final results = listDecoded is Map<String, dynamic>
          ? (listDecoded['results'] as List<dynamic>? ?? const <dynamic>[])
          : const <dynamic>[];
      Map<String, dynamic>? first;
      for (final item in results) {
        if (item is Map<String, dynamic> && item['id'] != null) {
          first = item;
          break;
        }
      }

      if (first == null) {
        _isFetchingDailyTip.value = false;
        return;
      }

      final idRaw = first['id'];
      final id = idRaw is int ? idRaw : int.tryParse(idRaw?.toString() ?? '');
      if (id == null) {
        _isFetchingDailyTip.value = false;
        return;
      }

      final detailResponse = await _apiService.get(
        path: '/api/v1/notifications/quote-wiserd/$id/',
      );

      if (detailResponse.statusCode < 200 || detailResponse.statusCode >= 300) {
        _isFetchingDailyTip.value = false;
        return;
      }

      final detailDecoded = jsonDecode(detailResponse.body);
      if (detailDecoded is! Map<String, dynamic>) {
        _isFetchingDailyTip.value = false;
        return;
      }

      final title = (detailDecoded['title'] ?? '').toString().trim();
      final quote = (detailDecoded['quote'] ?? '').toString().trim();

      if (title.isEmpty && quote.isEmpty) {
        _isFetchingDailyTip.value = false;
        return;
      }

      dailyTip.value = DailyTip(
        title: title,
        quote: quote,
        createdAt: (detailDecoded['created_at'] ?? '').toString(),
      );
    } catch (_) {
      // ignore errors and keep UI silent
    } finally {
      _isFetchingDailyTip.value = false;
    }
  }
}

class DailyTip {
  final String title;
  final String quote;
  final String createdAt;

  const DailyTip({
    required this.title,
    required this.quote,
    required this.createdAt,
  });
}
