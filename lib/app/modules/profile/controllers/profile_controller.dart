import 'dart:typed_data';


import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService authService = AuthService.to;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickAvatar() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
    );

    if (pickedImage == null) {
      return;
    }

    final Uint8List avatarBytes = await pickedImage.readAsBytes();
    authService.updateProfileAvatar(avatarBytes);
  }

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
