import 'package:bellevie/app/modules/social_services/models/social_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialServiceDetailView extends StatelessWidget {
  const SocialServiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? <String, dynamic>{};
    final service =
        SocialServiceModel.fromJson(Map<String, dynamic>.from(args));

    return Scaffold(
      appBar: AppBar(
        title: Text(service.titleKey.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
                image: DecorationImage(
                  image: AssetImage(service.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              service.titleKey.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              service.descriptionKey.tr,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}