import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/home_tab_body.dart';
import '../widgets/home_top_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.currentLocale.value;
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const HomeTopBar(),
              Expanded(child: HomeTabBody(index: controller.tabIndex.value)),
            ],
          ),
        ),
        bottomNavigationBar: HomeBottomNav(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTab,
        ),
      );
    });
  }
}
