import 'dart:ui';

enum AppColor {
  deepSpaceBlack('Deep Space Black', Color(0xFF000000)),
  cosmicBlue('Cosmic Blue', Color(0xFF001F3F)),
  galacticPurple('Galactic Purple', Color(0xFF4B0082)),
  stellarTeal('Stellar Teal', Color(0xFF008080)),
  celestialIndigo('Celestial Indigo', Color(0xFF3F51B5)),
  darkMatterGray('Dark Matter Gray', Color(0xFF696969)),
  cosmicDusk('Cosmic Dusk', Color(0xFF333333));

  final String name;
  final Color color;

  const AppColor(this.name, this.color);
}
