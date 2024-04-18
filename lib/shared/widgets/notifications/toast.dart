import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

enum ToastType { success, error, neutral }

void showToastMessage(
    {required String message, ToastType? type = ToastType.success}) {
  Color color;

  switch (type) {
    case ToastType.success:
      color = Colors.green.shade800;
      break;
    case ToastType.error:
      color = Colors.red.shade800;
      break;
    case ToastType.neutral:
      color = Colors.blue.shade800;
      break;
    default:
      color = Colors.blue.shade800;
  }

  BotToast.showNotification(
    title: (_) => Text(message),
    duration: const Duration(seconds: 5),
    backgroundColor: color,
  );
}
