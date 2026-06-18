
import 'package:bellevie/app/modules/social_services/data/social_services_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SocialServicesListView extends StatelessWidget {
  const SocialServicesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('social_services'.tr)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: socialServicesStatic.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.95,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (ctx, i) {
          final s = socialServicesStatic[i];

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Get.toNamed(
              Routes.SOCIAL_SERVICE_DETAIL,
              arguments: s.toJson(),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFBEE9FF),
                    Color(0xFFDFF8EF),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    s.image,
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.titleKey.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
