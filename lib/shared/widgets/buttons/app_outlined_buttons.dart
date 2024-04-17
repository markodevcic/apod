import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:apod/utilities/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppOutlinedButton extends ConsumerStatefulWidget {
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
  ConsumerState<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends ConsumerState<AppOutlinedButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      colorBrightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      minWidth: 16,
      color: widget.color ?? ref.watch(appColorProvider).withOpacity(0.6),
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
              ? Text(
                  widget.title!,
                  style: context.textTheme.bodySmall!.copyWith(
                    color: ref.watch(appColorProvider).isLightColor
                        ? Colors.black
                        : Colors.white,
                  ),
                )
              : Icon(
                  widget.icon,
                  size: 20,
                  color: ref.watch(appColorProvider).isLightColor
                      ? Colors.black
                      : Colors.white,
                ),
        ),
      ),
    );
  }
}
