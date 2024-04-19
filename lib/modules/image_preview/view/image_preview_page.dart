import 'package:apod/modules/image_preview/utils/image_preview_utils.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewPage extends ConsumerWidget {
  const ImagePreviewPage({super.key, required this.image});

  final ImageResponse image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(
                image.mediaType == 'image' ? image.url! : image.thumbnailUrl!,
              ),
              heroAttributes: PhotoViewHeroAttributes(tag: image.title!),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 3,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppOutlinedButton.back(
                  onPressed: () => context.pop(),
                ),
                AppOutlinedButton(
                  icon: Icons.ios_share_outlined,
                  onPressed: () async {
                    await ImagePreviewUtils.shareImage(ref, image);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
