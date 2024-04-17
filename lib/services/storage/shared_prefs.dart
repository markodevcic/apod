import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static late SharedPreferences _instance;

  static Future initializePrefs() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future saveAppColor(String colorName) async {
    await _instance.setString('colorName', colorName);
  }

  static String loadAppColor() {
    return _instance.getString('colorName') ?? 'cosmicBlue';
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
