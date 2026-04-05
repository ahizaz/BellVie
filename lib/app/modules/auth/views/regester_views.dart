import 'package:bellevie/app/modules/auth/controllers/auth_controller.dart';
import 'package:bellevie/app/routes/app_routes.dart';
import 'package:bellevie/app/theme/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});
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
                backgroundImage: const AssetImage(
                  'assets/images/banners/appicon.png',
                ),
              ),
              SizedBox(height: context.h(20)),
              const Text(
                'Registration',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: context.h(28)),
              TextField(
                controller: controller.registerNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.w(16),
                    vertical: context.h(16),
                  ),
                ),
              ),
              SizedBox(height: context.h(14)),
              TextField(
                controller: controller.registerEmailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email (optional)',
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.w(16),
                    vertical: context.h(16),
                  ),
                ),
              ),
              SizedBox(height: context.h(14)),
              TextField(
                controller: controller.registerPhoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.w(16),
                    vertical: context.h(16),
                  ),
                ),
              ),
              SizedBox(height: context.h(14)),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedDistrict.value.isEmpty
                      ? null
                      : controller.selectedDistrict.value,
                  isExpanded: true,
                  menuMaxHeight: context.h(100),
                  decoration: InputDecoration(
                    labelText: 'District',
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
              SizedBox(height: context.h(14)),
              TextField(
                controller: controller.registerPasswordController,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.w(16),
                    vertical: context.h(16),
                  ),
                ),
              ),
              SizedBox(height: context.h(14)),
              TextField(
                controller: controller.registerConfirmPasswordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
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
                  onPressed: controller.register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6FED),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: context.h(14)),
                  ),
                  child: const Text('Register'),
                ),
              ),
              SizedBox(height: context.h(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  TextButton(
                    onPressed: () => Get.offNamed(Routes.LOGIN),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: const Color(0xFF2F6FED),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
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
      )),
    );
  }
}
