
// import 'dart:convert';

// import 'package:bellevie/app/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:bellevie/app/services/app_loader.dart';
// import '../../../services/auth_service.dart';
// import '../../../services/api_service.dart';

// class AuthController extends GetxController {
//   final AppApiService _apiService = AppApiService();

//   static const List<String> districts = [
//     'Bagerhat',
//     'Bandarban',
//     'Barguna',
//     'Barishal',
//     'Bhola',
//     'Bogura',
//     'Brahmanbaria',
//     'Chandpur',
//     'Chapainawabganj',
//     'Chattogram',
//     'Chuadanga',
//     'Coxs Bazar',
//     'Cumilla',
//     'Dhaka',
//     'Dinajpur',
//     'Faridpur',
//     'Feni',
//     'Gaibandha',
//     'Gazipur',
//     'Gopalganj',
//     'Habiganj',
//     'Jamalpur',
//     'Jashore',
//     'Jhalokati',
//     'Jhenaidah',
//     'Joypurhat',
//     'Khagrachhari',
//     'Khulna',
//     'Kishoreganj',
//     'Kurigram',
//     'Kushtia',
//     'Lakshmipur',
//     'Lalmonirhat',
//     'Madaripur',
//     'Magura',
//     'Manikganj',
//     'Meherpur',
//     'Moulvibazar',
//     'Munshiganj',
//     'Mymensingh',
//     'Naogaon',
//     'Narail',
//     'Narayanganj',
//     'Narsingdi',
//     'Natore',
//     'Netrokona',
//     'Nilphamari',
//     'Noakhali',
//     'Pabna',
//     'Panchagarh',
//     'Patuakhali',
//     'Pirojpur',
//     'Rajbari',
//     'Rajshahi',
//     'Rangamati',
//     'Rangpur',
//     'Satkhira',
//     'Shariatpur',
//     'Sherpur',
//     'Sirajganj',
//     'Sunamganj',
//     'Sylhet',
//     'Tangail',
//     'Thakurgaon',
//   ];

//   final RxString selectedDistrict = ''.obs;
//   final RxString selectedLoginCountryIso = 'BD'.obs;
//   final RxString selectedLoginCountryCode = '+880'.obs;
//   final RxString selectedForgotCountryIso = 'BD'.obs;
//   final RxString selectedForgotCountryCode = '+880'.obs;
//   final RxString selectedRegisterCountryIso = 'BD'.obs;
//   final RxString selectedRegisterCountryCode = '+880'.obs;
//   final RxBool showRegisterPasswordMismatch = false.obs;

//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController registerNameController = TextEditingController();
//   final TextEditingController registerEmailController = TextEditingController();
//   final TextEditingController registerPhoneController = TextEditingController();
//   final TextEditingController registerPasswordController =
//       TextEditingController();
//   final TextEditingController registerConfirmPasswordController =
//       TextEditingController();

//   void validateRegisterPasswordMatch() {
//     final password = registerPasswordController.text.trim();
//     final confirmPassword = registerConfirmPasswordController.text.trim();

//     showRegisterPasswordMismatch.value =
//         confirmPassword.isNotEmpty && password != confirmPassword;
//   }

//   void clearRegistrationForm() {
//     registerNameController.clear();
//     registerEmailController.clear();
//     registerPhoneController.clear();
//     registerPasswordController.clear();
//     registerConfirmPasswordController.clear();

//     selectedDistrict.value = '';
//     selectedRegisterCountryIso.value = 'BD';
//     selectedRegisterCountryCode.value = '+880';
//     showRegisterPasswordMismatch.value = false;
//   }

//   Future<void> login({
//     required String phoneNumber,
//     required String passwordText,
//     required String countryCode,
//   }) async {
//     final phone = phoneNumber.trim();
//     final password = passwordText.trim();
//     final selectedCountryCode = countryCode.trim();

//     if (phone.isEmpty || password.isEmpty) {
//       AppLoader.showError('please_enter_phone_password'.tr);
//       return;
//     }

//     final requestBody = {
//       'phone_number': '$selectedCountryCode$phone',
//       'password': password,
//     };

//     AppLoader.show(status: 'Please wait...');

//     try {
//       debugPrint('Login request body => $requestBody');

//       final response = await _postToFirstAvailable(
//         candidatePaths: const [
//           '/api/v1/auth/login/',
//           '/api/v1/auth/sign-in/',
//           '/api/v1/login/',
//         ],
//         body: requestBody,
//       );

//       if (response.statusCode < 200 || response.statusCode >= 300) {
//         final message = _extractErrorMessage(response.body);

//         throw Exception(
//           message.isEmpty ? 'Login failed. Please try again.' : message,
//         );
//       }

//       final dynamic decoded = _safeJsonDecode(response.body);

//       final access =
//           _extractToken(decoded, ['access', 'access_token', 'token']);
//       final refresh = _extractToken(decoded, ['refresh', 'refresh_token']);

//       if (access.isEmpty || refresh.isEmpty) {
//         throw Exception('Login failed. Invalid token response.');
//       }

//       final name = _extractValue(decoded, ['name', 'full_name']);
//       final email = _extractValue(decoded, ['email']);
//       final district = _extractValue(decoded, ['district']);
//       final profilePicture = _extractValue(
//         decoded,
//         ['profile_picture', 'profile_image', 'avatar'],
//       );

//       final userPhone =
//           _extractValue(decoded, ['phone_number', 'phone']).isEmpty
//               ? '$selectedCountryCode$phone'
//               : _extractValue(decoded, ['phone_number', 'phone']);

//       await AuthService.to.login(access: access, refresh: refresh);

//       await AuthService.to.updateProfile(
//         name: name,
//         phone: userPhone,
//         email: email,
//         district: district,
//         profilePictureUrl: profilePicture,
//       );

//       if (AppLoader.isShow) {
//         AppLoader.dismiss();
//       }

//       AppLoader.showSuccess('Login successful.');

//       debugPrint('Login success (local) => profile + tokens saved');

//       final args = Get.arguments;
//       final redirect = (args is Map ? args['redirect'] as String? : null) ??
//           AuthService.to.consumePendingRedirect();

//       if (redirect != null && redirect.isNotEmpty && redirect != Routes.LOGIN) {
//         Get.offAllNamed(redirect);
//       } else {
//         Get.offAllNamed(Routes.HOME);
//       }
//     } catch (e) {
//       if (AppLoader.isShow) {
//         AppLoader.dismiss();
//       }

//       debugPrint('Login error => $e');

//       String errorMessage = e.toString().replaceFirst('Exception: ', '').trim();

//       if (errorMessage.isEmpty) {
//         errorMessage = 'Login failed. Please try again.';
//       }

//       AppLoader.showError(errorMessage);
//     }
//   }

//   Future<void> resetForgotPassword({
//     required String phoneNumber,
//     required String countryCode,
//     required String newPassword,
//     required String confirmPassword,
//   }) async {
//     final rawPhone = phoneNumber.trim();
//     final selectedCountryCode = countryCode.trim();
//     final password = newPassword.trim();
//     final confirm = confirmPassword.trim();

