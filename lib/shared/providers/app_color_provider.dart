import 'package:apod/utilities/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appColorProvider = StateNotifierProvider<AppColorNotifier, Color>((ref) {
  return AppColorNotifier();
});

class AppColorNotifier extends StateNotifier<Color> {
  AppColorNotifier() : super(AppColor.galacticPurple);

  void changeColor(Color color) {
    state = color;
  }
}
