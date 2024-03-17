import 'dart:ui';

import 'package:apod/constants/app_color.dart';
import 'package:apod/modules/images_by_month/widgets/view/horizontal_image_list_view.dart';
import 'package:apod/modules/images_by_month/widgets/view/vertical_image_list_view.dart';
import 'package:apod/providers/page_storage_key_provider.dart';
import 'package:apod/providers/random_images_provider.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/widgets/loaders/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomImages extends ConsumerStatefulWidget {
  const RandomImages({super.key});

  @override
  ConsumerState<RandomImages> createState() => _RandomPicturesState();
}

class _RandomPicturesState extends ConsumerState<RandomImages> {
  bool isVertical = true;

  @override
  void initState() {
    super.initState();
    ref.read(randomImagesProvider.notifier).get();
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(randomImagesProvider);
    final pageStorageKey = ref.read(pageStorageKeyProvider);

    return Scaffold(
      extendBodyBehindAppBar: isVertical ? true : false,
      appBar: AppBar(
        title: const Text('Random Pictures'),
        titleTextStyle: context.textTheme.titleMedium,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: AppOutlinedButton(
          icon: Icons.home_rounded,
          onPressed: () => context.pop(),
        ),
        backgroundColor: AppColor.galacticPurple.withOpacity(0.8),
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
            ? const Loader(size: 32)
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
            onPressed: () async {
              ref.invalidate(randomImagesProvider);

              pageStorageKey.updateKeys();

              await ref.read(randomImagesProvider.notifier).get();
            },
            icon: Icons.replay_circle_filled_sharp,
          ),
          const SizedBox(width: 8),
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
