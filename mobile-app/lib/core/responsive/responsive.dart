import 'package:material_ui/material_ui.dart';

enum DeviceBreakpoint {
  compactMobile, // < 360
  standardMobile, // 360 - 599
  largeMobile, // 600 - 767
  tablet, // 768 - 1023
  largeTablet, // >= 1024
}

class Responsive {
  Responsive._();

  static DeviceBreakpoint breakpointOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return breakpointForWidth(width);
  }

  static DeviceBreakpoint breakpointForWidth(double width) {
    if (width < 360) return DeviceBreakpoint.compactMobile;
    if (width < 600) return DeviceBreakpoint.standardMobile;
    if (width < 768) return DeviceBreakpoint.largeMobile;
    if (width < 1024) return DeviceBreakpoint.tablet;
    return DeviceBreakpoint.largeTablet;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 768;
  }

  static bool isLargeTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 1024;
  }

  static int productGridColumns(double width) {
    if (width >= 1024) return 4;
    if (width >= 768) return 3;
    return 2;
  }

  static int categoryGridColumns(double width) {
    if (width >= 1024) return 4;
    if (width >= 768) return 3;
    return 2;
  }

  static double horizontalPadding(double width) {
    if (width >= 1024) return 32;
    if (width >= 768) return 24;
    if (width < 360) return 12;
    return 16;
  }

  static double maxContentWidth(double width) {
    if (width >= 1200) return 1140;
    return width;
  }
}
