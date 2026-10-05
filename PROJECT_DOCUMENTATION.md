# BelleVie Mobile App Documentation

BelleVie is a Flutter mobile application for health services, doctor discovery,
appointments, medical records, foreign treatment support, partner packages and
community-focused services.

This document describes the current implementation in this repository. It is
intended for developers, QA engineers, release managers and backend
integrators.

## 1. Project snapshot

| Item | Current implementation |
| --- | --- |
| Application | BelleVie Global Health Services |
| Framework | Flutter |
| Language | Dart |
| State management and routing | GetX |
| HTTP client | `package:http` |
| Local persistence | `shared_preferences` |
| App version | `1.0.6+21` |
| Dart constraint | `>=3.0.0 <4.0.0` |
| API base URL | `http://66.29.151.40:6060` |

The API base URL is defined in
[`lib/app/services/api_service.dart`](lib/app/services/api_service.dart).
There is also a commented local-development URL in that file. The production
endpoint currently uses plain HTTP; HTTPS should be enabled before a public
release.

## 2. Directory structure

```text
lib/
├── main.dart                         Application bootstrap
└── app/
    ├── localization/                 English and Bengali translations
    ├── modules/                      Feature modules
    │   ├── appointments/
    │   ├── auth/
    │   ├── emergency_services/
    │   ├── foreign_treatment/
    │   ├── home/
    │   ├── medical/
    │   ├── notification/
    │   ├── onboarding/
    │   ├── other_medical_service/
    │   ├── pathology_test/
    │   ├── profile/
    │   ├── social_services/
    │   └── specialist_doctors/
    ├── routes/                       GetX route declarations and middleware
    ├── services/                     API, auth and loading services
    ├── theme/                        Colors and responsive helpers
    ├── widgets/                      Shared policy and UI widgets
    └── ...
assets/
├── images/
├── images/banners/
├── images/core_four/
└── images/special doctors/
```

Feature modules generally contain `views`, `controllers`, `bindings`, `data`,
`models` and `widgets` as needed. Static-only sections, such as social
services, keep their data in the feature module rather than calling the API.

## 3. Application startup and navigation

1. [`lib/main.dart`](lib/main.dart) initializes Flutter bindings and bounds
   Flutter's image cache.
2. `AuthService` is initialized before `runApp`.
3. `BelleVieApp` creates a `GetMaterialApp`, loads translations and registers
   supported locales (`en-US` and `bn-BD`).
4. [`lib/app/routes/app_pages.dart`](lib/app/routes/app_pages.dart) maps route
   names to views and bindings.
5. [`lib/app/routes/auth_middleware.dart`](lib/app/routes/auth_middleware.dart)
   redirects unauthenticated users to login and remembers the requested route.

The initial route is the splash screen. The main route names are declared in
[`lib/app/routes/app_routes.dart`](lib/app/routes/app_routes.dart), including
home, profile, pathology, foreign treatment, doctors, appointment and
notification routes.

## 4. Feature documentation

### Authentication and profile

Relevant files:

- [`lib/app/modules/auth/controllers/auth_controller.dart`](lib/app/modules/auth/controllers/auth_controller.dart)
- [`lib/app/modules/auth/views/login_views.dart`](lib/app/modules/auth/views/login_views.dart)
- [`lib/app/modules/auth/views/regester_views.dart`](lib/app/modules/auth/views/regester_views.dart)
- [`lib/app/services/auth_service.dart`](lib/app/services/auth_service.dart)
- [`lib/app/modules/profile/controllers/profile_controller.dart`](lib/app/modules/profile/controllers/profile_controller.dart)

Supported flows include login, registration, forgot/reset password, profile
loading/updating, profile picture upload and logout. Access and refresh tokens
are persisted in `SharedPreferences`. `AuthService` also stores basic profile
fields and clears user-specific caches on logout.

The API client retries an authenticated GET once after attempting token refresh
when the backend returns `401`. Refresh endpoint candidates are documented in
the API table below.

### Home and content

The home module composes banners, popular services, partners, medical
accessories, hospital packages, doctor follow-up, emergency services and
community content.

Relevant files:

