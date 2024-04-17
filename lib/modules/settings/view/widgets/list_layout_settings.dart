import 'package:apod/modules/settings/view/widgets/layout_box.dart';
import 'package:apod/modules/settings/view/widgets/layout_box_part.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListLayoutSettings extends ConsumerWidget {
  const ListLayoutSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Image List Layout', style: context.textTheme.titleMedium),
          const SizedBox(height: 16),
          const Row(
            children: [
              LayoutBox.horizontal(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LayoutBoxPart.verticalStart(),
                      SizedBox(width: 4),
                      LayoutBoxPart.verticalCenter(),
                      SizedBox(width: 4),
                      LayoutBoxPart.verticalEnd(),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              LayoutBox.vertical(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LayoutBoxPart.horizontalStart(),
                      SizedBox(height: 4),
                      LayoutBoxPart.horizontalCenter(),
                      SizedBox(height: 4),
                      LayoutBoxPart.horizontalEnd(),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
