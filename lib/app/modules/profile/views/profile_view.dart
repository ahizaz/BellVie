import 'package:bellevie/app/modules/profile/controllers/profile_controller.dart';
import 'package:bellevie/app/modules/profile/service/video_room_service.dart';
import 'package:bellevie/app/modules/profile/views/video_call_screen.dart';
import 'package:bellevie/app/widgets/privacy_policy_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../widgets/terms_bottom_sheet.dart';
import '../../../services/auth_service.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }

    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xffF7F7FB),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffF7F7FB),
          title: Text(
            'account'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.deepPurple.shade100,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: _profileImageProvider(controller),
                        child: _profileImageProvider(controller) == null
                            ? const Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.pickAndUploadProfilePicture,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                //user account
                _accountOption(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                  title: 'user_account'.tr,
                  onTap: () {
                    final isLoggedIn = AuthService.to.authenticated;

                    if (!isLoggedIn) {
                      Get.snackbar(
                        'login_required'.tr,
                        'please_login_to_view_account'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    Get.bottomSheet(
                      Obx(
                        () => Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            left: 20,
                            right: 20,
                            top: 16,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 40,
                                  height: 4,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                _profileField(
                                  label: 'name'.tr,
                                  controller: controller.nameCtrl,
                                  editable: controller.isEditing.value,
                                  onEditTap: () {
                                    controller.isEditing.value = true;
                                  },
                                ),
                                const SizedBox(height: 18),
                                _profileField(
                                  label: 'email'.tr,
                                  controller: controller.emailCtrl,
                                  editable: controller.isEditing.value,
                                  onEditTap: () {
                                    controller.isEditing.value = true;
                                  },
                                ),
                                const SizedBox(height: 18),
                                _profileField(
                                  label: 'district'.tr,
                                  controller: controller.districtCtrl,
                                  editable: controller.isEditing.value,
                                  onEditTap: () {
                                    controller.isEditing.value = true;
                                  },
                                ),
                                const SizedBox(height: 18),
                                _readonlyField(
                                  'phone'.tr,
                                  controller.phoneNumber.value,
                                ),
                                const SizedBox(height: 20),
                                if (controller.isEditing.value)
                                  SizedBox(
                                    width: double.infinity,
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await controller.updateProfile();
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: Text(
                                        'save_changes'.tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
                //terms and condition
                const SizedBox(height: 16),
                _accountOption(
                  leading: Image.asset(
                    'assets/images/banners/term&condition.png',
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                  title: 'terms_conditions'.tr,
                  onTap: () {
                    showTermsBottomSheet(context);
                  },
                ),
                const SizedBox(height: 12),
                //privacy policy
                _accountOption(
                  leading: Image.asset(
                    'assets/images/banners/privacy_policy.png',
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                  title: 'privacy_policy'.tr,
                  onTap: () {
                    showPrivacyPolicyBottomSheet(context);
                  },
                ),
                //video_consultation
                const SizedBox(height: 12),
                _accountOption(
                  leading: const Icon(
                    Icons.video_call,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                  title: 'Video Consultation',
                  onTap: () async {
                    final isLoggedIn = AuthService.to.authenticated;

                    if (!isLoggedIn) {
                      Get.snackbar(
                        'login_required'.tr,
                        'please_login_to_view_account'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    try {
                      Get.dialog(
                        const Center(child: CircularProgressIndicator()),
                        barrierDismissible: false,
                      );

                      final roomId = await VideoRoomService().getMyRoomId();

                      if (Get.isDialogOpen == true) {
                        Get.back();
                      }

                      Get.to(() => VideoCallScreen(roomId: roomId));
                    } catch (e) {
                      if (Get.isDialogOpen == true) {
                        Get.back();
                      }

                      Get.snackbar(
                        'Error',
                        e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                //medical records
                _accountOption(
                  leading: Image.asset(
                    'assets/images/banners/records.png',
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                  title: 'Medical Records',
                  onTap: () {
                    final isLoggedIn = AuthService.to.authenticated;

                    if (!isLoggedIn) {
                      Get.snackbar(
                        'Login Required',
                        'Please login first.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    _showMedicalRecordUploadSheet(context);
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: controller.logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'logout'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _profileField({
    required String label,
    required TextEditingController controller,
    required bool editable,
    required VoidCallback onEditTap,
  }) {
    final focusNode = FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          readOnly: !editable,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            suffixIcon: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                onEditTap();

                Future.delayed(
                  const Duration(milliseconds: 100),
                  () {
                    focusNode.requestFocus();
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: Colors.deepPurple,
                  size: 20,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                color: Colors.deepPurple,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _readonlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextField(
          controller: TextEditingController(text: value),
          enabled: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            suffixIcon: const Icon(
              Icons.lock_outline,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider? _profileImageProvider(ProfileController controller) {
    final bytes = controller.profileAvatarBytes.value;
    if (bytes != null && bytes.isNotEmpty) {
      return MemoryImage(bytes);
    }

    final url = controller.profilePicture.value;
    if (url.isNotEmpty) {
      return NetworkImage(url);
    }

    return null;
  }

  Widget _accountOption({
    required Widget leading,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: .06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: 28,
                height: 28,
                child: leading,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _showMedicalRecordUploadSheet(BuildContext context) {
    Get.bottomSheet(
      Obx(
        () => Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Upload Medical Record',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.recordTypeCtrl,
                  decoration: InputDecoration(
                    hintText: 'Document Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: controller.pickRecordFile,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.upload_file,
                          color: Colors.deepPurple,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            controller.selectedRecordFile.value?.name ??
                                'Choose Document',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isUploadingRecord.value
                        ? null
                        : controller.uploadMedicalRecord,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: controller.isUploadingRecord.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Upload Record',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
