import 'package:flutter/material.dart';

class PromotionBanner extends StatefulWidget {
  const PromotionBanner({super.key});

  @override
  State<PromotionBanner> createState() => _PromotionBannerState();
}

class _PromotionBannerState extends State<PromotionBanner> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Banner",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          ],
        ),
        SizedBox(height: 12,),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10)
          ),
        )
      ],
    );
  }
}
