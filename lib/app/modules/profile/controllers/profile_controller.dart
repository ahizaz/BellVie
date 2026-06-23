import 'dart:convert';
import 'dart:typed_data';

import 'package:bellevie/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../services/api_service.dart';
import '../../../services/app_loader.dart';
import '../../../services/auth_service.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var isEditing = false.obs;

  var name = ''.obs;
  var email = ''.obs;
  var district = ''.obs;
  var phoneNumber = ''.obs;
  var profilePicture = ''.obs;
  var profileAvatarBytes = Rx<Uint8List?>(null);

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final districtCtrl = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  final recordTypeCtrl = TextEditingController();
  final selectedRecordFile = Rx<XFile?>(null);
  var isUploadingRecord = false.obs;

  //record file
  Future<void> pickRecordFile() async {
    final file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file != null) {
      selectedRecordFile.value = file;
    }
  }

Future<void> uploadMedicalRecord() async {
  try {
    if (recordTypeCtrl.text.trim().isEmpty) {
      Get.snackbar(
        'Required',
        'Please enter document type.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedRecordFile.value == null) {
      Get.snackbar(
        'Required',
        'Please select a document.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isUploadingRecord.value = true;

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

    final request = http.MultipartRequest(
      'POST',
      AppApiService().buildUrl('/api/v1/auth/record-documents/create/'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['documents_type'] = recordTypeCtrl.text.trim();

    request.files.add(
      await http.MultipartFile.fromPath(
        'document',
        selectedRecordFile.value!.path,
      ),
    );

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    debugPrint('Medical record status => ${response.statusCode}');
    debugPrint('Medical record response => ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      recordTypeCtrl.clear();
      selectedRecordFile.value = null;

      if (Get.isBottomSheetOpen == true) {
        Get.back();
      }

      Get.snackbar(
        'Success',
        'Medical record uploaded successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Upload Failed',
        'Could not upload medical record.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    debugPrint('Medical record upload error => $e');

    Get.snackbar(
      'Error',
      'Could not upload medical record.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  } finally {
    isUploadingRecord.value = false;
  }
}
  @override
  void onInit() {
    super.onInit();
    _loadCachedProfile();
    fetchProfile(showLoader: false);
  }

  void _loadCachedProfile() {
    final auth = AuthService.to;

    name.value = auth.profileName.value;
    email.value = auth.profileEmail.value;
    district.value = auth.profileDistrict.value;
    phoneNumber.value = auth.profilePhone.value;
    profilePicture.value = auth.profilePictureUrl.value;
    profileAvatarBytes.value = auth.profileAvatarBytes.value;

    nameCtrl.text = name.value;
    emailCtrl.text = email.value;
    districtCtrl.text = district.value;
  }

  Future<void> fetchProfile({bool showLoader = true}) async {
    try {
      if (showLoader) isLoading.value = true;

      final token = AuthService.to.accessToken.value;
      if (token.isEmpty) return;

      final response = await http.get(
        AppApiService().buildUrl('/api/v1/auth/profile/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        name.value = data['name'] ?? '';
        email.value = data['email'] ?? '';
        district.value = data['district'] ?? '';
        phoneNumber.value = data['phone_number'] ?? '';

        profilePicture.value = AppApiService.resolveImageUrl(
          (data['profile_picture'] ?? '').toString(),
        );

        nameCtrl.text = name.value;
        emailCtrl.text = email.value;
        districtCtrl.text = district.value;

        await AuthService.to.updateProfile(
          name: name.value,
          phone: phoneNumber.value,
          email: email.value,
          district: district.value,
          profilePictureUrl: profilePicture.value,
        );
      }
    } catch (e) {
      debugPrint('Fetch profile error => $e');
    } finally {
      if (showLoader) isLoading.value = false;
    }
  }

  Future<void> pickAndUploadProfilePicture() async {
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (picked == null) return;

      final bytes = await picked.readAsBytes();
      profileAvatarBytes.value = bytes;
      AuthService.to.updateProfileAvatar(bytes);

      AppLoader.show(status: 'Uploading photo...');

      final token = AuthService.to.accessToken.value;

      final request = http.MultipartRequest(
        'PUT',
        AppApiService().buildUrl('/api/v1/auth/profile/'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['name'] =
          nameCtrl.text.isNotEmpty ? nameCtrl.text : name.value;
      request.fields['email'] =
          emailCtrl.text.isNotEmpty ? emailCtrl.text : email.value;
      request.fields['district'] =
          districtCtrl.text.isNotEmpty ? districtCtrl.text : district.value;

      request.files.add(
        await http.MultipartFile.fromPath('profile_picture', picked.path),
      );

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        final newUrl = AppApiService.resolveImageUrl(
          (data['profile_picture'] ?? '').toString(),
        );

        if (newUrl.isNotEmpty) {
          profilePicture.value = newUrl;
        }

        await AuthService.to.updateProfile(
          name: name.value,
          phone: phoneNumber.value,
          email: email.value,
          district: district.value,
          profilePictureUrl: profilePicture.value,
        );

        AppLoader.showSuccess('Profile photo updated.');
        await fetchProfile(showLoader: false);
      } else {
        AppLoader.showError('Could not upload photo. Please try again.');
      }
    } catch (e) {
      debugPrint('Profile photo upload error => $e');
      AppLoader.showError('Could not open gallery or upload photo.');
    } finally {
      if (AppLoader.isShow) {
        AppLoader.dismiss();
      }
    }
  }

  Future<void> updateProfile() async {
    try {
      AppLoader.show(status: 'Updating profile...');

      final token = AuthService.to.accessToken.value;

      final request = http.MultipartRequest(
        'PUT',
        AppApiService().buildUrl('/api/v1/auth/profile/'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['name'] = nameCtrl.text;
      request.fields['email'] = emailCtrl.text;
      request.fields['district'] = districtCtrl.text;

      final streamed = await request.send();

      if (streamed.statusCode >= 200 && streamed.statusCode < 300) {
        name.value = nameCtrl.text;
        email.value = emailCtrl.text;
        district.value = districtCtrl.text;

        await AuthService.to.updateProfile(
          name: name.value,
          phone: phoneNumber.value,
          email: email.value,
          district: district.value,
          profilePictureUrl: profilePicture.value,
        );

        isEditing.value = false;
        await fetchProfile(showLoader: false);
        AppLoader.showSuccess('Profile updated.');
      } else {
        AppLoader.showError('Could not update profile.');
      }
    } catch (e) {
      debugPrint('Update profile error => $e');
      AppLoader.showError('Could not update profile.');
    } finally {
      if (AppLoader.isShow) {
        AppLoader.dismiss();
      }
    }
  }

  void logout() {
    AuthService.to.logout();
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    districtCtrl.dispose();
   
    recordTypeCtrl.dispose();
     super.onClose();
  }
}
