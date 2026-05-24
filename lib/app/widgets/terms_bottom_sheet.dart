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
                        'Introduction',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Welcome to Bellevie (the "App") operated by Bellevie Global Health Services ("we", "us", "our"). These Terms & Conditions ("Terms") govern your use of the App and services. By downloading, installing, or using the App you agree to these Terms.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Definitions',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Service(s): Features available in the App including content and in‑app functionality.\nUser / You: Anyone who uses the App.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Service Availability',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'The App is offered worldwide. You are responsible for complying with local laws where you use the App.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Payment and In‑App Purchases',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Currently the App includes some in‑app purchases, paid features, and/or subscriptions. If paid features are offered, you will be presented with the price and purchase flow in the App. All payments are processed by the platform store (Google Play / App Store) and are subject to their terms. Refunds, billing, and other payment-related questions are handled in accordance with the platform store policies.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Acceptance of Terms',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You must be of legal age in your jurisdiction to accept these Terms. If using the App on behalf of an organization, you confirm you have authority to bind that organization.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Changes to Terms',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'We may modify these Terms. We will notify you of material changes via the App or email. Continued use after notice constitutes acceptance.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Access and Use of the App',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'License: We grant a limited, non‑exclusive, revocable license to use the App according to these Terms.\nRestrictions: You must not reverse engineer, modify, redistribute, or use the App to infringe third‑party rights.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Accounts and Registration',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You may need an account for some features. Provide accurate information and safeguard credentials. We may suspend or terminate accounts for violations.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Third‑Party Services & Ads',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'We may integrate third‑party services (analytics, ad networks). Those third parties have their own terms and privacy practices. You consent to data sharing required for these services. We are not responsible for third‑party content or services.',
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
                        'Our Privacy Policy explains how we collect, use, and disclose personal information. You must read and accept the Privacy Policy before using services that collect personal data. (Create and link a Privacy Policy at publication.)',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'User Content & Conduct',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'User Content: If you submit content, you grant us a worldwide, royalty‑free license to use it to provide the Service.\nProhibited Conduct: No illegal, defamatory, infringing, or harmful content. Do not attempt to disrupt the App or harass others.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Intellectual Property',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'All intellectual property rights in the App, designs, text, graphics, and code are owned by Bellevie Global Health Services or licensors. You receive no ownership rights.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Warranty Disclaimer',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'The App is provided "as is" without warranties of any kind. We disclaim implied warranties including merchantability, fitness for a particular purpose, and non‑infringement.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Limitation of Liability',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'To the maximum extent permitted by law, Bellevie Global Health Services will not be liable for indirect, incidental, special, consequential, or punitive damages, or for lost profits, data, or goodwill. Our aggregate liability is limited to \$50 (or the maximum allowed by applicable law).',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Indemnification',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You agree to indemnify and hold us harmless from claims arising from your violation of these Terms or misuse of the App.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Termination',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'We may suspend or terminate access for breach or legal reasons. You may stop using the App at any time. Termination does not relieve you of accrued obligations.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Governing Law & Dispute Resolution',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'These Terms are governed by the laws of Bangladesh. You accept that, while the App is available worldwide, disputes will be governed by Bangladesh law and resolved in competent Bangladeshi courts unless otherwise required by local law.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Severability',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'If a provision is unenforceable, remaining provisions remain in effect.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Contact',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Questions or notices: info.belleviebd@gmail.com',
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