- [`lib/app/modules/home/views/home_view.dart`](lib/app/modules/home/views/home_view.dart)
- [`lib/app/modules/home/controllers/home_controller.dart`](lib/app/modules/home/controllers/home_controller.dart)
- [`lib/app/modules/home/data/slider_two_repository.dart`](lib/app/modules/home/data/slider_two_repository.dart)
- [`lib/app/modules/home/data/popular_service_repository.dart`](lib/app/modules/home/data/popular_service_repository.dart)
- [`lib/app/modules/home/data/discount_partner_repository.dart`](lib/app/modules/home/data/discount_partner_repository.dart)
- [`lib/app/modules/home/data/medical_accessories_repository.dart`](lib/app/modules/home/data/medical_accessories_repository.dart)

The chatbot UI and community/growth content are also part of the home module.
The chatbot repository is in
[`lib/app/modules/home/data/chatbot_repository.dart`](lib/app/modules/home/data/chatbot_repository.dart).

### Specialist and popular-service doctors

The specialist-doctor module provides categories, subcategories, doctor lists,
doctor details and follow-up actions. Repository code is in:

- [`lib/app/modules/specialist_doctors/data/specialist_doctors_repository.dart`](lib/app/modules/specialist_doctors/data/specialist_doctors_repository.dart)
- [`lib/app/modules/specialist_doctors/data/subcategory_repository.dart`](lib/app/modules/specialist_doctors/data/subcategory_repository.dart)
- [`lib/app/modules/specialist_doctors/controllers/specialist_doctors_controller.dart`](lib/app/modules/specialist_doctors/controllers/specialist_doctors_controller.dart)

The implementation tries compatible backend endpoint variants for some doctor
queries. Keep those fallbacks synchronized with the backend API contract.

### Appointments and payments

Appointment screens are under
[`lib/app/modules/appointments`](lib/app/modules/appointments). The flow is:

1. Select a doctor and date/time.
2. Submit an appointment.
3. Read the returned booking ID.
4. Submit payment information for that booking.
5. Review the appointment list.

The current payment screen submits a payment method and transaction reference;
it does not integrate a card/mobile-wallet SDK directly.

### Medical records

[`lib/app/modules/medical/controller/medical_controller.dart`](lib/app/modules/medical/controller/medical_controller.dart)
loads records, caches them locally, refreshes periodically and supports
deletion. The profile screen handles uploading a record document.

### Foreign treatment and hospitals

The foreign-treatment module loads countries and hospitals, supports pagination
and displays hospital details. Its binding, views and widgets are under
[`lib/app/modules/foreign_treatment`](lib/app/modules/foreign_treatment).

### Video consultation

[`lib/app/modules/profile/service/video_room_service.dart`](lib/app/modules/profile/service/video_room_service.dart)
gets the authenticated user's video room and an Agora token. The actual call
screen uses `agora_rtc_engine`; camera and microphone permissions are required.

### Static and local-only features

Social services, policy sheets, emergency contact presentation and several
community-information sections are currently UI/static-data features. They do
not have a dedicated API call in this repository unless listed in the API
inventory below.

## 5. API integration inventory

All paths below are relative to `http://66.29.151.40:6060`. The exact response
schema is defined by the backend; the table records how this Flutter client
uses each endpoint.

