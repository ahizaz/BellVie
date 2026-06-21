
import 'dart:async';
import 'dart:convert';

import 'package:bellevie/app/modules/notification/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';

class NotificationController extends GetxController {
  final AppApiService _apiService = AppApiService();
  final AuthService _authService = AuthService.to;

  static const String _cacheKey = 'my_notifications_cache_v1';
  static const String _path = 'api/v1/notifications/my-notifications/';

  final notifications = <AppNotification>[].obs;
  final isFirstLoading = false.obs;
  final isUpdating = false.obs;

  Timer? _timer;
  bool _cacheLoaded = false;

  @override
  void onInit() {
    super.onInit();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    await _loadCache();

    await fetchNotifications(isInitial: true);

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      fetchNotifications();
    });
  }

  Future<void> _loadCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString(_cacheKey);

      if (cached == null || cached.isEmpty) {
        _cacheLoaded = true;
        return;
      }

      final decoded = jsonDecode(cached);
      final data = NotificationResponse.fromJson(decoded);

      notifications.assignAll(data.results);
      _cacheLoaded = true;
    } catch (e) {
      _cacheLoaded = true;
      debugPrint('Notification cache error => $e');
    }
  }

  Future<void> _saveCache(List<AppNotification> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final data = {
        'count': items.length,
        'results': items.map((e) => e.toJson()).toList(),
      };

      await prefs.setString(_cacheKey, jsonEncode(data));
    } catch (e) {
      debugPrint('Notification save cache error => $e');
    }
  }

  Future<void> fetchNotifications({bool isInitial = false}) async {
    if (isUpdating.value) return;

    try {
      if (isInitial && notifications.isEmpty) {
        isFirstLoading.value = true;
      }

      isUpdating.value = true;

      final token = _authService.accessToken.value.trim();

      if (token.isEmpty) {
        return;
      }

      final oldIds = notifications.map((e) => e.id).toSet();

      final response = await _apiService.getFresh(
        path: _path,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Notifications => status: ${response.statusCode}');
      debugPrint('Notifications => body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        final data = NotificationResponse.fromJson(decoded);

        final newJson =
            jsonEncode(data.results.map((e) => e.toJson()).toList());
        final oldJson =
            jsonEncode(notifications.map((e) => e.toJson()).toList());

        final newItems = data.results.where((item) {
          return !oldIds.contains(item.id);
        }).toList();

        if (newJson != oldJson) {
          notifications.assignAll(data.results);
        }

        await _saveCache(data.results);

        if (!isInitial && _cacheLoaded && newItems.isNotEmpty) {
          final latest = newItems.first;

          Get.snackbar(
            latest.title,
            latest.message,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 4),
            margin: const EdgeInsets.all(12),
          );
        }
      }
    } catch (e) {
      debugPrint('Notifications fetch error => $e');
      // Internet na thakle cache already screen e thakbe
    } finally {
      isFirstLoading.value = false;
      isUpdating.value = false;
    }
  }

  Future<void> markAsRead(AppNotification notification) async {
    try {
      if (notification.isRead) return;

      final index = notifications.indexWhere((e) => e.id == notification.id);

      if (index != -1) {
        notifications[index] = AppNotification(
          id: notification.id,
          title: notification.title,
          message: notification.message,
          isRead: true,
          createdAt: notification.createdAt,
        );

        notifications.refresh();
        await _saveCache(notifications);
      }

      final token = _authService.accessToken.value.trim();

      if (token.isEmpty) {
        return;
      }

      final path =
          'api/v1/notifications/my-notifications/${notification.id}/read/';

      final response = await _apiService.patch(
        path: path,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'is_read': true,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await fetchNotifications();
      }
    } catch (e) {
      debugPrint('markAsRead error => $e');
    }
  }

  int get unreadCount {
    return notifications.where((item) => item.isRead == false).length;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
