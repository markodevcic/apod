import 'package:apod/services/storage/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_color_provider.g.dart';

@riverpod
class AppColor extends _$AppColor {
  @override
  Color build() => SharedPrefs.loadAppColor();

  void changeColor(Color color) {
    SharedPrefs.saveAppColor(color);
    state = color;
  }
}
