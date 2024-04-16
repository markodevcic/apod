import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/modules/images_by_month/widgets/view/horizontal_image_list_view.dart';
import 'package:apod/modules/images_by_month/widgets/view/vertical_image_list_view.dart';
import 'package:apod/providers/page_list_view_provider.dart';
import 'package:apod/providers/page_storage_key_provider.dart';
import 'package:apod/providers/random_images_provider.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/widgets/wrappers/async_builder.dart';
import 'package:apod/widgets/wrappers/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomImages extends ConsumerWidget {
  const RandomImages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getRandomImages = ref.watch(getRandomImagesProvider);
    final pageListViewDirection = ref.watch(pageListViewDirectionProvider);
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
        await: getRandomImages,
        loadingMessage: 'Getting random images',
        builder: (data) {
          final images = data as List<ImageResponse>;

          return pageListViewDirection == PageListViewDirection.vertical
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