| Feature | Method | Endpoint | Source |
| --- | --- | --- | --- |
| Login | POST | `/api/v1/auth/login/`, fallback `/auth/sign-in/`, `/login/` | [`auth_controller.dart`](lib/app/modules/auth/controllers/auth_controller.dart) |
| Registration | POST | `/api/v1/auth/register/`, fallback `/auth/sign-up/`, `/register/` | [`auth_controller.dart`](lib/app/modules/auth/controllers/auth_controller.dart) |
| Forgot password | POST | `/api/v1/auth/forgot-password/`, fallback reset-password variants | [`auth_controller.dart`](lib/app/modules/auth/controllers/auth_controller.dart) |
| Refresh token | POST | `/api/v1/auth/token/refresh/`, `/api/v1/auth/refresh/`, `/api/v1/token/refresh/` | [`api_service.dart`](lib/app/services/api_service.dart) |
| Profile | GET/PATCH/PUT | `/api/v1/auth/profile/` | [`profile_controller.dart`](lib/app/modules/profile/controllers/profile_controller.dart) |
| Record upload | POST | `/api/v1/auth/record-documents/create/` | [`profile_controller.dart`](lib/app/modules/profile/controllers/profile_controller.dart) |
| Medical records | GET | `/api/v1/auth/record-documents/` | [`medical_controller.dart`](lib/app/modules/medical/controller/medical_controller.dart) |
| Delete medical record | DELETE | `/api/v1/auth/record-documents/{recordId}/` | [`medical_controller.dart`](lib/app/modules/medical/controller/medical_controller.dart) |
| Appointments | GET | `/api/v1/auth/appointments/` | [`appointment_list_view.dart`](lib/app/modules/appointments/views/appointment_list_view.dart) |
| Create appointment | POST | `/api/v1/auth/appointments/create/` | [`doctor_booking_view.dart`](lib/app/modules/appointments/views/doctor_booking_view.dart) |
| Submit payment | POST | `/api/v1/auth/payments/submit/` | [`appointment_payment_view.dart`](lib/app/modules/appointments/views/appointment_payment_view.dart) |
| Doctor follow-up | POST/GET | `/api/v1/auth/doctor-followups/` | [`doctor_follow_controller.dart`](lib/app/modules/home/controllers/doctor_follow_controller.dart) |
| Slider/banner one | GET | `/api/v1/slider/slider-one/`, `/{bannerId}/` | [`banner_details_page.dart`](lib/app/modules/home/widgets/sections/banner_details_page.dart) |
| Slider/banner two | GET | `/api/v1/slider/slider-two/` | [`slider_two_repository.dart`](lib/app/modules/home/data/slider_two_repository.dart) |
| Popular categories | GET | `/api/v1/popular-service/categories/` | [`popular_service_repository.dart`](lib/app/modules/home/data/popular_service_repository.dart) |
| Popular subcategories | GET | `/api/v1/popular-service/subcategories/` | [`subcategory_repository.dart`](lib/app/modules/specialist_doctors/data/subcategory_repository.dart) |
| Popular-service doctors | GET | `/api/v1/popular-service/doctors/`, with category/subcategory/page filters | [`specialist_doctors_repository.dart`](lib/app/modules/specialist_doctors/data/specialist_doctors_repository.dart) |
| Package collaborations | GET | `/api/v1/package/collaborations/`, `/{id}/` | [`discount_partner_repository.dart`](lib/app/modules/home/data/discount_partner_repository.dart) |
| Medical accessories | GET | `/api/v1/medical-accessories/categories/` | [`medical_accessories_repository.dart`](lib/app/modules/home/data/medical_accessories_repository.dart) |
| Other medical categories | GET | `/api/v1/other-medical-service/categories/` | [`category_repository.dart`](lib/app/modules/other_medical_service/data/category_repository.dart) |
| Specialist doctors | GET | `/api/v1/specialist-doctors/` and compatible category variants | [`specialist_doctors_repository.dart`](lib/app/modules/specialist_doctors/data/specialist_doctors_repository.dart) |
| Generic doctors | GET | `/api/v1/doctors/`, `/api/v1/doctors/specialist/` | [`specialist_doctors_repository.dart`](lib/app/modules/specialist_doctors/data/specialist_doctors_repository.dart) |
| Foreign-treatment countries | GET | `/api/v1/foreign-treatments/countries/` | [`foreign_treatment_view.dart`](lib/app/modules/foreign_treatment/views/foreign_treatment_view.dart) |
| Foreign-treatment hospitals | GET | `/api/v1/foreign-treatments/countries/{countryId}/hospitals/?page={page}` | [`hospital_list_widgets.dart`](lib/app/modules/foreign_treatment/widgets/hospital_list_widgets.dart) |
| Foreign-treatment legacy list | GET | `/api/v1/foreign-treatments/` | [`bangladehi_hospital_controller.dart`](lib/app/modules/home/controllers/bangladehi_hospital_controller.dart) |
| Notifications/quotes | GET/PATCH | `/api/v1/notifications/quote-wiserd/`, `/{id}/` | [`home_controller.dart`](lib/app/modules/home/controllers/home_controller.dart) |
| My video rooms | GET | `/api/v1/video-rooms/rooms/my-rooms/` | [`video_room_service.dart`](lib/app/modules/profile/service/video_room_service.dart) |
| Agora room token | GET | `/api/v1/video-rooms/rooms/{roomId}/token/` | [`video_room_service.dart`](lib/app/modules/profile/service/video_room_service.dart) |

