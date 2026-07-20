
import 'package:bellevie/app/modules/auth/controllers/auth_controller.dart';
import 'package:bellevie/app/routes/app_routes.dart';
import 'package:bellevie/app/theme/responsive.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthController controller = Get.find<AuthController>();

  bool _obscureRegisterPassword = true;
  bool _obscureRegisterConfirmPassword = true;

  String _countryLabel(
    String iso,
    String dialCode,
  ) {
    return '$iso $dialCode';
  }

  Future<void> _submitRegistration() async {
    FocusScope.of(context).unfocus();

    await controller.register();
  }

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompactWidth;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
              context.w(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: context.w(
                    compact ? 34 : 40,
                  ),
                  backgroundImage: const AssetImage(
                    'assets/images/banners/appicon.png',
                  ),
                ),
                SizedBox(
                  height: context.h(20),
                ),
                Text(
                  'registration'.tr,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: context.h(28),
                ),

                // Name
                TextField(
                  controller: controller.registerNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'name'.tr,
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.w(16),
                      vertical: context.h(16),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.h(14),
                ),

                // Email
                TextField(
                  controller: controller.registerEmailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'email_optional'.tr,
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.w(16),
                      vertical: context.h(16),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.h(14),
                ),

                // Country and phone
                Row(
                  children: [
                    SizedBox(
                      width: context.w(
                        compact ? 100 : 112,
                      ),
                      child: Obx(
                        () => InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              favorite: const [
                                'BD',
                                'IN',
                              ],
                              countryListTheme: CountryListThemeData(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: 'search_country'.tr,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              onSelect: (Country country) {
                                controller.selectedRegisterCountryIso.value =
                                    country.countryCode;

                                controller.selectedRegisterCountryCode.value =
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
                              border: Border.all(
                                color: Colors.grey.shade600,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _countryLabel(
                                      controller
                                          .selectedRegisterCountryIso.value,
                                      controller
                                          .selectedRegisterCountryCode.value,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.w(10),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.registerPhoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'phone_number'.tr,
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
                SizedBox(
                  height: context.h(14),
                ),

                // District
                Obx(
                  () => DropdownButtonFormField<String>(
                    initialValue: controller.selectedDistrict.value.isEmpty
                        ? null
                        : controller.selectedDistrict.value,
                    isExpanded: true,
                    menuMaxHeight: context.h(220),
                    decoration: InputDecoration(
                      labelText: 'district'.tr,
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.w(16),
                        vertical: context.h(16),
                      ),
                    ),
                    items: AuthController.districts
                        .map(
                          (district) => DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selectedDistrict.value = value ?? '';
                    },
                  ),
                ),
                SizedBox(
                  height: context.h(14),
                ),

                // Password
                Obx(
                  () => TextField(
                    controller: controller.registerPasswordController,
                    obscureText: _obscureRegisterPassword,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) {
                      controller.validateRegisterPasswordMatch();
                    },
                    decoration: InputDecoration(
                      labelText: 'password'.tr,
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.w(16),
                        vertical: context.h(16),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureRegisterPassword =
                                !_obscureRegisterPassword;
                          });
                        },
                        icon: Icon(
                          _obscureRegisterPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      errorText: controller.showRegisterPasswordMismatch.value
                          ? 'passwords_do_not_match'.tr
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.h(14),
                ),

                // Confirm password
                Obx(
                  () => TextField(
                    controller: controller.registerConfirmPasswordController,
                    obscureText: _obscureRegisterConfirmPassword,
                    textInputAction: TextInputAction.done,
                    onChanged: (_) {
                      controller.validateRegisterPasswordMatch();
                    },
                    onSubmitted: (_) {
                      _submitRegistration();
                    },
                    decoration: InputDecoration(
                      labelText: 'confirm_password'.tr,
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.w(16),
                        vertical: context.h(16),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureRegisterConfirmPassword =
                                !_obscureRegisterConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _obscureRegisterConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      errorText: controller.showRegisterPasswordMismatch.value
                          ? 'passwords_do_not_match'.tr
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.h(20),
                ),

                // Register button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitRegistration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6FED),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: context.h(14),
                      ),
                    ),
                    child: Text('register'.tr),
                  ),
                ),
                SizedBox(
                  height: context.h(15),
                ),

                // Login navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${'already_have_account'.tr} ',
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(Routes.LOGIN);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: const Color(0xFF2F6FED),
                      ),
                      child: Text(
                        'login'.tr,
                        style: const TextStyle(
                          color: Color(0xFF2F6FED),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
