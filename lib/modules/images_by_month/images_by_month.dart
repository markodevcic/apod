import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apod/constants/app_color.dart';
import 'package:apod/modules/images_by_month/widgets/image_date_picker/image_date_picker.dart';
import 'package:apod/modules/images_by_month/widgets/view/horizontal_image_list_view.dart';
import 'package:apod/modules/images_by_month/widgets/view/vertical_image_list_view.dart';
import 'package:apod/providers/images_by_month/images_by_month_provider.dart';
import 'package:apod/providers/images_date_provider.dart';
import 'package:apod/providers/page_storage_key_provider.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/widgets/loaders/loader_with_text.dart';

class ImagesByMonth extends ConsumerStatefulWidget {
  const ImagesByMonth({super.key});

  @override
  ConsumerState<ImagesByMonth> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<ImagesByMonth> {
  bool isVertical = true;

  @override
  void initState() {
    super.initState();
    ref.read(imagesByMonthProvider.notifier).get();
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(imagesByMonthProvider);
    final pageStorageKey = ref.read(pageStorageKeyProvider);
    final date = ref.watch(imagesDateProvider);

    log('loading...');

    return Scaffold(
      extendBodyBehindAppBar: isVertical ? true : false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleTextStyle: context.textTheme.titleMedium,
        elevation: 0,
        backgroundColor: AppColor.galacticPurple.withOpacity(0.8),
        leading: AppOutlinedButton(
          icon: Icons.home_rounded,
          onPressed: () => context.pop(),
        ),
        actions: const [
          ImagesMonthPicker(),
        ],
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: images == null
            ? LoaderWithText(
                text: 'Getting pictures for ${date.beautify()}',
                size: 32,
              )
            : isVertical
                ? VerticalImageList(
                    key: pageStorageKey.verticalList,
                    images: images,
                  )
                : HorizontalImageListView(
                    key: pageStorageKey.horizontalList,
                    images: images,
                  ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppOutlinedButton(
            onPressed: () {
              setState(() {
                isVertical = true;
              });
            },
            icon: Icons.view_stream_rounded,
          ),
          const SizedBox(width: 8),
          AppOutlinedButton(
            onPressed: () {
              setState(() {
                isVertical = false;
              });
            },
            icon: Icons.view_week_rounded,
          ),
        ],
      ),
    );
  }
}
