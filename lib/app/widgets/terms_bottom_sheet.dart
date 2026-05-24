import 'package:flutter/material.dart';

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
              const Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Service Role',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'BelleVie provides healthcare assistance (doctor appointments, hospital coordination, medical support). We do not provide direct medical treatment.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Patient Responsibility',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Patients must provide accurate medical information and follow doctor instructions.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Medical Disclaimer',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Treatment decisions and outcomes depend on doctors and hospitals. BelleVie is not responsible for results.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Payments',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Service charges and membership fees must be paid as per selected package. Prices may change.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Appointments',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Appointments depend on doctor availability. Cancellation/rescheduling should be informed in advance.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Privacy',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Patient information is kept confidential and shared only with relevant healthcare providers.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'International Treatment',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Visa approval, travel, and treatment costs depend on embassy and hospitals. BelleVie is not responsible for changes.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Liability',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'BelleVie is not liable for medical negligence, delays, or third-party issues.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Updates',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Terms may be updated anytime. Using services means you agree to the latest terms.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 18),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close',
                            style: TextStyle(color: Colors.black54)),
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
