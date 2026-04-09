import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PathologyTestView extends StatelessWidget {
  const PathologyTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDEFF2),
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'pathology_test_screen'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
              decoration: BoxDecoration(
                color: const Color(0xFFCDEFF2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromARGB(255, 160, 212, 208),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 8,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.72),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/amarlab.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 70),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'amar_lab'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        // SizedBox(height: 6),
                        // Text(
                        //   'pathology_test_card_subtitle'.tr,
                        //   style: TextStyle(
                        //     fontSize: 13.5,
                        //     height: 1.35,
                        //     color: Colors.black54,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Text(
            //   'available_lab'.tr,
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w800,
            //     color: Colors.black87,
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //     border: Border.all(color: const Color(0xFFE5E5E5)),
            //     boxShadow: const [
            //       BoxShadow(
            //         color: Color(0x0F000000),
            //         blurRadius: 8,
            //         offset: Offset(0, 4),
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 56,
            //         height: 56,
            //         decoration: const BoxDecoration(
            //           color: Color(0xFFCDEFF2),
            //           shape: BoxShape.circle,
            //         ),
            //         padding: const EdgeInsets.all(8),
            //         child: Image.asset(
            //           'assets/images/amarlab.png',
            //           fit: BoxFit.contain,
            //         ),
            //       ),
            //       const SizedBox(width: 12),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               'amar_lab'.tr,
            //               style: TextStyle(
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w700,
            //                 color: Colors.black87,
            //               ),
            //             ),
            //             SizedBox(height: 4),
            //             Text(
            //               'pathology_test_screen'.tr,
            //               style: TextStyle(
            //                 fontSize: 13,
            //                 height: 1.35,
            //                 color: Colors.black54,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
