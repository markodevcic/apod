import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:apod/constants/app_color.dart';
import 'package:apod/utilities/extensions.dart';

void showToast(BuildContext context, String message) {
  final fToast = FToast();
  fToast.init(context);

  fToast.removeQueuedCustomToasts();

  fToast.showToast(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.galacticPurple,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        message,
        style: context.textTheme.labelMedium!.copyWith(
          color: AppColor.lunarWhite,
        ),
      ),
    ),
    toastDuration: const Duration(seconds: 5),
    positionedToastBuilder: (context, child) {
      return Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: child,
      );
    },
  );
}