//     final formattedPhone =
//         rawPhone.startsWith('+') ? rawPhone : '$selectedCountryCode$rawPhone';

//     if (rawPhone.isEmpty) {
//       AppLoader.showError('Please enter your phone number.');
//       return;
//     }

//     if (password.isEmpty || confirm.isEmpty) {
//       AppLoader.showError('Please enter new password and confirm password.');
//       return;
//     }

//     if (password != confirm) {
//       AppLoader.showError('Passwords do not match.');
//       return;
//     }

//     final requestBody = {
//       'confirm_password': confirm,
//       'new_password': password,
//       'phone_number': formattedPhone,
//     };

//     AppLoader.show(status: 'Please wait...');

//     try {
//       debugPrint('Reset password request body => $requestBody');

//       final response = await _postToFirstAvailable(
//         candidatePaths: const [
//           '/api/v1/auth/reset-password/',
//           '/api/v1/auth/forgot-password/',
//           '/api/v1/auth/password-reset/',
//         ],
//         body: requestBody,
//       );

//       if (response.statusCode < 200 || response.statusCode >= 300) {
//         final message = _extractErrorMessage(response.body);

//         throw Exception(
//           message.isEmpty
//               ? 'Reset password failed. Please try again.'
//               : message,
//         );
//       }

//       if (AppLoader.isShow) {
//         AppLoader.dismiss();
//       }

//       if (Get.isDialogOpen ?? false) {
//         Get.back();
//       }

//       AppLoader.showSuccess('Password reset successful. Please login.');
//       Get.offAllNamed(Routes.LOGIN);
//     } catch (e) {
//       if (AppLoader.isShow) {
//         AppLoader.dismiss();
//       }

//       debugPrint('Reset password error => $e');

//       String errorMessage = e.toString().replaceFirst('Exception: ', '').trim();

//       if (errorMessage.isEmpty) {
//         errorMessage = 'Reset password failed. Please try again.';
//       }

//       AppLoader.showError(errorMessage);
//     }
//   }

//   Future<void> register() async {
//     final name = registerNameController.text.trim();
//     final phone = registerPhoneController.text.trim();
//     final countryCode = selectedRegisterCountryCode.value;
//     final email = registerEmailController.text.trim();
//     final password = registerPasswordController.text.trim();
//     final confirmPassword = registerConfirmPasswordController.text.trim();

//     if (name.isEmpty || phone.isEmpty || selectedDistrict.value.isEmpty) {
//       AppLoader.showError('please_fill_required_fields'.tr);
//       return;
//     }

//     if (password.isEmpty || confirmPassword.isEmpty) {
//       AppLoader.showError('please_enter_password_confirm_password'.tr);
//       return;
//     }

//     validateRegisterPasswordMatch();

//     if (password != confirmPassword) {
//       AppLoader.showError('passwords_do_not_match'.tr);
//       return;
//     }

//     final requestBody = {
//       'password': password,
//       'phone_number': '$countryCode$phone',
//       'name': name,
//       'email': email,
//       'district': selectedDistrict.value,
//     };

//     AppLoader.show(status: 'Please wait...');

//     try {
//       debugPrint('Register request body => $requestBody');

//       final response = await _postToFirstAvailable(
//         candidatePaths: const [
//           '/api/v1/auth/register/',
//           '/api/v1/auth/sign-up/',
//           '/api/v1/register/',
//         ],
//         body: requestBody,
//       );

//       if (response.statusCode < 200 || response.statusCode >= 300) {
//         final message = _extractErrorMessage(response.body);

//         throw Exception(
//           message.isEmpty ? 'Registration failed. Please try again.' : message,
//         );
//       }

//       final dynamic decoded = _safeJsonDecode(response.body);

//       final access =
//           _extractToken(decoded, ['access', 'access_token', 'token']);
//       final refresh = _extractToken(decoded, ['refresh', 'refresh_token']);

//       if (access.isNotEmpty && refresh.isNotEmpty) {
//         await AuthService.to.login(access: access, refresh: refresh);
//       }

//       await AuthService.to.updateProfile(
//         name: name,
//         phone: '$countryCode$phone',
//         email: email,
//       );

//       clearRegistrationForm();

//       AppLoader.showSuccess('registration_successful'.tr);
//       Get.offNamed(Routes.LOGIN);
//     } catch (e) {
//       debugPrint('Register error => $e');

//       String errorMessage = e.toString().replaceFirst('Exception: ', '').trim();

//       if (errorMessage.isEmpty) {
//         errorMessage = 'Registration failed. Check internet and try again.';
//       }

//       AppLoader.showError(errorMessage);
//     } finally {
//       if (AppLoader.isShow) {
//         AppLoader.dismiss();
//       }
//     }
//   }

//   @override
//   void onClose() {
//     phoneController.dispose();
//     passwordController.dispose();
//     registerNameController.dispose();
//     registerEmailController.dispose();
//     registerPhoneController.dispose();
//     registerPasswordController.dispose();
//     registerConfirmPasswordController.dispose();
//     super.onClose();
//   }

//   Future<dynamic> _postToFirstAvailable({
//     required List<String> candidatePaths,
//     required Map<String, dynamic> body,
//   }) async {
//     dynamic lastResponse;
//     dynamic lastError;

//     for (final path in candidatePaths) {
//       try {
//         final response = await _apiService.post(path: path, body: body);

//         if (response.statusCode == 404 || response.statusCode == 405) {
//           lastResponse = response;
//           continue;
//         }

//         return response;
//       } catch (e) {
//         lastError = e;
//       }
//     }

//     if (lastResponse != null) {
//       return lastResponse;
//     }

//     throw Exception(lastError?.toString() ?? 'Request failed.');
//   }

//   dynamic _safeJsonDecode(String raw) {
//     try {
//       if (raw.trim().isEmpty) return null;
//       return jsonDecode(raw);
//     } catch (_) {
//       return null;
//     }
//   }

//   String _extractToken(dynamic decoded, List<String> keys) {
//     if (decoded is! Map<String, dynamic>) return '';

//     for (final key in keys) {
//       final direct = (decoded[key] ?? '').toString().trim();
//       if (direct.isNotEmpty) return direct;
//     }

//     final nestedUser = decoded['user'];
//     if (nestedUser is Map<String, dynamic>) {
//       for (final key in keys) {
//         final value = (nestedUser[key] ?? '').toString().trim();
//         if (value.isNotEmpty) return value;
//       }
//     }

//     final nestedData = decoded['data'];
//     if (nestedData is Map<String, dynamic>) {
//       for (final key in keys) {
//         final value = (nestedData[key] ?? '').toString().trim();
//         if (value.isNotEmpty) return value;
//       }
//     }

//     return '';
//   }

//   String _extractValue(dynamic decoded, List<String> keys) {
//     if (decoded is! Map<String, dynamic>) return '';

//     for (final key in keys) {
//       final direct = (decoded[key] ?? '').toString().trim();
//       if (direct.isNotEmpty) return direct;
//     }

//     final nestedUser = decoded['user'];
//     if (nestedUser is Map<String, dynamic>) {
//       for (final key in keys) {
//         final value = (nestedUser[key] ?? '').toString().trim();
//         if (value.isNotEmpty) return value;
//       }
//     }

