import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/widgets/notifications/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.image});

  final ImageResponse image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(
                  image.mediaType == 'image'
                      ? image.url!
                      : image.thumbnailUrl!),
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
                  onPressed: () {
                    final BaseCacheManager baseCacheManager =
                        DefaultCacheManager();

                    baseCacheManager.getFileFromCache(image.url!).then((info) {
                      info!.file.readAsBytes().then((bytes) async {
                        final ShareResult result = await Share.shareXFiles(
                          [XFile(info.file.path)],
                        );

                        if (result.status == ShareResultStatus.success) {
                          showToast(context, 'Share successful');
                        }
                      });
                    });
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
