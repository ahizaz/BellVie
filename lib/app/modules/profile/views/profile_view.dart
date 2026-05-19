import 'package:bellevie/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        backgroundColor: const Color(0xffF7F7FB),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffF7F7FB),
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),

                /// Profile Image
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
                        backgroundColor: Colors.white,
                        backgroundImage:
                            controller.profilePicture.value.isNotEmpty
                                ? NetworkImage(
                                    controller.profilePicture.value,
                                  )
                                : null,
                        child: controller.profilePicture.value.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),

                    /// Edit profile image icon
                    Container(
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
                  ],
                ),

                const SizedBox(height: 30),

                /// Fields
                _profileField(
                  label: 'Name',
                  controller: controller.nameCtrl,
                  editable: controller.isEditing.value,
                  onEditTap: () {
                    controller.isEditing.value = true;
                  },
                ),

                const SizedBox(height: 18),

                _profileField(
                  label: 'Email',
                  controller: controller.emailCtrl,
                  editable: controller.isEditing.value,
                  onEditTap: () {
                    controller.isEditing.value = true;
                  },
                ),

                const SizedBox(height: 18),

                _profileField(
                  label: 'District',
                  controller: controller.districtCtrl,
                  editable: controller.isEditing.value,
                  onEditTap: () {
                    controller.isEditing.value = true;
                  },
                ),

                const SizedBox(height: 18),

                _readonlyField(
                  'Phone',
                  controller.phoneNumber.value,
                ),

                const SizedBox(height: 40),

                /// Save Button
                if (controller.isEditing.value)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: controller.updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                if (controller.isEditing.value) const SizedBox(height: 16),

                /// Logout Button
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
                    child: const Text(
                      'Logout',
                      style: TextStyle(
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

  // Widget _profileField({
  //   required String label,
  //   required TextEditingController controller,
  //   required bool editable,
  //   required VoidCallback onEditTap,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 4, bottom: 8),
  //         child: Text(
  //           label,
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: Colors.grey.shade700,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ),
  //       TextField(
  //         controller: controller,
  //         enabled: editable,
  //         style: const TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w500,
  //         ),
  //         decoration: InputDecoration(
  //           filled: true,
  //           fillColor: Colors.white,
  //           contentPadding: const EdgeInsets.symmetric(
  //             horizontal: 18,
  //             vertical: 18,
  //           ),
  //           suffixIcon: InkWell(
  //             onTap: onEditTap,
  //             child: const Icon(
  //               Icons.edit_outlined,
  //               color: Colors.deepPurple,
  //             ),
  //           ),
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(18),
  //             borderSide: BorderSide.none,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(18),
  //             borderSide: BorderSide(
  //               color: Colors.grey.shade200,
  //             ),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(18),
  //             borderSide: const BorderSide(
  //               color: Colors.deepPurple,
  //               width: 1.5,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
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

            /// Pencil Icon
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
}
