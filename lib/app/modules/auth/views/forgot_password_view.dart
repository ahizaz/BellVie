import 'package:bellevie/app/modules/auth/controllers/auth_controller.dart';
import 'package:bellevie/app/theme/responsive.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final AuthController controller = Get.find<AuthController>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String _countryLabel(String iso, String dialCode) {
    return '$iso $dialCode';
  }

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompactWidth;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.w(24)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reset your password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.h(24)),
                Row(
                  children: [
                    SizedBox(
                      width: context.w(compact ? 100 : 112),
                      child: Obx(
                        () => InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              favorite: const ['BD', 'IN'],
                              countryListTheme: const CountryListThemeData(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: 'Search country',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              onSelect: (Country country) {
                                controller.selectedForgotCountryIso.value =
                                    country.countryCode;
                                controller.selectedForgotCountryCode.value =
                                    '+${country.phoneCode}';
                              },
                            );
                          },
                          child: Container(
                            height: context.h(56),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.w(8),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _countryLabel(
                                      controller.selectedForgotCountryIso.value,
                                      controller
                                          .selectedForgotCountryCode.value,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.w(10)),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: context.w(16),
                            vertical: context.h(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.h(14)),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.w(16),
                      vertical: context.h(16),
                    ),
                  ),
                ),
                SizedBox(height: context.h(14)),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.w(16),
                      vertical: context.h(16),
                    ),
                  ),
                ),
                SizedBox(height: context.h(20)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.resetForgotPassword(
                      phoneNumber: phoneController.text.trim(),
                      countryCode: controller.selectedForgotCountryCode.value,
                      newPassword: newPasswordController.text.trim(),
                      confirmPassword: confirmPasswordController.text.trim(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6FED),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: context.h(14)),
                    ),
                    child: const Text('Reset Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
