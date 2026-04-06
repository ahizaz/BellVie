import 'package:bellevie/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../../../theme/responsive.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

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
                  radius: context.w(compact ? 34 : 40),
                  // backgroundColor: const Color(0xFF2F6FED),
                  backgroundImage: const AssetImage(
                    'assets/images/banners/appicon.png',
                  ),
                ),
                SizedBox(height: context.h(20)),
                Text(
                  'login'.tr,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.h(28)),
                TextField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'phone_number'.tr,
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.w(16),
                      vertical: context.h(16),
                    ),
                  ),
                ),
                SizedBox(height: context.h(14)),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'password'.tr,
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
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6FED),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: context.h(14)),
                    ),
                    child: Text('sign_in'.tr),
                  ),
                ),
                SizedBox(
                  height: context.h(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${'dont_have_account'.tr} '),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: const Color(0xFF2F6FED),
                      ),
                      child: Text(
                        'registration'.tr,
                        style: TextStyle(
                          color: Color(0xFF2F6FED),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
