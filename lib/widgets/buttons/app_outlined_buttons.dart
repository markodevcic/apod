import 'package:flutter/material.dart';
import 'package:apod/constants/app_color.dart';

class AppOutlinedButton extends StatefulWidget {
  const AppOutlinedButton({
    super.key,
    this.title,
    this.icon,
    this.color,
    this.onPressed,
  });

  const AppOutlinedButton.back({
    super.key,
    this.onPressed,
    this.color,
  })  : title = null,
        icon = Icons.arrow_back_ios_new_outlined;

  final String? title;
  final IconData? icon;
  final Color? color;
  final Function? onPressed;

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends State<AppOutlinedButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      colorBrightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      minWidth: 16,
      textColor: AppColor.stellarViolet,
      color: widget.color ?? AppColor.galacticPurple.withOpacity(0.6),
      onPressed: isLoading || widget.onPressed == null
          ? null
          : () async {
              setState(() => isLoading = true);
              await widget.onPressed!();
              if (context.mounted) setState(() => isLoading = false);
            },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 120),
          child: widget.title != null
              ? Text(widget.title!)
              : Icon(
                  widget.icon,
                  color: AppColor.stellarViolet,
                  size: 20,
                ),
        ),
      ),
    );
  }
}
