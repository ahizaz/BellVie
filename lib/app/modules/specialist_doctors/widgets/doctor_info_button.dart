import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/auth_service.dart';
import '../../../routes/app_routes.dart';

class DoctorInfoButton extends StatelessWidget {
  final int doctorId;
  const DoctorInfoButton({Key? key, required this.doctorId}) : super(key: key);

  static Future<void> openDoctorDetails(
    BuildContext context,
    int doctorId,
  ) async {
    final loggedIn = AuthService.to.authenticated;
    if (!loggedIn) {
      AuthService.to
          .setPendingRedirect('${Routes.DOCTOR_DETAILS}?id=$doctorId');
      await Get.toNamed(Routes.LOGIN);
      return;
    }

    Get.toNamed('${Routes.DOCTOR_DETAILS}?id=$doctorId');
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline, color: Colors.black54),
      onPressed: () => openDoctorDetails(context, doctorId),
      tooltip: 'View details',
    );
  }
}
