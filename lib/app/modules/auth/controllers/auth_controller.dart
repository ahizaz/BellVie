import 'package:bellevie/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../services/auth_service.dart';

class AuthController extends GetxController {
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
  final RxString selectedForgotCountryIso = 'BD'.obs;
  final RxString selectedForgotCountryCode = '+880'.obs;
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

  Future<void> login({
    required String phoneNumber,
    required String passwordText,
    required String countryCode,
  }) async {
    final phone = phoneNumber.trim();
    final password = passwordText.trim();
    final selectedCountryCode = countryCode.trim();

    if (phone.isEmpty || password.isEmpty) {
      EasyLoading.showError('please_enter_phone_password'.tr);
      return;
    }

    final requestBody = {
      'phone_number': '$selectedCountryCode$phone',
      'password': password,
    };

    EasyLoading.show(status: 'Please wait...');

    try {
      debugPrint('Login request body => $requestBody');

      final access =
          'local_access_${DateTime.now().millisecondsSinceEpoch.toString()}';
      final refresh =
          'local_refresh_${DateTime.now().millisecondsSinceEpoch.toString()}';
      final userPhone = '$selectedCountryCode$phone';

      await AuthService.to.login(access: access, refresh: refresh);
      await AuthService.to.updateProfile(
        name: '',
        phone: userPhone,
        email: '',
      );

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      debugPrint('Login success (local) => profile + tokens saved');
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      debugPrint('Login error => $e');
      EasyLoading.showError('Login failed. Please try again.');
    }
  }

  Future<void> resetForgotPassword({
    required String phoneNumber,
    required String countryCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final rawPhone = phoneNumber.trim();
    final selectedCountryCode = countryCode.trim();
    final password = newPassword.trim();
    final confirm = confirmPassword.trim();
    final formattedPhone =
        rawPhone.startsWith('+') ? rawPhone : '$selectedCountryCode$rawPhone';

    if (rawPhone.isEmpty) {
      EasyLoading.showError('Please enter your phone number.');
      return;
    }

    if (password.isEmpty || confirm.isEmpty) {
      EasyLoading.showError('Please enter new password and confirm password.');
      return;
    }

    if (password != confirm) {
      EasyLoading.showError('Passwords do not match.');
      return;
    }

    final requestBody = {
      'confirm_password': confirm,
      'new_password': password,
      'phone_number': formattedPhone,
    };

    EasyLoading.show(status: 'Please wait...');

    try {
      debugPrint('Reset password request body => $requestBody');

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      EasyLoading.showSuccess('Password reset successful. Please login.');
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      debugPrint('Reset password error => $e');
      EasyLoading.showError('Reset password failed. Please try again.');
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

      await AuthService.to.updateProfile(
        name: name,
        phone: '$countryCode$phone',
        email: email,
      );

      clearRegistrationForm();
      EasyLoading.showSuccess('registration_successful'.tr);
      Get.offNamed(Routes.LOGIN);
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
