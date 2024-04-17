import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/utilities/app_color_enum.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:apod/utilities/extensions/color_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorSettings extends ConsumerStatefulWidget {
  const ColorSettings({super.key});

  @override
  ConsumerState<ColorSettings> createState() => _ColorSettingsState();
}

class _ColorSettingsState extends ConsumerState<ColorSettings> {
  late final FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(
      initialItem: AppColorTheme.values
          .indexWhere((color) => color.color == ref.read(appColorProvider)),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Color', style: context.textTheme.titleMedium),
        const SizedBox(width: 32),
        Expanded(
          child: SizedBox(
            height: 80,
            child: CupertinoPicker(
              backgroundColor: Colors.transparent,
              selectionOverlay: const SizedBox.shrink(),
              itemExtent: 32,
              scrollController: scrollController,
              onSelectedItemChanged: (index) {
                ref
                    .read(appColorProvider.notifier)
                    .changeColor(AppColorTheme.values[index].color);
              },
              children: AppColorTheme.values
                  .map((color) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.color.withOpacity(0.1),
                              color.color,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            color.title,
                            style: context.textTheme.titleSmall!.copyWith(
                              color: color.color.maxContrast(),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
