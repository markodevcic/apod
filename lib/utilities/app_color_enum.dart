import 'dart:ui';

enum AppColorTheme {
  deepSpaceBlack('Deep Space Black', Color(0xFF000000)),
  cosmicBlue('Cosmic Blue', Color(0xFF001F3F)),
  galacticPurple('Galactic Purple', Color(0xFF4B0082)),
  stellarTeal('Stellar Teal', Color(0xFF008080)),
  celestialIndigo('Celestial Indigo', Color(0xFF3F51B5)),
  darkMatterGray('Dark Matter Gray', Color(0xFF696969)),
  cosmicDusk('Cosmic Dusk', Color(0xFF333333)),
  supernovaYellow('Supernova Yellow', Color(0xFFFFD700)),
  auroraGreen('Aurora Green', Color(0xFF7FFFD4)),
  lunarSilver('Lunar Silver', Color(0xFFC0C0C0)),
  cometRed('Comet Red', Color(0xFFFF4500)),
  interstellarViolet('Interstellar Violet', Color(0xFF9400D3)),
  meteoriteGray('Meteorite Gray', Color(0xFF2F4F4F)),
  solarFlareOrange('Solar Flare Orange', Color(0xFFFFA500)),
  cosmicRayBlue('Cosmic Ray Blue', Color(0xFF4169E1)),
  pulsarPink('Pulsar Pink', Color(0xFFFF69B4)),
  lunarLandscapeGray('Lunar Landscape Gray', Color(0xFF778899)),
  galaxyGold('Galaxy Gold', Color(0xFFFFD700)),
  quasarCyan('Quasar Cyan', Color(0xFF00FFFF)),
  asteroidBrown('Asteroid Brown', Color(0xFF8B4513)),
  spaceDustWhite('Space Dust White', Color(0xFFFFF8E1));

  final String title;
  final Color color;

  const AppColorTheme(this.title, this.color);
}

extension AppColorThemeExtension on AppColorTheme {
  bool get isLightColor {
    return color.computeLuminance() > 0.5;
  }

  bool get isDarkColor {
    return color.computeLuminance() < 0.5;
  }
}
