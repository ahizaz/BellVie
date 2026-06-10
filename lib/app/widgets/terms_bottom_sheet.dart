
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showTermsBottomSheet(BuildContext context) {
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
                'terms_conditions'.tr,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _termsSection(
                        title: 'service_role'.tr,
                        body: 'service_role_desc'.tr,
                      ),
                      _termsSection(
                        title: 'patient_responsibility'.tr,
                        body: 'patient_responsibility_desc'.tr,
                      ),
                      _termsSection(
                        title: 'medical_disclaimer'.tr,
                        body: 'medical_disclaimer_desc'.tr,
                      ),
                      _termsSection(
                        title: 'payments'.tr,
                        body: 'payments_desc'.tr,
                      ),
                      _termsSection(
                        title: 'appointments'.tr,
                        body: 'appointments_desc'.tr,
                      ),
                      _termsSection(
                        title: 'privacy'.tr,
                        body: 'privacy_desc'.tr,
                      ),
                      _termsSection(
                        title: 'international_treatment'.tr,
                        body: 'international_treatment_desc'.tr,
                      ),
                      _termsSection(
                        title: 'liability'.tr,
                        body: 'liability_desc'.tr,
                      ),
                      _termsSection(
                        title: 'updates'.tr,
                        body: 'updates_desc'.tr,
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

Widget _termsSection({
  required String title,
  required String body,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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