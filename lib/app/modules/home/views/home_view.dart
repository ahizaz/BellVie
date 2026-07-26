// import 'package:bellevie/app/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../routes/app_routes.dart';
// import '../controllers/home_controller.dart';
// import '../widgets/call_drawer.dart';
// import '../widgets/home_bottom_nav.dart';
// import '../widgets/home_tab_body.dart';
// import '../widgets/home_top_bar.dart';

// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});

//   Future<void> _onBottomNavTap(BuildContext context, int index) async {
//     if (index == 2) {
//       await showBelleVieCallDrawer(context);
//       return;
//     }

//     // Appointment tab
//     if (index == 1) {
//       final isLoggedIn = Get.find<AuthService>().authenticated;

//       if (!isLoggedIn) {
//         await Get.toNamed(Routes.LOGIN);
//         return;
//       }

//       controller.changeTab(index);
//       return;
//     }

//     // Records tab
//     if (index == 3) {
//       final isLoggedIn = Get.find<AuthService>().authenticated;

//       if (!isLoggedIn) {
//         await Get.toNamed(Routes.LOGIN);
//         return;
//       }

//       controller.changeTab(index);
//       return;
//     }

//     // My Account tab
//     if (index == 4) {
//       final isLoggedIn = Get.find<AuthService>().authenticated;

//       if (!isLoggedIn) {
//         await Get.toNamed(Routes.LOGIN);
//         return;
//       }

//       controller.changeTab(index);
//       return;
//     }

//     controller.changeTab(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       controller.currentLocale.value;

//       final activeIndex =
//           controller.tabIndex.value == 2 ? 0 : controller.tabIndex.value;

//       return Scaffold(
//         backgroundColor: const Color(0xFFF2F2F2),
//         appBar: activeIndex == 1
//             ? AppBar(
//                 automaticallyImplyLeading: false,
//                 elevation: 0,
//                 backgroundColor: Colors.white,
//                 title: const Text(
//                   'My Appointments',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 centerTitle: true,
//               )
//             : null,
//         body: SafeArea(
//           child: Column(
//             children: [
//               if (activeIndex == 0) const HomeTopBar(),
//               Expanded(child: HomeTabBody(index: activeIndex)),
//             ],
//           ),
//         ),
//         bottomNavigationBar: HomeBottomNav(
//           currentIndex: activeIndex,
//           onTap: (index) => _onBottomNavTap(context, index),
//         ),
//       );
//     });
//   }
// }
import 'package:bellevie/app/modules/home/widgets/sections/chatbot_floating_button.dart';
import 'package:bellevie/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';
import '../widgets/call_drawer.dart';

// নতুন Chatbot import


import '../widgets/home_bottom_nav.dart';
import '../widgets/home_tab_body.dart';
import '../widgets/home_top_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Future<void> _onBottomNavTap(
    BuildContext context,
    int index,
  ) async {
    // Call button
    if (index == 2) {
      await showBelleVieCallDrawer(context);
      return;
    }

    // Appointment tab
    if (index == 1) {
      final isLoggedIn = Get.find<AuthService>().authenticated;

      if (!isLoggedIn) {
        await Get.toNamed(Routes.LOGIN);
        return;
      }

      controller.changeTab(index);
      return;
    }

    // Records tab
    if (index == 3) {
      final isLoggedIn = Get.find<AuthService>().authenticated;

      if (!isLoggedIn) {
        await Get.toNamed(Routes.LOGIN);
        return;
      }

      controller.changeTab(index);
      return;
    }

    // My Account tab
    if (index == 4) {
      final isLoggedIn = Get.find<AuthService>().authenticated;

      if (!isLoggedIn) {
        await Get.toNamed(Routes.LOGIN);
        return;
      }

      controller.changeTab(index);
      return;
    }

    // Home tab
    controller.changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Language change হলে UI rebuild হবে
      controller.currentLocale.value;

      final activeIndex =
          controller.tabIndex.value == 2
              ? 0
              : controller.tabIndex.value;

      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),

        // Appointment tab-এর AppBar
        appBar: activeIndex == 1
            ? AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text(
                  'My Appointments',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
              )
            : null,

        body: SafeArea(
          // এখানে Chatbot overlay যোগ হয়েছে
          child: ChatbotFloatingOverlay(
            // শুধু Home tab-এ chatbot button দেখাবে
            show: activeIndex == 0,

            // আগের সম্পূর্ণ Home content
            child: Column(
              children: [
                // Home tab ছাড়া TopBar দেখাবে না
                if (activeIndex == 0)
                  const HomeTopBar(),

                Expanded(
                  child: HomeTabBody(
                    index: activeIndex,
                  ),
                ),
              ],
            ),
          ),
        ),

        // আগের Bottom Navigation ঠিক রাখা হয়েছে
        bottomNavigationBar: HomeBottomNav(
          currentIndex: activeIndex,
          onTap: (index) {
            _onBottomNavTap(context, index);
          },
        ),
      );
    });
  }
}