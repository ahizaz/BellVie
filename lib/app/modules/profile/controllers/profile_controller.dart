import 'dart:convert';
import 'dart:typed_data';
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

  @override
  void onInit() {
    super.onInit();
    profileAvatarBytes.value = AuthService.to.profileAvatarBytes.value;
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    final token = AuthService.to.accessToken.value;
    final response = await http.get(
      Uri.parse('http://66.29.151.40:6060/api/v1/auth/profile/'),
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
    isLoading.value = false;
  }

  Future<void> pickAndUploadProfilePicture() async {
    try {
      final picked = await ImagePicker().pickImage(
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
      request.fields['name'] = nameCtrl.text.isNotEmpty ? nameCtrl.text : name.value;
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
        await fetchProfile();
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
    isLoading.value = true;
    final token = AuthService.to.accessToken.value;
    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('http://66.29.151.40:6060/api/v1/auth/profile/'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = nameCtrl.text;
    request.fields['email'] = emailCtrl.text;
    request.fields['district'] = districtCtrl.text;
    // If you want to support profile picture upload, add file here
    // request.files.add(await http.MultipartFile.fromPath('profile_picture', filePath));
    final streamed = await request.send();
    if (streamed.statusCode == 200) {
      isEditing.value = false;
      await fetchProfile();
    }
    isLoading.value = false;
  }

  void logout() {
    AuthService.to.logout();
    Get.offAllNamed('/login');
  }
}