### API client behavior

[`AppApiService`](lib/app/services/api_service.dart) provides JSON `GET`,
`POST`, `PATCH`, multipart `PUT`, URL construction and image URL resolution.
GET responses use:

- in-memory cache for 30 seconds;
- `SharedPreferences` persistence for offline hydration;
- request de-duplication for simultaneous identical GETs;
- cached response fallback on socket, timeout or client errors.

Most authenticated requests add an `Authorization` header. The source masks
token values in debug logs; do not add raw tokens to logs or documentation.

## 6. Dependencies and why they are used

Declared in [`pubspec.yaml`](pubspec.yaml):

| Package | Purpose |
| --- | --- |
| `get` | State management, dependency injection and navigation |
| `http` | REST and multipart network calls |
| `shared_preferences` | Tokens, profile data and cache persistence |
| `flutter_easyloading` | Loading/success/error feedback |
| `country_picker` | Country and dialing-code selection |
| `image_picker` | Profile/document image selection |
| `cached_network_image` | Network image loading and caching |
| `url_launcher` | External links, phone and email actions |
| `agora_rtc_engine` | Video consultation |
| `permission_handler` | Runtime permissions |
| `speech_to_text` | Voice input |
| `flutter_tts` | Text-to-speech |
| `flutter_markdown_plus` | Markdown content rendering |
| `flutter_localizations` | Flutter localization delegates |

## 7. Local development

### Requirements

- Flutter SDK compatible with Dart `3.0.0` or newer in the `3.x` range.
- Android Studio/Android SDK for Android builds.
- Xcode and CocoaPods for iOS builds on macOS.
- A reachable BelleVie backend, or a local backend configured by changing
  `AppApiService.baseUrl`.

### Run

```bash
flutter pub get
flutter analyze
flutter run
```

### Build

```bash
flutter build apk --debug
flutter build apk --release
flutter build appbundle --release
```

The Android release build requires `android/key.properties` and the configured
release keystore. Do not commit passwords, signing properties or keystore
material to GitHub. The Gradle configuration intentionally fails the release
build when `android/key.properties` is missing.

## 8. Platform permissions and configuration

Android declares internet, camera and microphone permissions in
[`android/app/src/main/AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml).
iOS declares photo-library access in
[`ios/Runner/Info.plist`](ios/Runner/Info.plist). Review platform permission
messages whenever a new plugin or user flow is added.

The following features require runtime permission handling:

- video calls: camera and microphone;
- profile/document images: photo library/camera as applicable;
- voice features: microphone;
- external phone/email/browser actions: platform intent availability.

## 9. Testing and release checklist

- Run `flutter analyze`.
- Test login, logout, token expiry and redirect-to-original-route.
- Test API offline/cache behavior and empty/error responses.
- Test appointment creation, booking ID handling and payment submission.
- Test record upload, refresh and deletion.
- Test Android camera, microphone, photo and notification-related behavior.
- Verify the backend URL is correct and uses HTTPS.
- Verify release signing configuration without committing secrets.
- Test both `en-US` and `bn-BD` UI paths.
- Check that no access token, password or private backend data is present in
  logs, screenshots or release artifacts.

## 10. Known implementation notes

- Some authentication and doctor endpoints have compatibility fallbacks. These
  should be removed or consolidated once the backend contract is stable.
- Several screens catch request errors and show user-facing messages; when
  changing backend response schemas, update the parsing code and corresponding
  error states together.
- API base URL is currently hard-coded. Environment-specific configuration
  (`--dart-define`, flavors or a secure config service) is recommended for
  development, staging and production.
- The repository contains generated/build output locally in some environments;
  only source, assets and required project configuration should be committed.

## 11. Useful source links

- [API service](lib/app/services/api_service.dart)
- [Authentication service](lib/app/services/auth_service.dart)
- [Routes](lib/app/routes/app_pages.dart)
- [Authentication controller](lib/app/modules/auth/controllers/auth_controller.dart)
- [Home module](lib/app/modules/home)
- [Appointments module](lib/app/modules/appointments)
- [Profile module](lib/app/modules/profile)
- [Specialist doctors module](lib/app/modules/specialist_doctors)
- [Foreign treatment module](lib/app/modules/foreign_treatment)
