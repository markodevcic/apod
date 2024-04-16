import 'package:apod/modules/settings/constants.dart';
import 'package:apod/providers/app_color_provider.dart';
import 'package:apod/widgets/buttons/app_tile.dart';
import 'package:apod/widgets/wrappers/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageWrapper(
      title: 'Color',
      body: SingleChildScrollView(
        child: Wrap(
            children: AppColor.values
                .map((color) => AppTile(
                      title: color.name,
                      color: color.color,
                      isSelected: ref.watch(appColorProvider) == color.color,
                      onTap: () {
                        ref
                            .read(appColorProvider.notifier)
                            .changeColor(color.color);
                      },
                    ))
                .toList()),
      ),
    );
  }
}