//     final nestedData = decoded['data'];
//     if (nestedData is Map<String, dynamic>) {
//       for (final key in keys) {
//         final value = (nestedData[key] ?? '').toString().trim();
//         if (value.isNotEmpty) return value;
//       }
//     }

//     return '';
//   }

//   String _extractErrorMessage(String responseBody) {
//     final decoded = _safeJsonDecode(responseBody);

//     if (decoded is Map<String, dynamic>) {
//       final nonFieldErrors = decoded['non_field_errors'];

//       if (nonFieldErrors is List && nonFieldErrors.isNotEmpty) {
//         return nonFieldErrors.first.toString();
//       }

//       final candidates = [
//         decoded['message'],
//         decoded['detail'],
//         decoded['error'],
//       ];

//       for (final item in candidates) {
//         final text = (item ?? '').toString().trim();
//         if (text.isNotEmpty) return text;
//       }
//     }

//     return '';
//   }
// }
// import 'dart:convert';

// import 'package:bellevie/app/routes/app_routes.dart';
// import 'package:bellevie/app/services/app_loader.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../services/api_service.dart';
// import '../../../services/auth_service.dart';

// class AuthController extends GetxController {
//   final AppApiService _apiService = AppApiService();

//   static const List<String> districts = [
//     'Bagerhat',
//     'Bandarban',
//     'Barguna',
//     'Barishal',
//     'Bhola',
//     'Bogura',
//     'Brahmanbaria',
//     'Chandpur',
//     'Chapainawabganj',
//     'Chattogram',
//     'Chuadanga',
//     'Coxs Bazar',
//     'Cumilla',
//     'Dhaka',
//     'Dinajpur',
//     'Faridpur',
//     'Feni',
//     'Gaibandha',
//     'Gazipur',
//     'Gopalganj',
//     'Habiganj',
//     'Jamalpur',
//     'Jashore',
//     'Jhalokati',
//     'Jhenaidah',
//     'Joypurhat',
//     'Khagrachhari',
//     'Khulna',
//     'Kishoreganj',
//     'Kurigram',
//     'Kushtia',
//     'Lakshmipur',
//     'Lalmonirhat',
//     'Madaripur',
//     'Magura',
//     'Manikganj',
//     'Meherpur',
//     'Moulvibazar',
//     'Munshiganj',
//     'Mymensingh',
//     'Naogaon',
//     'Narail',
//     'Narayanganj',
//     'Narsingdi',
//     'Natore',
//     'Netrokona',
//     'Nilphamari',
//     'Noakhali',
//     'Pabna',
//     'Panchagarh',
//     'Patuakhali',
//     'Pirojpur',
//     'Rajbari',
//     'Rajshahi',
//     'Rangamati',
//     'Rangpur',
//     'Satkhira',
//     'Shariatpur',
//     'Sherpur',
//     'Sirajganj',
//     'Sunamganj',
//     'Sylhet',
//     'Tangail',
//     'Thakurgaon',
//   ];

//   final RxString selectedDistrict = ''.obs;

//   final RxString selectedLoginCountryIso = 'BD'.obs;
//   final RxString selectedLoginCountryCode = '+880'.obs;

//   final RxString selectedForgotCountryIso = 'BD'.obs;
//   final RxString selectedForgotCountryCode = '+880'.obs;

//   final RxString selectedRegisterCountryIso = 'BD'.obs;
//   final RxString selectedRegisterCountryCode = '+880'.obs;

//   final RxBool showRegisterPasswordMismatch = false.obs;

//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   final TextEditingController registerNameController =
//       TextEditingController();

//   final TextEditingController registerEmailController =
//       TextEditingController();

//   final TextEditingController registerPhoneController =
//       TextEditingController();

//   final TextEditingController registerPasswordController =
//       TextEditingController();

//   final TextEditingController registerConfirmPasswordController =
//       TextEditingController();

//   void validateRegisterPasswordMatch() {
//     final password = registerPasswordController.text.trim();

//     final confirmPassword =
//         registerConfirmPasswordController.text.trim();

//     showRegisterPasswordMismatch.value =
//         confirmPassword.isNotEmpty &&
//         password != confirmPassword;
//   }

//   void clearRegistrationForm() {
//     registerNameController.clear();
//     registerEmailController.clear();
//     registerPhoneController.clear();
//     registerPasswordController.clear();
//     registerConfirmPasswordController.clear();

//     selectedDistrict.value = '';
//     selectedRegisterCountryIso.value = 'BD';
//     selectedRegisterCountryCode.value = '+880';
//     showRegisterPasswordMismatch.value = false;
//   }

//   Future<void> login({
//     required String phoneNumber,
//     required String passwordText,
//     required String countryCode,
//   }) async {
//     final phone = phoneNumber.trim();
//     final password = passwordText.trim();
//     final selectedCountryCode = countryCode.trim();

//     if (phone.isEmpty || password.isEmpty) {
//       await _showCenteredErrorDialog(
//         'please_enter_phone_password'.tr,
//       );
//       return;
//     }

//     final requestBody = {
//       'phone_number': '$selectedCountryCode$phone',
//       'password': password,
//     };

//     AppLoader.show(status: 'Please wait...');

//     try {
//       final response = await _postToFirstAvailable(
//         candidatePaths: const [
//           '/api/v1/auth/login/',
//           '/api/v1/auth/sign-in/',
//           '/api/v1/login/',
//         ],
//         body: requestBody,
//       );

//       debugPrint(
//         'Login status code => ${response.statusCode}',
//       );

//       debugPrint(
//         'Login response body => ${response.body}',
//       );

//       if (response.statusCode < 200 ||
//           response.statusCode >= 300) {
//         final backendMessage =
//             _extractErrorMessage(response.body);

//         await _showCenteredErrorDialog(
//           backendMessage.isNotEmpty
//               ? backendMessage
//               : 'Login failed. Please try again.',
//         );

//         return;
//       }

//       final dynamic decoded =
//           _safeJsonDecode(response.body);

//       final access = _extractToken(
//         decoded,
//         [
//           'access',
//           'access_token',
//           'token',
//         ],
//       );

//       final refresh = _extractToken(
//         decoded,
//         [
//           'refresh',
//           'refresh_token',
//         ],
//       );

//       if (access.isEmpty || refresh.isEmpty) {
//         throw Exception(
//           'Login failed. Invalid token response.',
//         );
//       }

//       final name = _extractValue(
//         decoded,
//         [
//           'name',
//           'full_name',
//         ],
//       );

//       final email = _extractValue(
//         decoded,
//         ['email'],
//       );

//       final district = _extractValue(
//         decoded,
//         ['district'],
//       );

//       final profilePicture = _extractValue(
//         decoded,
//         [
//           'profile_picture',
//           'profile_image',
//           'avatar',
//         ],
//       );

//       final responsePhone = _extractValue(
//         decoded,
//         [
//           'phone_number',
//           'phone',
//         ],
//       );

//       final userPhone = responsePhone.isEmpty
//           ? '$selectedCountryCode$phone'
//           : responsePhone;

//       await AuthService.to.login(
//         access: access,
//         refresh: refresh,
//       );

