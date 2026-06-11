import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showPrivacyPolicyBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Text(
                'privacy_policy'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'privacy_intro_title'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('privacy_effective_date'.tr),
                      const SizedBox(height: 12),
                      Text(
                        'privacy_welcome'.tr,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 16),

                      _privacySection(
                        title: 'privacy_info_collect'.tr,
                        body: 'privacy_info_collect_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_use_info'.tr,
                        body: 'privacy_use_info_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_sharing'.tr,
                        body: 'privacy_sharing_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_data_protection'.tr,
                        body: 'privacy_data_protection_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_medical_records'.tr,
                        body: 'privacy_medical_records_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_patient_consent'.tr,
                        body: 'privacy_patient_consent_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_cookies'.tr,
                        body: 'privacy_cookies_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_third_party'.tr,
                        body: 'privacy_third_party_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_retention'.tr,
                        body: 'privacy_retention_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_rights'.tr,
                        body: 'privacy_rights_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_changes'.tr,
                        body: 'privacy_changes_desc'.tr,
                      ),
                      _privacySection(
                        title: 'privacy_contact'.tr,
                        body: 'privacy_contact_desc'.tr,
                      ),

                      const SizedBox(height: 18),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'close'.tr,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget _privacySection({
  required String title,
  required String body,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        body,
        textAlign: TextAlign.justify,
      ),
      const SizedBox(height: 12),
    ],
  );
}