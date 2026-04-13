import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_routes.dart';
import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';

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
    final token = authService.accessToken.value.trim();
    if (token.isEmpty) {
      debugPrint('Profile fetch skipped => access token is empty');
      return;
    }

    if (showLoader) {
      EasyLoading.show(status: 'Loading profile...');
    }

    try {
      final response = await _apiService.get(
        path: '/api/v1/auth/profile/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Profile response status => ${response.statusCode}');
      debugPrint('Profile response body => ${response.body}');

      if (showLoader && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          EasyLoading.showError(
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

      EasyLoading.showError('Profile load failed. Please try again.');
    } catch (e) {
      if (showLoader && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      debugPrint('Profile fetch error => $e');
      EasyLoading.showError(
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
    final token = authService.accessToken.value.trim();
    if (token.isEmpty) {
      debugPrint('Profile picture upload skipped => access token is empty');
      EasyLoading.showError('Please login again.');
      return;
    }

    EasyLoading.show(status: 'Uploading profile picture...');

    try {
      final response = await _apiService.putMultipart(
        path: '/api/v1/auth/profile/',
        fileField: 'profile_picture',
        filePath: imageFile.path,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Profile picture upload status => ${response.statusCode}');
      debugPrint('Profile picture upload body => ${response.body}');

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await fetchProfile(showLoader: false);
        EasyLoading.showSuccess('Profile picture updated');
        return;
      }

      EasyLoading.showError('Upload failed. Please try again.');
    } catch (e) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      debugPrint('Profile picture upload error => $e');
      EasyLoading.showError('Upload failed. Check internet and try again.');
    }
  }

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
