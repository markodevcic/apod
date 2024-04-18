import 'package:apod/modules/settings/providers/image_cache_directory_provider.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClearImageCache extends ConsumerWidget {
  const ClearImageCache({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isImageCacheEmpty = ref.watch(isImageCacheEmptyProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        children: [
          Text('Clear Image Cache', style: context.textTheme.titleMedium),
          const Spacer(),
          AppOutlinedButton(
            title: 'Clear',
            disabledWhen: isImageCacheEmpty,
            useMaxContrast: !isImageCacheEmpty,
            onPressed: () async {
              await ref
                  .read(isImageCacheEmptyProvider.notifier)
                  .clearImageCache();
            },
          ),
        ],
      ),
    );
  }
}