//       await AuthService.to.updateProfile(
//         name: name,
//         phone: userPhone,
//         email: email,
//         district: district,
//         profilePictureUrl: profilePicture,
//       );

//       if (AppLoader.isShow) {
//         AppLoader.dismiss();
//       }

//       AppLoader.showSuccess('Login successful.');

//       final args = Get.arguments;

//       final redirect =
//           (args is Map
//                   ? args['redirect'] as String?
//                   : null) ??
//               AuthService.to.consumePendingRedirect();

//       if (redirect != null &&
//           redirect.isNotEmpty &&
//           redirect != Routes.LOGIN) {
//         Get.offAllNamed(redirect);
//       } else {
//         Get.offAllNamed(Routes.HOME);
//       }
//     } catch (e) {
//       debugPrint('Login error => $e');

//       final errorMessage = _extractExceptionMessage(
//         e,
//         fallback: 'Login failed. Please try again.',
//       );

//       await _showCenteredErrorDialog(errorMessage);
//     }
//   }

//   Future<void> resetForgotPassword({
//     required String phoneNumber,
//     required String countryCode,
//     required String newPassword,
//     required String confirmPassword,
//   }) async {
//     final rawPhone = phoneNumber.trim();
//     final selectedCountryCode = countryCode.trim();
//     final password = newPassword.trim();
//     final confirm = confirmPassword.trim();

//     final formattedPhone = rawPhone.startsWith('+')
//         ? rawPhone
//         : '$selectedCountryCode$rawPhone';

//     if (rawPhone.isEmpty) {
//       await _showCenteredErrorDialog(
//         'Please enter your phone number.',
//       );
//       return;
//     }

//     if (password.isEmpty || confirm.isEmpty) {
//       await _showCenteredErrorDialog(
//         'Please enter new password and confirm password.',
//       );
//       return;
//     }

//     if (password != confirm) {
//       await _showCenteredErrorDialog(
//         'Passwords do not match.',
//       );
//       return;
//     }

//     final requestBody = {
//       'confirm_password': confirm,
//       'new_password': password,
//       'phone_number': formattedPhone,
//     };

//     AppLoader.show(status: 'Please wait...');

//     try {
//       final response = await _postToFirstAvailable(
//         candidatePaths: const [
//           '/api/v1/auth/reset-password/',
//           '/api/v1/auth/forgot-password/',
//           '/api/v1/auth/password-reset/',
//         ],
//         body: requestBody,
//       );

//       debugPrint(
//         'Reset password status code => '
//         '${response.statusCode}',
//       );

//       debugPrint(
//         'Reset password response body => '
//         '${response.body}',
//       );

//       if (response.statusCode < 200 ||
//           response.statusCode >= 300) {
//         final backendMessage =
//             _extractErrorMessage(response.body);

//         await _showCenteredErrorDialog(
//           backendMessage.isNotEmpty
//               ? backendMessage
//               : 'Reset password failed. Please try again.',
//         );

//         return;
//       }

//       if (AppLoader.isShow) {
//         AppLoader.dismiss();
//       }

//       AppLoader.showSuccess(
//         'Password reset successful. Please login.',
//       );

//       Get.offAllNamed(Routes.LOGIN);
//     } catch (e) {
//       debugPrint('Reset password error => $e');

//       final errorMessage = _extractExceptionMessage(
//         e,
//         fallback:
//             'Reset password failed. Please try again.',
//       );

//       await _showCenteredErrorDialog(errorMessage);
//     }
//   }

//   Future<void> register() async {
//     final name = registerNameController.text.trim();
//     final phone = registerPhoneController.text.trim();

//     final countryCode =
//         selectedRegisterCountryCode.value.trim();

//     final email = registerEmailController.text.trim();
//     final password =
//         registerPasswordController.text.trim();

//     final confirmPassword =
//         registerConfirmPasswordController.text.trim();

//     if (name.isEmpty ||
//         phone.isEmpty ||
//         selectedDistrict.value.isEmpty) {
//       await _showCenteredErrorDialog(
//         'please_fill_required_fields'.tr,
//       );
//       return;
//     }

//     if (password.isEmpty ||
//         confirmPassword.isEmpty) {
//       await _showCenteredErrorDialog(
//         'please_enter_password_confirm_password'.tr,
//       );
//       return;
//     }

//     validateRegisterPasswordMatch();

//     if (password != confirmPassword) {
//       await _showCenteredErrorDialog(
//         'passwords_do_not_match'.tr,
//       );
//       return;
//     }

//     final requestBody = {
//       'password': password,
//       'phone_number': '$countryCode$phone',
//       'name': name,
//       'email': email,
//       'district': selectedDistrict.value,
//     };

//     AppLoader.show(status: 'Please wait...');

//     try {
//       final response = await _postToFirstAvailable(
//         candidatePaths: const [
//           '/api/v1/auth/register/',
//           '/api/v1/auth/sign-up/',
//           '/api/v1/register/',
//         ],
//         body: requestBody,
//       );

//       debugPrint(
//         'Register status code => ${response.statusCode}',
//       );

//       debugPrint(
//         'Register response body => ${response.body}',
//       );

//       if (response.statusCode < 200 ||
//           response.statusCode >= 300) {
//         final backendMessage =
//             _extractErrorMessage(response.body);

//         await _showCenteredErrorDialog(
//           backendMessage.isNotEmpty
//               ? backendMessage
//               : 'Registration failed. Please try again.',
//         );

//         return;
//       }

//       final dynamic decoded =
//           _safeJsonDecode(response.body);

//       final access = _extractToken(
//         decoded,
//         [
//           'access',
//           'access_token',
//           'token',
//         ],
//       );

//       final refresh = _extractToken(
//         decoded,
//         [
//           'refresh',
//           'refresh_token',
//         ],
//       );

//       if (access.isNotEmpty && refresh.isNotEmpty) {
//         await AuthService.to.login(
//           access: access,
//           refresh: refresh,
//         );
//       }

//       await AuthService.to.updateProfile(
//         name: name,
//         phone: '$countryCode$phone',
//         email: email,
//       );

//       clearRegistrationForm();

//       if (AppLoader.isShow) {
//         AppLoader.dismiss();
//       }

//       AppLoader.showSuccess(
//         'registration_successful'.tr,
//       );

//       Get.offNamed(Routes.LOGIN);
//     } catch (e) {
//       debugPrint('Register error => $e');

//       final errorMessage = _extractExceptionMessage(
//         e,
//         fallback:
//             'Registration failed. Please try again.',
//       );

//       await _showCenteredErrorDialog(errorMessage);
//     }
//   }

//   Future<void> _showCenteredErrorDialog(
//     String message,
//   ) async {
//     if (AppLoader.isShow) {
//       AppLoader.dismiss();

//       await Future.delayed(
//         const Duration(milliseconds: 150),
//       );
//     }

//     if (Get.context == null &&
//         Get.overlayContext == null) {
//       AppLoader.showError(message);
//       return;
//     }

//     if (Get.isDialogOpen ?? false) {
//       Get.back();

//       await Future.delayed(
//         const Duration(milliseconds: 100),
//       );
//     }

