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
    final items = <Map<String, dynamic>>[
      {'icon': Icons.home_filled, 'label': 'Home'},
      {'icon': Icons.calendar_month, 'label': 'Appointment'},
      {'icon': Icons.call, 'label': 'Call'},
      {'icon': Icons.folder_copy, 'label': 'Records'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];
    const selectedColor = Color(0xFF2F6FED);
    const unselectedColor = Color(0xFF7A7A7A);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 6),
      child: SizedBox(
        height: 56,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 38,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE6EEF7), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(items.length, (i) {
                  final item = items[i];
                  final selected = i == currentIndex;
                  final isCenter = i == 2;
                  return Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () => onTap(i),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isCenter)
                              const SizedBox(height: 6)
                            else
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Icon(
                                  item['icon'] as IconData,
                                  size: selected ? 20 : 18,
                                  color:
                                      selected ? selectedColor : unselectedColor,
                                ),
                              ),
                            const SizedBox(height: 2),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 220),
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color:
                                    selected ? selectedColor : unselectedColor,
                              ),
                              child: isCenter
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        item['label'] as String,
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : Text(
                                      item['label'] as String,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                            const SizedBox(height: 0),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              height: 1,
                              width: selected && !isCenter ? 16 : 0,
                              decoration: BoxDecoration(
                                color: selectedColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: const Offset(0, -8),
                child: Material(
                  color: Colors.transparent,
                  child: InkResponse(
                    onTap: () => onTap(2),
                    radius: 28,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: selectedColor,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x332F6FED),
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        items[2]['icon'] as IconData,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavClipper extends CustomClipper<Path> {
  static const double _notchRadius = 26;
  static const double _notchDepth = 12;
  static const double _notchSmooth = 10;

  @override
  Path getClip(Size size) {
    final centerX = size.width / 2;
    final path = Path()..moveTo(0, 0);

    path.lineTo(centerX - _notchRadius - _notchSmooth, 0);
    path.quadraticBezierTo(
      centerX - _notchRadius,
      0,
      centerX - _notchRadius + 4,
      _notchDepth,
    );
    path.arcToPoint(
      Offset(centerX + _notchRadius - 4, _notchDepth),
      radius: const Radius.circular(_notchRadius),
      clockwise: false,
    );
    path.quadraticBezierTo(
      centerX + _notchRadius,
      0,
      centerX + _notchRadius + _notchSmooth,
      0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
