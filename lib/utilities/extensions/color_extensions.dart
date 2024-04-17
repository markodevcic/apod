import 'dart:ui';

extension ColorExtension on Color {
  bool get isLightColor {
    return computeLuminance() > 0.5;
  }

  bool get isDarkColor {
    return computeLuminance() < 0.5;
  }
}
