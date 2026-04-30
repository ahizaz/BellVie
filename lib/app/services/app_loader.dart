import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLoader {
  static bool _isShowing = false;

  /// If false, `showError` and `showSuccess` will not show visible
  /// snackbars and will only log messages via `debugPrint`.
  /// Set to `true` to re-enable snackbars globally.
  static bool enableSnackbars = false;

  static bool get isShow => _isShowing;

  static void show({String? status}) {
    if (_isShowing) return;
    _isShowing = true;
    try {
      // show a minimal centered spinner without a large dark box or status text
      // so the UI doesn't show an intrusive black overlay on real devices.
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: const Center(
            child: SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    } catch (_) {
      _isShowing = false;
    }
  }

  static void dismiss() {
    if (!_isShowing) return;
    try {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    } catch (_) {}
    _isShowing = false;
  }

  static void showError(String message) {
    dismiss();
    if (enableSnackbars) {
      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      debugPrint('AppLoader.showError: $message');
    }
  }

  static void showSuccess(String message) {
    dismiss();
    if (enableSnackbars) {
      Get.snackbar(
        'Success',
        message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      debugPrint('AppLoader.showSuccess: $message');
    }
  }
}
