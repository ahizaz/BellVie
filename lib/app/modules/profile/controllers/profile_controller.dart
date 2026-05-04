import 'dart:convert';

import 'package:bellevie/app/services/app_loader.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_routes.dart';
import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';
import '../../home/controllers/home_controller.dart';

class ProfileController extends GetxController {
  final AuthService authService = AuthService.to;
  final AppApiService _apiService = AppApiService();
  final ImagePicker _imagePicker = ImagePicker(); //

  @override
  void onReady() {
    super.onReady();
    fetchProfile();
  }

  Future<void> fetchProfile({bool showLoader = true}) async {
    if (showLoader) {
      AppLoader.show(status: 'Loading profile...');
    }

    try {
      final response = await _apiService.get(
        path: '/api/v1/auth/profile/',
      );

      debugPrint('Profile response status => ${response.statusCode}');
      debugPrint('Profile response body => ${response.body}');

      if (showLoader && AppLoader.isShow) {
        AppLoader.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
            AppLoader.showError(
              'Profile load failed. Invalid server response.');
          return;
        }

        final name = (decoded['name'] ?? '').toString().trim();
        final phone = (decoded['phone_number'] ?? '').toString().trim();
        final email = (decoded['email'] ?? '').toString().trim();
        final district = (decoded['district'] ?? '').toString().trim();
        final profilePicture =
            (decoded['profile_picture'] ?? '').toString().trim();

        await authService.updateProfile(
          name: name,
          phone: phone,
          email: email,
          district: district,
          profilePictureUrl: profilePicture,
        );

        debugPrint('Profile fetch success => name: $name, phone: $phone');
        return;
      }

      AppLoader.showError('Profile load failed. Please try again.');
    } catch (e) {
      if (showLoader && AppLoader.isShow) {
        AppLoader.dismiss();
      }
      debugPrint('Profile fetch error => $e');
      AppLoader.showError(
          'Profile load failed. Check internet and try again.');
    }
  }

  Future<void> pickAvatar() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
    );

    if (pickedImage == null) {
      return;
    }

    final Uint8List avatarBytes = await pickedImage.readAsBytes();
    authService.updateProfileAvatar(avatarBytes);
    await uploadProfilePicture(pickedImage);
  }

  Future<void> uploadProfilePicture(XFile imageFile) async {
    AppLoader.show(status: 'Uploading profile picture...');

    try {
      final response = await _apiService.putMultipart(
        path: '/api/v1/auth/profile/',
        fileField: 'profile_picture',
        filePath: imageFile.path,
      );

      debugPrint('Profile picture upload status => ${response.statusCode}');
      debugPrint('Profile picture upload body => ${response.body}');

      if (AppLoader.isShow) {
        AppLoader.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await fetchProfile(showLoader: false);
        AppLoader.showSuccess('Profile picture updated');
        return;
      }

      AppLoader.showError('Upload failed. Please try again.');
    } catch (e) {
      if (AppLoader.isShow) {
        AppLoader.dismiss();
      }
      debugPrint('Profile picture upload error => $e');
      AppLoader.showError('Upload failed. Check internet and try again.');
    }
  }

  Future<void> logout() async {
    await authService.logout();
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().changeTab(0);
    }
    Get.offAllNamed(Routes.LOGIN);
  }
}
