import 'dart:convert';

import 'package:bellevie/app/modules/medical/models/medical_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';


class MedicalRecordsController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = RxnString();
  final records = <MedicalRecordModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    final token = AuthService.to.accessToken.value.trim();

    if (token.isEmpty) {
      errorMessage.value = 'Please login to view medical records.';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = null;

      final uri = Uri.parse(
        '${AppApiService.baseUrl}/api/v1/auth/record-documents/',
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final list = data['results'] as List? ?? [];

        records.value = list
            .map(
              (e) => MedicalRecordModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      } else {
        errorMessage.value = 'Failed to load medical records.';
      }
    } catch (_) {
      errorMessage.value = 'Something went wrong.';
    } finally {
      isLoading.value = false;
    }
  }
}