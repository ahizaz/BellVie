import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color(0xFF2F6FED),
      unselectedItemColor: const Color(0xFF7A7A7A),
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'home'.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.event_note),
          label: 'my_appointments'.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: 'my_health'.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          label: 'cart'.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu),
          label: 'menu'.tr,
        ),
      ],
    );
  }
}
