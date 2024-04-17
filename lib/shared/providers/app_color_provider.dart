import 'package:apod/services/storage/shared_prefs.dart';
import 'package:apod/utilities/app_color_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appColorProvider = StateNotifierProvider<AppColorNotifier, Color>((ref) {
  return AppColorNotifier();
});

class AppColorNotifier extends StateNotifier<Color> {
  AppColorNotifier()
      : super(AppColorTheme.values.byName(SharedPrefs.loadAppColor()).color);

  void changeColor(Color color) {
    SharedPrefs.saveAppColor(AppColorTheme.values
        .firstWhere((appColor) => appColor.color == color)
        .name);
    state = color;
  }
}
