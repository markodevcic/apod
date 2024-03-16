import 'package:flutter/material.dart';
import 'package:apod/constants/app_color.dart';
import 'package:apod/utilities/extensions.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => context.pop(),
      shape: const CircleBorder(),
      elevation: 0,
      highlightColor: AppColor.lunarWhite.withOpacity(0.3),
      color: color ?? AppColor.galacticPurple.withOpacity(0.5),
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
