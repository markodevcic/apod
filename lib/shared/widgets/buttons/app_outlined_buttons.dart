import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:apod/utilities/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ButtonShape { rounded, square, squareedRight, squareedLeft }

class AppOutlinedButton extends ConsumerStatefulWidget {
  const AppOutlinedButton({
    super.key,
    this.title,
    this.icon,
    this.color,
    required this.onPressed,
    this.buttonShape = ButtonShape.rounded,
    this.disabledWhen = false,
    this.useMaxContrast = true,
  });

  const AppOutlinedButton.back({
    super.key,
    required this.onPressed,
    this.color,
    this.buttonShape = ButtonShape.rounded,
    this.useMaxContrast = true,
    this.disabledWhen = false,
  })  : title = null,
        icon = Icons.arrow_back_ios_new_outlined;

  final String? title;
  final IconData? icon;
  final Color? color;
  final Function onPressed;
  final ButtonShape buttonShape;
  final bool useMaxContrast;
  final bool disabledWhen;

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
        borderRadius: BorderRadius.only(
          topLeft: widget.buttonShape == ButtonShape.squareedLeft ||
                  widget.buttonShape == ButtonShape.square
              ? const Radius.circular(0)
              : const Radius.circular(32),
          bottomLeft: widget.buttonShape == ButtonShape.squareedLeft ||
                  widget.buttonShape == ButtonShape.square
              ? const Radius.circular(0)
              : const Radius.circular(32),
          topRight: widget.buttonShape == ButtonShape.squareedRight ||
                  widget.buttonShape == ButtonShape.square
              ? const Radius.circular(0)
              : const Radius.circular(32),
          bottomRight: widget.buttonShape == ButtonShape.squareedRight ||
                  widget.buttonShape == ButtonShape.square
              ? const Radius.circular(0)
              : const Radius.circular(32),
        ),
      ),
      minWidth: 16,
      color: widget.color ?? ref.watch(appColorProvider).withOpacity(0.6),
      onPressed: isLoading || widget.disabledWhen
          ? null
          : () async {
              setState(() => isLoading = true);
              await widget.onPressed();
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
                    color: widget.useMaxContrast
                        ? ref.watch(appColorProvider).maxContrast()
                        : null,
                  ),
                )
              : Icon(
                  widget.icon,
                  size: 20,
                  color: widget.disabledWhen
                      ? ref.watch(appColorProvider).maxContrast()
                      : null,
                ),
        ),
      ),
    );
  }
}
