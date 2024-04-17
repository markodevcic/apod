import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTile extends ConsumerWidget {
  const AppTile({
    super.key,
    required this.title,
    this.color,
    this.isSelected = false,
    this.trailing,
    this.onTap,
  });

  const AppTile.button({
    super.key,
    required this.title,
    this.color,
    this.isSelected = false,
    this.onTap,
  }) : trailing = const Icon(Icons.chevron_right_rounded);

  final String title;
  final Color? color;
  final bool isSelected;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: color != null
            ? LinearGradient(
                colors: [
                  color!.withOpacity(0.5),
                  color!,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        highlightColor: ref.watch(appColorProvider),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                title,
                style: context.textTheme.titleSmall,
              ),
              const Spacer(),
              if (trailing != null) trailing!,
              if (isSelected) const Icon(Icons.check),
            ],
          ),
        ),
      ),
    );
  }
}
