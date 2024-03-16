import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Debouncer({this.milliseconds = 1000});

  final int milliseconds;

  VoidCallback? action;
  Timer? _timer;

  run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
