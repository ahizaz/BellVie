import 'dart:async';
import 'dart:convert';

import 'package:bellevie/app/modules/medical/models/medical_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';

class MedicalRecordsController extends GetxController {
  static const String _cacheKey = 'medical_records_cache_v1';

  final isFirstLoading = false.obs;
  final isUpdating = false.obs;
  final errorMessage = RxnString();
  final records = <MedicalRecordModel>[].obs;

  Timer? _refreshTimer;

  @override
  void onInit() {
    super.onInit();
    _initRecords();

    ever(AuthService.to.isLoggedIn, (loggedIn) {
      if (loggedIn) {
        fetchRecords();
      }
    });
  }

  Future<void> _initRecords() async {
    await _loadCache();
    await fetchRecords(isInitial: true);

    _refreshTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      fetchRecords();
    });
  }

  Future<void> _loadCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString(_cacheKey);

      if (cached == null || cached.isEmpty) return;

      final decoded = jsonDecode(cached);
      if (decoded is! List) return;

      records.assignAll(
        decoded
            .whereType<Map<String, dynamic>>()
            .map(MedicalRecordModel.fromJson)
            .toList(),
      );
    } catch (e) {
      debugPrint('Medical records cache read error => $e');
    }
  }

  Future<void> _saveCache(List<MedicalRecordModel> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _cacheKey,
        jsonEncode(items.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      debugPrint('Medical records cache save error => $e');
    }
  }

  Future<void> clearCache() async {
    records.clear();
    errorMessage.value = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
    } catch (e) {
      debugPrint('Medical records cache clear error => $e');
    }
  }

  Future<void> fetchRecords({bool isInitial = false}) async {
    if (isUpdating.value) return;

    final token = AuthService.to.accessToken.value.trim();

    if (token.isEmpty) {
      errorMessage.value = 'Please login to view medical records.';
      return;
    }

    try {
      if (isInitial && records.isEmpty) {
        isFirstLoading.value = true;
      }

      isUpdating.value = true;
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

        final fetched = list
            .map(
              (e) => MedicalRecordModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();

        final oldIds = records.map((e) => e.id).toSet();
        final hasNewItems = fetched.any((item) => !oldIds.contains(item.id));

        records.assignAll(fetched);
        await _saveCache(fetched);

        if (!isInitial && hasNewItems && records.isNotEmpty) {
          Get.snackbar(
            'New Record',
            'A new medical record has been added.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(12),
          );
        }
      } else if (records.isEmpty) {
        errorMessage.value = 'Failed to load medical records.';
      }
    } catch (_) {
      if (records.isEmpty) {
        errorMessage.value = 'Something went wrong.';
      }
    } finally {
      isFirstLoading.value = false;
      isUpdating.value = false;
    }
  }

  Future<void> deleteRecord(int recordId) async {
    final token = AuthService.to.accessToken.value.trim();

    try {
      final response = await http.delete(
        Uri.parse(
          '${AppApiService.baseUrl}/api/v1/auth/record-documents/$recordId/',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        records.removeWhere((e) => e.id == recordId);
        await _saveCache(records);

        Get.snackbar(
          'Success',
          'Medical record deleted successfully',
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete medical record',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
      );
    }
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }
}
