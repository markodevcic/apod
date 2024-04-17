import 'package:apod/modules/image_list/shared/providers/page_list_view_provider.dart';
import 'package:apod/utilities/app_color_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LayoutBox extends ConsumerWidget {
  const LayoutBox.horizontal({super.key, required this.child})
      : direction = PageListViewDirection.horizontal;
  const LayoutBox.vertical({super.key, required this.child})
      : direction = PageListViewDirection.vertical;

  final Widget child;
  final PageListViewDirection direction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref
            .read(pageListViewDirectionProvider.notifier)
            .saveDirection(direction);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          gradient: ref.watch(pageListViewDirectionProvider) == direction
              ? LinearGradient(
                  colors: [
                    AppColorTheme.celestialIndigo.color.withOpacity(0.1),
                    AppColorTheme.celestialIndigo.color.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          border: ref.read(pageListViewDirectionProvider) == direction
              ? Border.all(
                  color: AppColorTheme.celestialIndigo.color,
                  width: 1,
                )
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
