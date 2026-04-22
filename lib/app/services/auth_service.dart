import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static const String _loggedInKey = 'auth_logged_in';
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _profileNameKey = 'profile_name';
  static const String _profilePhoneKey = 'profile_phone';
  static const String _profileEmailKey = 'profile_email';
  static const String _profileDistrictKey = 'profile_district';
  static const String _profilePictureUrlKey = 'profile_picture_url';

  final RxBool isLoggedIn = false.obs;
  final RxString accessToken = ''.obs;
  final RxString refreshToken = ''.obs;
  final RxString profileName = ''.obs;
  final RxString profilePhone = ''.obs;
  final RxString profileEmail = ''.obs;
  final RxString profileDistrict = ''.obs;
  final RxString profilePictureUrl = ''.obs;
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
    profileDistrict.value = _prefs?.getString(_profileDistrictKey) ?? '';
    profilePictureUrl.value = _prefs?.getString(_profilePictureUrlKey) ?? '';

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
    profileDistrict.value = '';
    profilePictureUrl.value = '';
    await _prefs?.setBool(_loggedInKey, false);
    await _prefs?.remove(_accessTokenKey);
    await _prefs?.remove(_refreshTokenKey);
    await _prefs?.remove(_profileDistrictKey);
    await _prefs?.remove(_profilePictureUrlKey);
    debugPrint('Auth logout => tokens cleared, loggedIn false');
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    String district = '',
    String profilePictureUrl = '',
  }) async {
    profileName.value = name;
    profilePhone.value = phone;
    profileEmail.value = email;
    profileDistrict.value = district;
    this.profilePictureUrl.value = profilePictureUrl;

    await _prefs?.setString(_profileNameKey, name);
    await _prefs?.setString(_profilePhoneKey, phone);
    await _prefs?.setString(_profileEmailKey, email);
    await _prefs?.setString(_profileDistrictKey, district);
    await _prefs?.setString(_profilePictureUrlKey, profilePictureUrl);
  }

  void updateProfileAvatar(Uint8List? avatarBytes) {
    profileAvatarBytes.value = avatarBytes;
  }

  bool requireLogin() {
    return true;
  }
}
