import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/utilities/app_color_enum.dart';
import 'package:apod/utilities/extensions/color_extensions.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ToastType { success, error, neutral }

final toastProvider = Provider((ref) => ToastMessage(ref));

class ToastMessage {
  ToastMessage(this.ref);

  Ref ref;

  void success({required String message}) =>
      _show(message: message, type: ToastType.success);

  void error({required String message}) =>
      _show(message: message, type: ToastType.error);

  void _show({required String message, required ToastType type}) {
    BotToast.showNotification(
      title: (_) => Text(
        message,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          height: 1.5,
          color: type == ToastType.error
              ? AppColorTheme.spaceDustWhite.color
              : ref.read(appColorProvider).maxContrast(),
        ),
      ),
      duration: const Duration(seconds: 5),
      align: Alignment.bottomCenter,
      dismissDirections: [DismissDirection.down, DismissDirection.horizontal],
      margin: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
      onlyOne: true,
      wrapToastAnimation: (controller, _, child) => FadeTransition(
        opacity: controller.drive(CurveTween(curve: Curves.easeOut)),
        child: SlideTransition(
          position: controller.drive(
            Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: const Offset(0, 0),
            ).chain(CurveTween(curve: Curves.easeOut)),
          ),
          child: child,
        ),
      ),
      leading: (_) => Padding(
        padding: const EdgeInsets.only(left: 4, right: 8),
        child: Icon(
          type == ToastType.success
              ? Icons.check_circle
              : type == ToastType.error
                  ? Icons.warning_rounded
                  : Icons.info,
          color: ref.read(appColorProvider).maxContrast(),
        ),
      ),
      backgroundColor: type == ToastType.error
          ? AppColorTheme.cometRed.color
          : ref.read(appColorProvider),
    );
  }
}
