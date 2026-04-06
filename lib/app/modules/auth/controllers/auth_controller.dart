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
    final email = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      EasyLoading.showError('please_enter_phone_password'.tr);
      return;
    }

    await AuthService.to.login();
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> register() async {
    final name = registerNameController.text.trim();
    final email = registerEmailController.text.trim();
    final phone = registerPhoneController.text.trim();
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

    EasyLoading.showSuccess('registration_successful'.tr);
    Get.offNamed(Routes.LOGIN);
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
