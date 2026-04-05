import 'package:flutter/widgets.dart';

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double w(double value, {double baseWidth = 375}) {
    return screenSize.width * value / baseWidth;
  }

  double h(double value, {double baseHeight = 812}) {
    return screenSize.height * value / baseHeight;
  }

  bool get isCompactWidth => screenSize.width < 380;
}
