import 'package:apod/modules/image_list/random_images/providers/random_images_provider.dart';
import 'package:apod/modules/image_list/shared/providers/page_storage_key_provider.dart';
import 'package:apod/modules/image_list/shared/widgets/horizontal_image_list_view.dart';
import 'package:apod/modules/image_list/shared/widgets/vertical_image_list_view.dart';
import 'package:apod/modules/settings/providers/image_list_view_direction_provider.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/shared/widgets/wrappers/async_builder.dart';
import 'package:apod/shared/widgets/wrappers/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomImages extends ConsumerWidget {
  const RandomImages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageListViewDirection = ref.watch(imageListViewDirectionProvider);
    final pageStorageKey = ref.read(pageStorageKeyProvider);

    return PageWrapper(
      extendBodyBehindAppBar: true,
      actionWidget: AppOutlinedButton(
        onPressed: () async {
          ref.invalidate(randomImagesProvider);
          pageStorageKey.updateKeys();
        },
        icon: Icons.replay_circle_filled_sharp,
      ),
      body: AsyncBuilder(
        provider: getRandomImagesProvider,
        loadingText: 'Getting random images',
        builder: (data) {
          final images = data as List<ImageResponse>;

          return pageListViewDirection == ImageListLayoutDirection.vertical
              ? VerticalImageList(
                  key: pageStorageKey.verticalList,
                  images: images,
                )
              : HorizontalImageListView(
                  key: pageStorageKey.horizontalList,
                  images: images,
                );
        },
      ),
    );
  }
}
