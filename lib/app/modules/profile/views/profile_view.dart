import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/auth_service.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService.to;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Obx(
          () {
            final name = authService.profileName.value;
            final phone = authService.profilePhone.value;
            final email = authService.profileEmail.value;
            final avatarBytes = authService.profileAvatarBytes.value;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F6F5F), Color(0xFF1C9A82)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFF0F6F5F).withValues(alpha: 0.18),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 54,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.22),
                              child: avatarBytes == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 54,
                                      color: Colors.white,
                                    )
                                  : ClipOval(
                                      child: Image.memory(
                                        avatarBytes,
                                        width: 108,
                                        height: 108,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Material(
                              color: Colors.white,
                              shape: const CircleBorder(),
                              elevation: 2,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: controller.pickAvatar,
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.photo_camera_outlined,
                                    size: 18,
                                    color: Color(0xFF0F6F5F),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          name.isEmpty ? 'Not set' : name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Personal details',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.88),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _InfoCard(
                    icon: Icons.person_outline,
                    label: 'Name',
                    value: name.isEmpty ? 'Not set' : name,
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: phone.isEmpty ? 'Not set' : phone,
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: email.isEmpty ? 'Not set' : email,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB42318),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F4F1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0F6F5F),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
