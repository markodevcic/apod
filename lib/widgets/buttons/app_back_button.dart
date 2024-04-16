import 'package:apod/constants/app_color.dart';
import 'package:apod/providers/app_color_provider.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBackButton extends ConsumerWidget {
  const AppBackButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      onPressed: () => context.pop(),
      shape: const CircleBorder(),
      elevation: 0,
      highlightColor: AppColor.lunarWhite.withOpacity(0.3),
      color: color ?? ref.watch(appColorProvider).withOpacity(0.5),
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          Icons.keyboard_arrow_left_outlined,
          color: AppColor.lunarWhite,
        ),
      ),
    );
  }
}
