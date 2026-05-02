import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cardSize = MediaQuery.of(context).size.width * 0.38; // square size
    const cardRadius = 6.0;
    final iconSize = cardSize * 0.38;

    return InkWell(
      borderRadius: BorderRadius.circular(cardRadius),
      onTap: () => Get.toNamed(Routes.CONTACT_US),
      child: Container(
        width: cardSize,
        height: cardSize,
        decoration: BoxDecoration(
          color: const Color(0xFFCDEFF2),
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(color: const Color.fromARGB(255, 160, 212, 208)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 6,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: iconSize,
              height: iconSize,
              child: Image.asset(
                'assets/images/banners/contact_us_final.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'contact_us'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Icon(Icons.chevron_right, color: Colors.black, size: 22),
          ],
        ),
      ),
    );
  }
}
