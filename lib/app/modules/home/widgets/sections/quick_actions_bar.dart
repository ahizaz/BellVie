import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../controllers/home_controller.dart';
import '../../../../services/auth_service.dart';

class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key});

  void _openTab(int index) {
    final home = Get.find<HomeController>();
    home.changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    final items = <_QuickActionItem>[
      _QuickActionItem(
        label: 'emergency_services'.tr,
        icon: Icons.emergency,
        onTap: () => Get.toNamed(Routes.EMERGENCY_SERVICES),
      ),
      _QuickActionItem(
        label: 'contact_us'.tr,
        icon: Icons.contact_phone,
        onTap: () => Get.toNamed(Routes.CONTACT_US),
      ),
      _QuickActionItem(
        label: 'Book Appointment',
        icon: Icons.folder_shared,
        onTap: () => Get.toNamed(Routes.BOOK_APPOINTMENT),
      ),
      _QuickActionItem(
        label: 'My History',
        icon: Icons.history,
        onTap: () {
          final auth = AuthService.to;
          if (auth.authenticated) {
            _openTab(1);
          } else {
            Get.toNamed(Routes.LOGIN,
                arguments: {'redirect': '${Routes.HOME}?tab=1'});
          }
        },
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B6FD6), Color(0xFF0B8C7C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Container(
              width: 1,
              height: 40,
              color: Colors.white.withOpacity(0.25),
            );
          }
          final item = items[i ~/ 2];
          return Expanded(
            child: _QuickActionTile(item: item),
          );
        }),
      ),
    );
  }
}

class _QuickActionItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}

class _QuickActionTile extends StatelessWidget {
  final _QuickActionItem item;
  const _QuickActionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, color: Colors.white, size: 20),
              const SizedBox(height: 6),
              Text(
                item.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.5,
                  height: 1.15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
