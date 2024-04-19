import 'package:apod/modules/settings/providers/image_list_view_direction_provider.dart';
import 'package:apod/modules/settings/view/widgets/layout_box_part.dart';
import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/utilities/app_color_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LayoutBox extends ConsumerWidget {
  const LayoutBox.horizontal({super.key})
      : direction = ImageListLayoutDirection.horizontal;
  const LayoutBox.vertical({super.key})
      : direction = ImageListLayoutDirection.vertical;

  final ImageListLayoutDirection direction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(imageListViewDirectionProvider.notifier);

    return InkWell(
      onTap: () {
        direction == ImageListLayoutDirection.horizontal
            ? notifier.setHorizontal()
            : notifier.setVertical();
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        // height: 78,
        // width: 78,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: ref.watch(imageListViewDirectionProvider) == direction
              ? LinearGradient(
                  colors: [
                    ref.watch(appColorProvider).withOpacity(0.1),
                    ref.read(appColorProvider).withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          border: ref.read(imageListViewDirectionProvider) == direction
              ? Border.all(
                  color: AppColorTheme.lunarSilver.color,
                  width: 1,
                )
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: direction == ImageListLayoutDirection.horizontal
            ? const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LayoutBoxPart.horizontalStart(),
                    SizedBox(width: 4),
                    LayoutBoxPart.horizontalCenter(),
                    SizedBox(width: 4),
                    LayoutBoxPart.horizontalEnd(),
                  ],
                ),
              )
            : const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LayoutBoxPart.verticalStart(),
                    SizedBox(height: 4),
                    LayoutBoxPart.verticalCenter(),
                    SizedBox(height: 4),
                    LayoutBoxPart.verticalEnd(),
                  ],
                ),
              ),
      ),
    );
  }
}
