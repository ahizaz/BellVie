import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AuthService extends GetxService {
  static const String _loggedInKey = 'auth_logged_in';
  static const String _profileNameKey = 'profile_name';
  static const String _profilePhoneKey = 'profile_phone';
  static const String _profileEmailKey = 'profile_email';

  final RxBool isLoggedIn = false.obs;
  final RxString profileName = ''.obs;
  final RxString profilePhone = ''.obs;
  final RxString profileEmail = ''.obs;
  final Rxn<Uint8List> profileAvatarBytes = Rxn<Uint8List>();

  SharedPreferences? _prefs;

  bool get authenticated => isLoggedIn.value;

  static AuthService get to => Get.find<AuthService>();

  Future<AuthService> init() async {
    _prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = _prefs?.getBool(_loggedInKey) ?? false;
    profileName.value = _prefs?.getString(_profileNameKey) ?? '';
    profilePhone.value = _prefs?.getString(_profilePhoneKey) ?? '';
    profileEmail.value = _prefs?.getString(_profileEmailKey) ?? '';
    return this;
  }

  Future<void> login() async {
    isLoggedIn.value = true;
    await _prefs?.setBool(_loggedInKey, true);
  }

  Future<void> logout() async {
    isLoggedIn.value = false;
    profileAvatarBytes.value = null;
    await _prefs?.setBool(_loggedInKey, false);
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
  }) async {
    profileName.value = name;
    profilePhone.value = phone;
    profileEmail.value = email;

    await _prefs?.setString(_profileNameKey, name);
    await _prefs?.setString(_profilePhoneKey, phone);
    await _prefs?.setString(_profileEmailKey, email);
  }

  void updateProfileAvatar(Uint8List? avatarBytes) {
    profileAvatarBytes.value = avatarBytes;
  }

  bool requireLogin() {
    if (authenticated) {
      return true;
    }

    Get.toNamed(Routes.LOGIN);
    return false;
  }
}
