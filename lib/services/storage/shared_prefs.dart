import 'dart:ui';

import 'package:apod/utilities/app_color_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static late SharedPreferences _instance;

  static Future initializePrefs() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future saveAppColor(Color color) async {
    final colorName = AppColorTheme.values
        .firstWhere((appColor) => appColor.color == color)
        .name;
    await _instance.setString('colorName', colorName);
  }

  static Color loadAppColor() {
    final String colorName = _instance.getString('colorName') ?? 'cosmicBlue';
    return AppColorTheme.values.byName(colorName).color;
  }

  static Future saveListViewDirection(String direction) async {
    await _instance.setString('direction', direction);
  }

  static String loadListViewDirection() {
    return _instance.getString('direction') ?? 'vertical';
  }

  static reset() {
    SharedPrefs._instance.clear();
  }
}
