import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AuthService extends GetxService {
  static const String _loggedInKey = 'auth_logged_in';
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _profileNameKey = 'profile_name';
  static const String _profilePhoneKey = 'profile_phone';
  static const String _profileEmailKey = 'profile_email';

  final RxBool isLoggedIn = false.obs;
  final RxString accessToken = ''.obs;
  final RxString refreshToken = ''.obs;
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
    accessToken.value = _prefs?.getString(_accessTokenKey) ?? '';
    refreshToken.value = _prefs?.getString(_refreshTokenKey) ?? '';
    profileName.value = _prefs?.getString(_profileNameKey) ?? '';
    profilePhone.value = _prefs?.getString(_profilePhoneKey) ?? '';
    profileEmail.value = _prefs?.getString(_profileEmailKey) ?? '';

    debugPrint(
      'Auth init => loggedIn: ${isLoggedIn.value}, hasAccess: ${accessToken.value.isNotEmpty}',
    );

    if (isLoggedIn.value && accessToken.value.isEmpty) {
      isLoggedIn.value = false;
      await _prefs?.setBool(_loggedInKey, false);
      debugPrint(
          'Auth init => cleared invalid logged-in state (no access token)');
    }

    return this;
  }

  Future<void> login({required String access, String refresh = ''}) async {
    isLoggedIn.value = true;
    accessToken.value = access;
    refreshToken.value = refresh;
    await _prefs?.setBool(_loggedInKey, true);
    await _prefs?.setString(_accessTokenKey, access);
    await _prefs?.setString(_refreshTokenKey, refresh);
    debugPrint('Auth login => token saved, loggedIn true');
  }

  Future<void> logout() async {
    isLoggedIn.value = false;
    accessToken.value = '';
    refreshToken.value = '';
    profileAvatarBytes.value = null;
    await _prefs?.setBool(_loggedInKey, false);
    await _prefs?.remove(_accessTokenKey);
    await _prefs?.remove(_refreshTokenKey);
    debugPrint('Auth logout => tokens cleared, loggedIn false');
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
