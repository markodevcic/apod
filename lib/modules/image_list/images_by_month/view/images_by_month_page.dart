import 'package:apod/modules/image_list/images_by_month/providers/images_by_month_provider.dart';
import 'package:apod/modules/image_list/images_by_month/providers/images_date_provider.dart';
import 'package:apod/modules/image_list/images_by_month/view/widgets/image_date_picker.dart';
import 'package:apod/modules/image_list/shared/providers/page_storage_key_provider.dart';
import 'package:apod/modules/image_list/shared/widgets/horizontal_image_list_view.dart';
import 'package:apod/modules/image_list/shared/widgets/vertical_image_list_view.dart';
import 'package:apod/modules/settings/providers/image_list_view_direction_provider.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/wrappers/async_builder.dart';
import 'package:apod/shared/widgets/wrappers/page_wrapper.dart';
import 'package:apod/utilities/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagesByMonthPage extends ConsumerWidget {
  const ImagesByMonthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageListViewDirection = ref.watch(imageListViewDirectionProvider);
    final date = ref.watch(imagesDateProvider);
    final pageStorageKey = ref.read(pageStorageKeyProvider);

    return PageWrapper(
      extendBodyBehindAppBar: true,
      actionWidget: const ImagesMonthPicker(),
      body: AsyncBuilder(
        provider: imagesByMonthProvider,
        loadingText: 'Getting pictures for ${date.stringify()}',
        builder: (List<ImageResponse> images) {
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
