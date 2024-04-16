import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/modules/images_by_month/widgets/image_date_picker/image_date_picker.dart';
import 'package:apod/modules/images_by_month/widgets/view/horizontal_image_list_view.dart';
import 'package:apod/modules/images_by_month/widgets/view/vertical_image_list_view.dart';
import 'package:apod/providers/images_by_month/images_by_month_provider.dart';
import 'package:apod/providers/images_date_provider.dart';
import 'package:apod/providers/page_list_view_provider.dart';
import 'package:apod/providers/page_storage_key_provider.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/wrappers/async_builder.dart';
import 'package:apod/widgets/wrappers/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagesByMonth extends ConsumerWidget {
  const ImagesByMonth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getImagesByMonth = ref.watch(getImagesByMonthProvider);
    final pageListViewDirection = ref.watch(pageListViewDirectionProvider);
    final date = ref.watch(imagesDateProvider);
    final pageStorageKey = ref.read(pageStorageKeyProvider);

    return PageWrapper(
      extendBodyBehindAppBar: true,
      actionWidget: const ImagesMonthPicker(),
      body: AsyncBuilder(
        await: getImagesByMonth,
        loadingMessage: 'Getting pictures for ${date.beautify()}',
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
