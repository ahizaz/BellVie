
import 'package:bellevie/app/routes/app_routes.dart';
import 'package:bellevie/app/theme/responsive.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController controller =
      Get.find<AuthController>();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String _countryLabel(
    String iso,
    String dialCode,
  ) {
    return '$iso $dialCode';
  }

  Future<void> _submitLogin() async {
    FocusScope.of(context).unfocus();

    await controller.login(
      phoneNumber: phoneController.text.trim(),
      passwordText: passwordController.text.trim(),
      countryCode:
          controller.selectedLoginCountryCode.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompactWidth;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.w(24)),
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
                SizedBox(height: context.h(20)),
                Text(
                  'login'.tr,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.h(28)),
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
                              countryListTheme:
                                  CountryListThemeData(
                                borderRadius:
                                    const BorderRadius
                                        .vertical(
                                  top: Radius.circular(16),
                                ),
                                inputDecoration:
                                    InputDecoration(
                                  labelText:
                                      'search_country'.tr,
                                  border:
                                      const OutlineInputBorder(),
                                ),
                              ),
                              onSelect:
                                  (Country country) {
                                controller
                                        .selectedLoginCountryIso
                                        .value =
                                    country.countryCode;

                                controller
                                        .selectedLoginCountryCode
                                        .value =
                                    '+${country.phoneCode}';
                              },
                            );
                          },
                          child: Container(
                            height: context.h(56),
                            padding:
                                EdgeInsets.symmetric(
                              horizontal:
                                  context.w(8),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Colors.grey.shade600,
                              ),
                              borderRadius:
                                  BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _countryLabel(
                                      controller
                                          .selectedLoginCountryIso
                                          .value,
                                      controller
                                          .selectedLoginCountryCode
                                          .value,
                                    ),
                                    style:
                                        const TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                          FontWeight.w600,
                                      color:
                                          Colors.black87,
                                    ),
                                    overflow:
                                        TextOverflow.ellipsis,
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
                    SizedBox(width: context.w(10)),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType:
                            TextInputType.phone,
                        textInputAction:
                            TextInputAction.next,
                        decoration: InputDecoration(
                          labelText:
                              'phone_number'.tr,
                          border:
                              const OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(
                            horizontal:
                                context.w(16),
                            vertical:
                                context.h(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.h(14)),
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  textInputAction:
                      TextInputAction.done,
                  onSubmitted: (_) {
                    _submitLogin();
                  },
                  decoration: InputDecoration(
                    labelText: 'password'.tr,
                    border:
                        const OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(
                      horizontal: context.w(16),
                      vertical: context.h(16),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword =
                              !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(
                        Routes.FORGOT_PASSWORD,
                      );
                    },
                    child: Text(
                      'forgot_password_question'.tr,
                    ),
                  ),
                ),
                SizedBox(height: context.h(20)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitLogin,
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2F6FED),
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(
                        vertical: context.h(14),
                      ),
                    ),
                    child: Text('sign_in'.tr),
                  ),
                ),
                SizedBox(height: context.h(15)),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      '${'dont_have_account'.tr} ',
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      style:
                          TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize:
                            MaterialTapTargetSize
                                .shrinkWrap,
                        foregroundColor:
                            const Color(0xFF2F6FED),
                      ),
                      child: Text(
                        'registration'.tr,
                        style: const TextStyle(
                          color:
                              Color(0xFF2F6FED),
                          fontWeight:
                              FontWeight.w600,
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