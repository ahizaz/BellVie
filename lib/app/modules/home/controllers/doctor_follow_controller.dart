import 'dart:convert';

import 'package:bellevie/app/modules/home/models/doctor_follow_up_model.dart';
import 'package:bellevie/app/services/api_service.dart';
import 'package:bellevie/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class DoctorFollowupController extends GetxController {
  final isLoading = false.obs;

  final followups = <DoctorFollowupModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchDoctorFollowups();
  }

  Future<void> fetchDoctorFollowups() async {
    try {
      isLoading.value = true;

      final token = AuthService.to.accessToken.value.trim();

      if (token.isEmpty) {
        Get.snackbar(
          'Login Required',
          'Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );

        return;
      }

      final response = await http.get(
        AppApiService().buildUrl(
          '/api/v1/auth/doctor-followups/',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint(
        'Doctor Follow-up Status => ${response.statusCode}',
      );

      debugPrint(
        'Doctor Follow-up Response => ${response.body}',
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        final List results = decoded['results'] ?? [];

        followups.value = results
            .map(
              (item) => DoctorFollowupModel.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Session Expired',
          'Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Could not load doctor follow-ups.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint(
        'Doctor Follow-up Error => $e',
      );

      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}