//     await Get.dialog<void>(
//       AlertDialog(
//         backgroundColor: Colors.white,
//         scrollable: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         titlePadding: const EdgeInsets.fromLTRB(
//           24,
//           24,
//           24,
//           0,
//         ),
//         contentPadding: const EdgeInsets.fromLTRB(
//           24,
//           16,
//           24,
//           8,
//         ),
//         actionsPadding: const EdgeInsets.fromLTRB(
//           24,
//           8,
//           24,
//           20,
//         ),
//         title: const Column(
//           children: [
//             Icon(
//               Icons.error_outline_rounded,
//               color: Colors.red,
//               size: 52,
//             ),
//             SizedBox(height: 12),
//             Text(
//               'Error',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 15,
//             height: 1.4,
//             color: Colors.black87,
//           ),
//         ),
//         actionsAlignment: MainAxisAlignment.center,
//         actions: [
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (Get.isDialogOpen ?? false) {
//                   Get.back();
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                     const Color(0xFF2F6FED),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 12,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('OK'),
//             ),
//           ),
//         ],
//       ),
//       barrierDismissible: true,
//     );
//   }

//   Future<dynamic> _postToFirstAvailable({
//     required List<String> candidatePaths,
//     required Map<String, dynamic> body,
//   }) async {
//     dynamic lastResponse;

//     for (final path in candidatePaths) {
//       try {
//         final response = await _apiService.post(
//           path: path,
//           body: body,
//         );

//         if (response.statusCode == 404 ||
//             response.statusCode == 405) {
//           lastResponse = response;
//           continue;
//         }

//         return response;
//       } catch (e) {
//         /*
//          * Login/register endpoint থেকে 400/401 exception
//          * এলে সঙ্গে সঙ্গে rethrow করা হচ্ছে। এতে পরের fallback
//          * endpoint-এর 404 error আসল backend error-কে replace
//          * করতে পারবে না।
//          */
//         debugPrint(
//           'POST request error for $path => $e',
//         );

//         rethrow;
//       }
//     }

//     if (lastResponse != null) {
//       return lastResponse;
//     }

//     throw Exception('Request failed.');
//   }

//   dynamic _safeJsonDecode(String raw) {
//     try {
//       if (raw.trim().isEmpty) {
//         return null;
//       }

//       return jsonDecode(raw);
//     } catch (_) {
//       return null;
//     }
//   }

//   String _extractToken(
//     dynamic decoded,
//     List<String> keys,
//   ) {
//     if (decoded is! Map<String, dynamic>) {
//       return '';
//     }

//     for (final key in keys) {
//       final direct =
//           (decoded[key] ?? '').toString().trim();

//       if (direct.isNotEmpty) {
//         return direct;
//       }
//     }

//     final nestedUser = decoded['user'];

//     if (nestedUser is Map<String, dynamic>) {
//       for (final key in keys) {
//         final value =
//             (nestedUser[key] ?? '').toString().trim();

//         if (value.isNotEmpty) {
//           return value;
//         }
//       }
//     }

//     final nestedData = decoded['data'];

//     if (nestedData is Map<String, dynamic>) {
//       for (final key in keys) {
//         final value =
//             (nestedData[key] ?? '').toString().trim();

//         if (value.isNotEmpty) {
//           return value;
//         }
//       }
//     }

//     return '';
//   }

//   String _extractValue(
//     dynamic decoded,
//     List<String> keys,
//   ) {
//     if (decoded is! Map<String, dynamic>) {
//       return '';
//     }

//     for (final key in keys) {
//       final direct =
//           (decoded[key] ?? '').toString().trim();

//       if (direct.isNotEmpty) {
//         return direct;
//       }
//     }

//     final nestedUser = decoded['user'];

//     if (nestedUser is Map<String, dynamic>) {
//       for (final key in keys) {
//         final value =
//             (nestedUser[key] ?? '').toString().trim();

//         if (value.isNotEmpty) {
//           return value;
//         }
//       }
//     }

//     final nestedData = decoded['data'];

//     if (nestedData is Map<String, dynamic>) {
//       for (final key in keys) {
//         final value =
//             (nestedData[key] ?? '').toString().trim();

//         if (value.isNotEmpty) {
//           return value;
//         }
//       }
//     }

//     return '';
//   }

//   String _extractErrorMessage(
//     String responseBody,
//   ) {
//     final rawBody = responseBody.trim();

//     if (rawBody.isEmpty) {
//       return '';
//     }

//     final dynamic decoded =
//         _safeJsonDecode(rawBody);

//     if (decoded == null) {
//       return rawBody;
//     }

//     return _formatBackendError(decoded).trim();
//   }

//   String _formatBackendError(
//     dynamic value, {
//     String? fieldName,
//   }) {
//     if (value == null) {
//       return '';
//     }

//     if (value is String) {
//       final message = value.trim();

//       if (message.isEmpty) {
//         return '';
//       }

//       if (fieldName == null ||
//           fieldName.isEmpty) {
//         return message;
//       }

//       return '${_formatFieldName(fieldName)}: '
//           '$message';
//     }

//     if (value is num || value is bool) {
//       final message = value.toString();

//       if (fieldName == null ||
//           fieldName.isEmpty) {
//         return message;
//       }

//       return '${_formatFieldName(fieldName)}: '
//           '$message';
//     }

//     if (value is List) {
//       final messages = value
//           .map(
//             (item) => _formatBackendError(item),
//           )
//           .where(
//             (message) => message.trim().isNotEmpty,
//           )
//           .toSet()
//           .toList();

//       if (messages.isEmpty) {
//         return '';
//       }

//       final combinedMessage = messages.join('\n');

//       if (fieldName == null ||
//           fieldName.isEmpty) {
//         return combinedMessage;
//       }

//       return '${_formatFieldName(fieldName)}: '
//           '$combinedMessage';
//     }

//     if (value is Map) {
//       final normalizedMap = <String, dynamic>{};

//       value.forEach((key, item) {
//         normalizedMap[key.toString()] = item;
//       });

//       final errors = normalizedMap['errors'];

//       if (errors != null) {
//         final message =
//             _formatBackendError(errors);

//         if (message.isNotEmpty) {
//           return message;
//         }
//       }

//       final nonFieldErrors =
//           normalizedMap['non_field_errors'];

//       if (nonFieldErrors != null) {
//         final message =
//             _formatBackendError(nonFieldErrors);

//         if (message.isNotEmpty) {
//           return message;
//         }
//       }

//       const ignoredKeys = {
//         'detail',
//         'message',
//         'error',
//         'errors',
//         'non_field_errors',
//         'code',
//         'status',
//         'status_code',
//         'success',
//         'messages',
//         'data',
//       };

//       final fieldMessages = <String>[];

//       for (final entry in normalizedMap.entries) {
//         if (ignoredKeys.contains(entry.key)) {
//           continue;
//         }

//         final message = _formatBackendError(
//           entry.value,
//           fieldName: entry.key,
//         );

//         if (message.isNotEmpty) {
//           fieldMessages.add(message);
//         }
//       }

//       if (fieldMessages.isNotEmpty) {
//         return fieldMessages.toSet().join('\n');
//       }

//       for (final key in [
//         'detail',
//         'message',
//         'error',
//         'messages',
//       ]) {
//         final message = _formatBackendError(
//           normalizedMap[key],
//         );

//         if (message.isNotEmpty) {
//           return message;
//         }
//       }

//       final dataMessage = _formatBackendError(
//         normalizedMap['data'],
//       );

//       if (dataMessage.isNotEmpty) {
//         return dataMessage;
//       }

//       final fallbackMessages = <String>[];

//       for (final entry in normalizedMap.entries) {
//         final message = _formatBackendError(
//           entry.value,
//           fieldName: entry.key,
//         );

//         if (message.isNotEmpty) {
//           fallbackMessages.add(message);
//         }
//       }

//       return fallbackMessages.toSet().join('\n');
//     }

//     return value.toString().trim();
//   }

//   String _formatFieldName(String fieldName) {
//     final formatted = fieldName
//         .replaceAll('_', ' ')
//         .replaceAll('-', ' ')
//         .trim();

//     if (formatted.isEmpty) {
//       return '';
//     }

//     return '${formatted[0].toUpperCase()}'
//         '${formatted.substring(1)}';
//   }

//   String _extractExceptionMessage(
//     Object error, {
//     required String fallback,
//   }) {
//     String message = error.toString().trim();

//     while (message.startsWith('Exception:')) {
//       message = message
//           .substring('Exception:'.length)
//           .trim();
//     }

//     /*
//      * ApiService exception-এর ভেতরে JSON body থাকলে
//      * সেখান থেকেও backend message বের করবে।
//      */
//     final jsonStart = message.indexOf('{');
//     final jsonEnd = message.lastIndexOf('}');

//     if (jsonStart >= 0 && jsonEnd > jsonStart) {
//       final jsonPart = message.substring(
//         jsonStart,
//         jsonEnd + 1,
//       );

//       final backendMessage =
//           _extractErrorMessage(jsonPart);

//       if (backendMessage.isNotEmpty) {
//         return backendMessage;
//       }
//     }

//     if (message.isEmpty || message == 'null') {
//       return fallback;
//     }

//     return message;
//   }

//   @override
//   void onClose() {
//     phoneController.dispose();
//     passwordController.dispose();
//     registerNameController.dispose();
//     registerEmailController.dispose();
//     registerPhoneController.dispose();
//     registerPasswordController.dispose();
//     registerConfirmPasswordController.dispose();

//     super.onClose();
//   }
// }
import 'dart:convert';

import 'package:bellevie/app/routes/app_routes.dart';
import 'package:bellevie/app/services/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';

class AuthController extends GetxController {
  final AppApiService _apiService = AppApiService();

  static const List<String> districts = [
    'Bagerhat',
    'Bandarban',
    'Barguna',
    'Barishal',
    'Bhola',
    'Bogura',
    'Brahmanbaria',
    'Chandpur',
    'Chapainawabganj',
    'Chattogram',
    'Chuadanga',
    'Coxs Bazar',
    'Cumilla',
    'Dhaka',
    'Dinajpur',
    'Faridpur',
    'Feni',
    'Gaibandha',
    'Gazipur',
    'Gopalganj',
    'Habiganj',
    'Jamalpur',
    'Jashore',
    'Jhalokati',
    'Jhenaidah',
    'Joypurhat',
    'Khagrachhari',
    'Khulna',
    'Kishoreganj',
    'Kurigram',
    'Kushtia',
    'Lakshmipur',
    'Lalmonirhat',
    'Madaripur',
    'Magura',
    'Manikganj',
    'Meherpur',
    'Moulvibazar',
    'Munshiganj',
    'Mymensingh',
    'Naogaon',
    'Narail',
    'Narayanganj',
    'Narsingdi',
    'Natore',
    'Netrokona',
    'Nilphamari',
    'Noakhali',
    'Pabna',
    'Panchagarh',
    'Patuakhali',
    'Pirojpur',
    'Rajbari',
    'Rajshahi',
    'Rangamati',
    'Rangpur',
    'Satkhira',
    'Shariatpur',
    'Sherpur',
    'Sirajganj',
    'Sunamganj',
    'Sylhet',
    'Tangail',
    'Thakurgaon',
  ];

  final RxString selectedDistrict = ''.obs;

  final RxString selectedLoginCountryIso = 'BD'.obs;
  final RxString selectedLoginCountryCode = '+880'.obs;

  final RxString selectedForgotCountryIso = 'BD'.obs;
  final RxString selectedForgotCountryCode = '+880'.obs;

  final RxString selectedRegisterCountryIso = 'BD'.obs;
  final RxString selectedRegisterCountryCode = '+880'.obs;

  final RxBool showRegisterPasswordMismatch = false.obs;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController registerNameController =
      TextEditingController();

  final TextEditingController registerEmailController =
      TextEditingController();

  final TextEditingController registerPhoneController =
      TextEditingController();

  final TextEditingController registerPasswordController =
      TextEditingController();

  final TextEditingController registerConfirmPasswordController =
      TextEditingController();

  void validateRegisterPasswordMatch() {
    final password = registerPasswordController.text.trim();
    final confirmPassword =
        registerConfirmPasswordController.text.trim();

    showRegisterPasswordMismatch.value =
        confirmPassword.isNotEmpty && password != confirmPassword;
  }

  void clearRegistrationForm() {
    registerNameController.clear();
    registerEmailController.clear();
    registerPhoneController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();

    selectedDistrict.value = '';
    selectedRegisterCountryIso.value = 'BD';
    selectedRegisterCountryCode.value = '+880';
    showRegisterPasswordMismatch.value = false;
  }

  Future<void> login({
    required String phoneNumber,
    required String passwordText,
    required String countryCode,
  }) async {
    final phone = phoneNumber.trim();
    final password = passwordText.trim();
    final selectedCountryCode = countryCode.trim();

    if (phone.isEmpty || password.isEmpty) {
      await _showCenteredErrorDialog(
        'please_enter_phone_password'.tr,
      );
      return;
    }

    final requestBody = {
      'phone_number': '$selectedCountryCode$phone',
      'password': password,
    };

    AppLoader.show(status: 'Please wait...');

    try {
      final response = await _postToFirstAvailable(
        candidatePaths: const [
          '/api/v1/auth/login/',
          '/api/v1/auth/sign-in/',
          '/api/v1/login/',
        ],
        body: requestBody,
      );

      debugPrint(
        'Login status code => ${response.statusCode}',
      );

      debugPrint(
        'Login response body => ${response.body}',
      );

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        final backendMessage = _extractErrorMessage(
          response.body,
        );

        await _showCenteredErrorDialog(
          backendMessage.isNotEmpty
              ? backendMessage
              : 'Login failed. Please try again.',
        );

        return;
      }

      final dynamic decoded = _safeJsonDecode(
        response.body,
      );

      final access = _extractToken(
        decoded,
        [
          'access',
          'access_token',
          'token',
        ],
      );

      final refresh = _extractToken(
        decoded,
        [
          'refresh',
          'refresh_token',
        ],
      );

      if (access.isEmpty || refresh.isEmpty) {
        throw Exception(
          'Login failed. Invalid token response.',
        );
      }

      final name = _extractValue(
        decoded,
        [
          'name',
          'full_name',
        ],
      );

      final email = _extractValue(
        decoded,
        ['email'],
      );

      final district = _extractValue(
        decoded,
        ['district'],
      );

      final profilePicture = _extractValue(
        decoded,
        [
          'profile_picture',
          'profile_image',
          'avatar',
        ],
      );

      final responsePhone = _extractValue(
        decoded,
        [
          'phone_number',
          'phone',
        ],
      );

      final userPhone = responsePhone.isEmpty
          ? '$selectedCountryCode$phone'
          : responsePhone;

      await AuthService.to.login(
        access: access,
        refresh: refresh,
      );

      await AuthService.to.updateProfile(
        name: name,
        phone: userPhone,
        email: email,
        district: district,
        profilePictureUrl: profilePicture,
      );

      if (AppLoader.isShow) {
        AppLoader.dismiss();
      }

      AppLoader.showSuccess('Login successful.');

      final args = Get.arguments;

      final redirect =
          (args is Map
                  ? args['redirect'] as String?
                  : null) ??
              AuthService.to.consumePendingRedirect();

      if (redirect != null &&
          redirect.isNotEmpty &&
          redirect != Routes.LOGIN) {
        Get.offAllNamed(redirect);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      debugPrint('Login error => $e');

      final errorMessage = _extractExceptionMessage(
        e,
        fallback: 'Login failed. Please try again.',
      );

      await _showCenteredErrorDialog(errorMessage);
    }
  }

  Future<void> resetForgotPassword({
    required String phoneNumber,
    required String countryCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final rawPhone = phoneNumber.trim();
    final selectedCountryCode = countryCode.trim();
    final password = newPassword.trim();
    final confirm = confirmPassword.trim();

    final formattedPhone = rawPhone.startsWith('+')
        ? rawPhone
        : '$selectedCountryCode$rawPhone';

    if (rawPhone.isEmpty) {
      await _showCenteredErrorDialog(
        'Please enter your phone number.',
      );
      return;
    }

    if (password.isEmpty || confirm.isEmpty) {
      await _showCenteredErrorDialog(
        'Please enter new password and confirm password.',
      );
      return;
    }

    if (password != confirm) {
      await _showCenteredErrorDialog(
        'Passwords do not match.',
      );
      return;
    }

    final requestBody = {
      'confirm_password': confirm,
      'new_password': password,
      'phone_number': formattedPhone,
    };

    AppLoader.show(status: 'Please wait...');

    try {
      final response = await _postToFirstAvailable(
        candidatePaths: const [
          '/api/v1/auth/reset-password/',
          '/api/v1/auth/forgot-password/',
          '/api/v1/auth/password-reset/',
        ],
        body: requestBody,
      );

      debugPrint(
        'Reset password status code => ${response.statusCode}',
      );

      debugPrint(
        'Reset password response body => ${response.body}',
      );

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        final backendMessage = _extractErrorMessage(
          response.body,
        );

        await _showCenteredErrorDialog(
          backendMessage.isNotEmpty
              ? backendMessage
              : 'Reset password failed. Please try again.',
        );

        return;
      }

      if (AppLoader.isShow) {
        AppLoader.dismiss();
      }

      AppLoader.showSuccess(
        'Password reset successful. Please login.',
      );

      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      debugPrint('Reset password error => $e');

      final errorMessage = _extractExceptionMessage(
        e,
        fallback:
            'Reset password failed. Please try again.',
      );

      await _showCenteredErrorDialog(errorMessage);
    }
  }

  Future<void> register() async {
    final name = registerNameController.text.trim();
    final phone = registerPhoneController.text.trim();

    final countryCode =
        selectedRegisterCountryCode.value.trim();

    final email = registerEmailController.text.trim();
    final password =
        registerPasswordController.text.trim();

    final confirmPassword =
        registerConfirmPasswordController.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        selectedDistrict.value.isEmpty) {
      await _showCenteredErrorDialog(
        'please_fill_required_fields'.tr,
      );
      return;
    }

    if (password.isEmpty ||
        confirmPassword.isEmpty) {
      await _showCenteredErrorDialog(
        'please_enter_password_confirm_password'.tr,
      );
      return;
    }

    validateRegisterPasswordMatch();

    if (password != confirmPassword) {
      await _showCenteredErrorDialog(
        'passwords_do_not_match'.tr,
      );
      return;
    }

    final requestBody = {
      'password': password,
      'phone_number': '$countryCode$phone',
      'name': name,
      'email': email,
      'district': selectedDistrict.value,
    };

    AppLoader.show(status: 'Please wait...');

    try {
      final response = await _postToFirstAvailable(
        candidatePaths: const [
          '/api/v1/auth/register/',
          '/api/v1/auth/sign-up/',
          '/api/v1/register/',
        ],
        body: requestBody,
      );

      debugPrint(
        'Register status code => ${response.statusCode}',
      );

      debugPrint(
        'Register response body => ${response.body}',
      );

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        final backendMessage = _extractErrorMessage(
          response.body,
        );

        await _showCenteredErrorDialog(
          backendMessage.isNotEmpty
              ? backendMessage
              : 'Registration failed. Please try again.',
        );

        return;
      }

      final dynamic decoded = _safeJsonDecode(
        response.body,
      );

      final access = _extractToken(
        decoded,
        [
          'access',
          'access_token',
          'token',
        ],
      );

      final refresh = _extractToken(
        decoded,
        [
          'refresh',
          'refresh_token',
        ],
      );

      if (access.isNotEmpty && refresh.isNotEmpty) {
        await AuthService.to.login(
          access: access,
          refresh: refresh,
        );
      }

      await AuthService.to.updateProfile(
        name: name,
        phone: '$countryCode$phone',
        email: email,
      );

      clearRegistrationForm();

      if (AppLoader.isShow) {
        AppLoader.dismiss();
      }

      AppLoader.showSuccess(
        'registration_successful'.tr,
      );

      Get.offNamed(Routes.LOGIN);
    } catch (e) {
      debugPrint('Register error => $e');

      final errorMessage = _extractExceptionMessage(
        e,
        fallback:
            'Registration failed. Please try again.',
      );

      await _showCenteredErrorDialog(errorMessage);
    }
  }

  Future<void> _showCenteredErrorDialog(
    String message,
  ) async {
    if (AppLoader.isShow) {
      AppLoader.dismiss();

      await Future.delayed(
        const Duration(milliseconds: 150),
      );
    }

    if (Get.context == null &&
        Get.overlayContext == null) {
      AppLoader.showError(message);
      return;
    }

    if (Get.isDialogOpen ?? false) {
      Get.back();

      await Future.delayed(
        const Duration(milliseconds: 100),
      );
    }

    await Get.dialog<void>(
      AlertDialog(
        backgroundColor: Colors.white,
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titlePadding: const EdgeInsets.fromLTRB(
          24,
          24,
          24,
          0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(
          24,
          16,
          24,
          8,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          24,
          8,
          24,
          20,
        ),
        title: const Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
              size: 52,
            ),
            SizedBox(height: 12),
            Text(
              'Error',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            height: 1.4,
            color: Colors.black87,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (Get.isDialogOpen ?? false) {
                  Get.back();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF2F6FED),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8),
                ),
              ),
              child: const Text('OK'),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future<dynamic> _postToFirstAvailable({
    required List<String> candidatePaths,
    required Map<String, dynamic> body,
  }) async {
    dynamic lastResponse;

    for (final path in candidatePaths) {
      try {
        final response = await _apiService.post(
          path: path,
          body: body,
        );

        if (response.statusCode == 404 ||
            response.statusCode == 405) {
          lastResponse = response;
          continue;
        }

        return response;
      } catch (e) {
        debugPrint(
          'POST request error for $path => $e',
        );

        rethrow;
      }
    }

    if (lastResponse != null) {
      return lastResponse;
    }

    throw Exception('Request failed.');
  }

  dynamic _safeJsonDecode(String raw) {
    try {
      if (raw.trim().isEmpty) {
        return null;
      }

      return jsonDecode(raw);
    } catch (_) {
      return null;
    }
  }

  String _extractToken(
    dynamic decoded,
    List<String> keys,
  ) {
    if (decoded is! Map<String, dynamic>) {
      return '';
    }

    for (final key in keys) {
      final direct =
          (decoded[key] ?? '').toString().trim();

      if (direct.isNotEmpty) {
        return direct;
      }
    }

    final nestedUser = decoded['user'];

    if (nestedUser is Map<String, dynamic>) {
      for (final key in keys) {
        final value =
            (nestedUser[key] ?? '').toString().trim();

        if (value.isNotEmpty) {
          return value;
        }
      }
    }

    final nestedData = decoded['data'];

    if (nestedData is Map<String, dynamic>) {
      for (final key in keys) {
        final value =
            (nestedData[key] ?? '').toString().trim();

        if (value.isNotEmpty) {
          return value;
        }
      }
    }

    return '';
  }

  String _extractValue(
    dynamic decoded,
    List<String> keys,
  ) {
    if (decoded is! Map<String, dynamic>) {
      return '';
    }

    for (final key in keys) {
      final direct =
          (decoded[key] ?? '').toString().trim();

      if (direct.isNotEmpty) {
        return direct;
      }
    }

    final nestedUser = decoded['user'];

    if (nestedUser is Map<String, dynamic>) {
      for (final key in keys) {
        final value =
            (nestedUser[key] ?? '').toString().trim();

        if (value.isNotEmpty) {
          return value;
        }
      }
    }

    final nestedData = decoded['data'];

    if (nestedData is Map<String, dynamic>) {
      for (final key in keys) {
        final value =
            (nestedData[key] ?? '').toString().trim();

        if (value.isNotEmpty) {
          return value;
        }
      }
    }

    return '';
  }

  String _extractErrorMessage(
    String responseBody,
  ) {
    final rawBody = responseBody.trim();

    if (rawBody.isEmpty) {
      return '';
    }

    final dynamic decoded = _safeJsonDecode(
      rawBody,
    );

    if (decoded == null) {
      return rawBody;
    }

    return _formatBackendError(decoded).trim();
  }

  String _formatBackendError(
    dynamic value, {
    String? fieldName,
  }) {
    if (value == null) {
      return '';
    }

    if (value is String) {
      final message = value.trim();

      if (message.isEmpty) {
        return '';
      }

      if (fieldName == null ||
          fieldName.isEmpty) {
        return message;
      }

      return '${_formatFieldName(fieldName)}: '
          '$message';
    }

    if (value is num || value is bool) {
      final message = value.toString();

      if (fieldName == null ||
          fieldName.isEmpty) {
        return message;
      }

      return '${_formatFieldName(fieldName)}: '
          '$message';
    }

    if (value is List) {
      final messages = value
          .map(
            (item) => _formatBackendError(item),
          )
          .where(
            (message) => message.trim().isNotEmpty,
          )
          .toSet()
          .toList();

      if (messages.isEmpty) {
        return '';
      }

      final combinedMessage = messages.join('\n');

      if (fieldName == null ||
          fieldName.isEmpty) {
        return combinedMessage;
      }

      return '${_formatFieldName(fieldName)}: '
          '$combinedMessage';
    }

    if (value is Map) {
      final normalizedMap = <String, dynamic>{};

      value.forEach((key, item) {
        normalizedMap[key.toString()] = item;
      });

      final errors = normalizedMap['errors'];

      if (errors != null) {
        final message = _formatBackendError(errors);

        if (message.isNotEmpty) {
          return message;
        }
      }

      final nonFieldErrors =
          normalizedMap['non_field_errors'];

      if (nonFieldErrors != null) {
        final message = _formatBackendError(
          nonFieldErrors,
        );

        if (message.isNotEmpty) {
          return message;
        }
      }

      const ignoredKeys = {
        'detail',
        'message',
        'error',
        'errors',
        'non_field_errors',
        'code',
        'status',
        'status_code',
        'success',
        'messages',
        'data',
      };

      final fieldMessages = <String>[];

      for (final entry in normalizedMap.entries) {
        if (ignoredKeys.contains(entry.key)) {
          continue;
        }

        final message = _formatBackendError(
          entry.value,
          fieldName: entry.key,
        );

        if (message.isNotEmpty) {
          fieldMessages.add(message);
        }
      }

      if (fieldMessages.isNotEmpty) {
        return fieldMessages.toSet().join('\n');
      }

      for (final key in [
        'detail',
        'message',
        'error',
        'messages',
      ]) {
        final message = _formatBackendError(
          normalizedMap[key],
        );

        if (message.isNotEmpty) {
          return message;
        }
      }

      final dataMessage = _formatBackendError(
        normalizedMap['data'],
      );

      if (dataMessage.isNotEmpty) {
        return dataMessage;
      }

      final fallbackMessages = <String>[];

      for (final entry in normalizedMap.entries) {
        final message = _formatBackendError(
          entry.value,
          fieldName: entry.key,
        );

        if (message.isNotEmpty) {
          fallbackMessages.add(message);
        }
      }

      return fallbackMessages.toSet().join('\n');
    }

    return value.toString().trim();
  }

  String _formatFieldName(String fieldName) {
    final formatted = fieldName
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .trim();

    if (formatted.isEmpty) {
      return '';
    }

    return '${formatted[0].toUpperCase()}'
        '${formatted.substring(1)}';
  }

  String _extractExceptionMessage(
    Object error, {
    required String fallback,
  }) {
    String message = error.toString().trim();

    while (message.startsWith('Exception:')) {
      message = message
          .substring('Exception:'.length)
          .trim();
    }

    final jsonStart = message.indexOf('{');
    final jsonEnd = message.lastIndexOf('}');

    if (jsonStart >= 0 && jsonEnd > jsonStart) {
      final jsonPart = message.substring(
        jsonStart,
        jsonEnd + 1,
      );

      final backendMessage = _extractErrorMessage(
        jsonPart,
      );

      if (backendMessage.isNotEmpty) {
        return backendMessage;
      }
    }

    if (message.isEmpty || message == 'null') {
      return fallback;
    }

    return message;
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    super.onClose();
  }
}