import 'package:bellevie/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import '../../../services/auth_service.dart';
import '../../../services/api_service.dart';

class AuthController extends GetxController {
  final AppApiService _apiService = AppApiService();

  String _extractApiErrorMessage(String responseBody, String fallbackMessage) {
    try {
      final decoded = jsonDecode(responseBody);

      if (decoded is Map<String, dynamic>) {
        final detail =
            decoded['detail'] ?? decoded['message'] ?? decoded['error'];
        if (detail is String && detail.trim().isNotEmpty) {
          return detail.trim();
        }

        for (final entry in decoded.entries) {
          final value = entry.value;
          if (value is List && value.isNotEmpty) {
            final first = value.first.toString().trim();
            if (first.isNotEmpty) {
              return '${entry.key}: $first';
            }
          }
          if (value is String && value.trim().isNotEmpty) {
            return '${entry.key}: ${value.trim()}';
          }
        }
      }

      if (decoded is List && decoded.isNotEmpty) {
        final first = decoded.first.toString().trim();
        if (first.isNotEmpty) {
          return first;
        }
      }
    } catch (_) {
      final raw = responseBody.trim();
      if (raw.isNotEmpty) {
        return raw;
      }
    }

    return fallbackMessage;
  }

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
  final RxBool showRegisterPasswordMismatch = false.obs;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();

  void validateRegisterPasswordMatch() {
    final password = registerPasswordController.text.trim();
    final confirmPassword = registerConfirmPasswordController.text.trim();
    showRegisterPasswordMismatch.value =
        confirmPassword.isNotEmpty && password != confirmPassword;
  }

  void clearRegistrationForm() {
    registerNameController.clear();
    registerEmailController.clear();
    registerPhoneController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    selectedDistrict.value = '';
    selectedRegisterCountryIso.value = 'BD';
    selectedRegisterCountryCode.value = '+880';
    showRegisterPasswordMismatch.value = false;
  }

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

      debugPrint('Login response status => ${response.statusCode}');
      debugPrint('Login response body => ${response.body}');

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          EasyLoading.showError('Login failed. Invalid response from server.');
          return;
        }

        final access = (decoded['access'] ?? '').toString().trim();
        final refresh = (decoded['refresh'] ?? '').toString().trim();

        if (access.isEmpty) {
          EasyLoading.showError('Login failed. Access token missing.');
          return;
        }

        String name = '';
        String userPhone = '$countryCode$phone';
        String email = '';

        final user = decoded['user'];
        if (user is Map<String, dynamic>) {
          name = (user['name'] ?? '').toString().trim();
          final apiPhone = (user['phone_number'] ?? '').toString().trim();
          if (apiPhone.isNotEmpty) {
            userPhone = apiPhone;
          }
          email = (user['email'] ?? '').toString().trim();
        }

        await AuthService.to.login(access: access, refresh: refresh);
        await AuthService.to.updateProfile(
          name: name,
          phone: userPhone,
          email: email,
        );

        debugPrint('Login success => profile + tokens saved');
        Get.offAllNamed(Routes.HOME);
        return;
      }

      final message = _extractApiErrorMessage(
        response.body,
        'Login failed. Please try again.',
      );

      EasyLoading.showError(message);
    } catch (e) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      debugPrint('Login error => $e');
      EasyLoading.showError('Login failed. Check internet and try again.');
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

    validateRegisterPasswordMatch();
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

        clearRegistrationForm();
        EasyLoading.showSuccess('registration_successful'.tr);
        Get.offNamed(Routes.LOGIN);
        return;
      }

      final message = _extractApiErrorMessage(
        response.body,
        'Registration failed. Please try again.',
      );

      EasyLoading.showError(message);
    } catch (e) {
      debugPrint('Register error => $e');
      final errorText = e.toString().trim();
      EasyLoading.showError(
        errorText.isNotEmpty
            ? errorText
            : 'Registration failed. Check internet and try again.',
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
