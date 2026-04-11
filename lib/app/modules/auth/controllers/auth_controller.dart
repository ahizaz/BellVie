import 'package:bellevie/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import '../../../services/auth_service.dart';
import '../../../services/api_service.dart';

class AuthController extends GetxController {
  final AppApiService _apiService = AppApiService();

  static const List<String> districts = [
    'Bagerhat',
    'Bandarban',
    'Barguna',
    'Barishal',
    'Bhola',
    'Bogura',
    'Brahmanbaria',
    'Chandpur',
    'Chapainawabganj',
    'Chattogram',
    'Chuadanga',
    'Coxs Bazar',
    'Cumilla',
    'Dhaka',
    'Dinajpur',
    'Faridpur',
    'Feni',
    'Gaibandha',
    'Gazipur',
    'Gopalganj',
    'Habiganj',
    'Jamalpur',
    'Jashore',
    'Jhalokati',
    'Jhenaidah',
    'Joypurhat',
    'Khagrachhari',
    'Khulna',
    'Kishoreganj',
    'Kurigram',
    'Kushtia',
    'Lakshmipur',
    'Lalmonirhat',
    'Madaripur',
    'Magura',
    'Manikganj',
    'Meherpur',
    'Moulvibazar',
    'Munshiganj',
    'Mymensingh',
    'Naogaon',
    'Narail',
    'Narayanganj',
    'Narsingdi',
    'Natore',
    'Netrokona',
    'Nilphamari',
    'Noakhali',
    'Pabna',
    'Panchagarh',
    'Patuakhali',
    'Pirojpur',
    'Rajbari',
    'Rajshahi',
    'Rangamati',
    'Rangpur',
    'Satkhira',
    'Shariatpur',
    'Sherpur',
    'Sirajganj',
    'Sunamganj',
    'Sylhet',
    'Tangail',
    'Thakurgaon',
  ];

  final RxString selectedDistrict = ''.obs;
  final RxString selectedLoginCountryIso = 'BD'.obs;
  final RxString selectedLoginCountryCode = '+880'.obs;
  final RxString selectedRegisterCountryIso = 'BD'.obs;
  final RxString selectedRegisterCountryCode = '+880'.obs;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();

  Future<void> login() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final countryCode = selectedLoginCountryCode.value;

    if (phone.isEmpty || password.isEmpty) {
      EasyLoading.showError('please_enter_phone_password'.tr);
      return;
    }

    final requestBody = {
      'phone_number': '$countryCode$phone',
      'password': password,
    };

    EasyLoading.show(status: 'Please wait...');

    try {
      debugPrint('Login request body => $requestBody');

      final response = await _apiService.post(
        path: '/api/v1/auth/login/',
        body: requestBody,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await AuthService.to.login();
        await AuthService.to.updateProfile(
          name: AuthService.to.profileName.value,
          phone: '$countryCode$phone',
          email: AuthService.to.profileEmail.value,
        );
        Get.offAllNamed(Routes.HOME);
        return;
      }

      String message = 'Login failed. Please try again.';
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          final detail = decoded['detail'] ?? decoded['message'];
          if (detail is String && detail.trim().isNotEmpty) {
            message = detail;
          }
        }
      } catch (_) {
        debugPrint('Login response is not valid JSON');
      }

      EasyLoading.showError(message);
    } catch (e) {
      debugPrint('Login error => $e');
      EasyLoading.showError('Login failed. Check internet and try again.');
    } finally {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
  }

  Future<void> register() async {
    final name = registerNameController.text.trim();
    final phone = registerPhoneController.text.trim();
    final countryCode = selectedRegisterCountryCode.value;
    final email = registerEmailController.text.trim();
    final password = registerPasswordController.text.trim();
    final confirmPassword = registerConfirmPasswordController.text.trim();

    if (name.isEmpty || phone.isEmpty || selectedDistrict.value.isEmpty) {
      EasyLoading.showError('please_fill_required_fields'.tr);
      return;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      EasyLoading.showError('please_enter_password_confirm_password'.tr);
      return;
    }

    if (password != confirmPassword) {
      EasyLoading.showError('passwords_do_not_match'.tr);
      return;
    }

    final requestBody = {
      'password': password,
      'phone_number': '$countryCode$phone',
      'name': name,
      'email': email,
      'district': selectedDistrict.value,
    };

    EasyLoading.show(status: 'Please wait...');

    try {
      debugPrint('Register request body => $requestBody');

      final response = await _apiService.post(
        path: '/api/v1/auth/register/',
        body: requestBody,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await AuthService.to.updateProfile(
          name: name,
          phone: '$countryCode$phone',
          email: email,
        );

        EasyLoading.showSuccess('registration_successful'.tr);
        Get.offNamed(Routes.LOGIN);
        return;
      }

      String message = 'Registration failed. Please try again.';
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          final detail = decoded['detail'] ?? decoded['message'];
          if (detail is String && detail.trim().isNotEmpty) {
            message = detail;
          }
        }
      } catch (_) {
        debugPrint('Register response is not valid JSON');
      }

      EasyLoading.showError(message);
    } catch (e) {
      debugPrint('Register error => $e');
      EasyLoading.showError(
        'Registration failed. Check internet and try again.',
      );
    } finally {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }
}
