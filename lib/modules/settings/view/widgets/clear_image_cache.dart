import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:apod/modules/settings/providers/image_cache_directory_provider.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/shared/widgets/notifications/toast.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:apod/utilities/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClearImageCache extends ConsumerWidget {
  const ClearImageCache({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageCache = ref.watch(imageCacheDirectoryProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Cached Images', style: context.textTheme.titleMedium),
              const Spacer(),
              AppOutlinedButton(
                title: 'Clear',
                isDisabled: imageCache.totalSize == 0,
                useMaxContrast: imageCache.totalSize > 0,
                onPressed: () async {
                  await imageCache.clearImageCache();
                  ref
                      .read(toastProvider)
                      .success(message: 'Image cache cleared');
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Images saved in application directory',
                  style: context.textTheme.bodySmall),
              Row(
                children: [
                  Text('Total size:', style: context.textTheme.bodySmall),
                  const SizedBox(width: 8),
                  AnimatedFlipCounter(
                    value: imageCache.totalSize.formatFileSize(),
                    fractionDigits: 2, // decimal precision
                    suffix: imageCache.totalSize.formatFileSizeToString(),
                    textStyle: context.textTheme.bodySmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
