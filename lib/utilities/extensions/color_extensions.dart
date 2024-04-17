import 'dart:math';

import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color maxContrast() {
    int reds = red, greens = green, blues = blue;

    // based on APCA™ 0.98G middle contrast BG
    const double flipYs = 0.342;
    const double trc = 2.4, Rco = 0.2126729, Gco = 0.7151522, Bco = 0.0721750;

    double ys = pow(reds / 255.0, trc) * Rco +
        pow(greens / 255.0, trc) * Gco +
        pow(blues / 255.0, trc) * Bco;

    return ys < flipYs ? Colors.white : Colors.black;
  }
}
