import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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

  @override
  void onInit() {
    super.onInit();
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
      profilePicture.value = data['profile_picture'] ?? '';
      nameCtrl.text = name.value;
      emailCtrl.text = email.value;
      districtCtrl.text = district.value;
    }
    isLoading.value = false;
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
