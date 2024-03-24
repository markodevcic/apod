import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/modules/image_details/widgets/image_and_title.dart';
import 'package:apod/modules/image_preview/image_preview.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/widgets/media/app_network_image.dart';
import 'package:apod/widgets/texts/animated_text.dart';
import 'package:apod/widgets/texts/animated_ttitle.dart';
import 'package:flutter/material.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({super.key, required this.image});

  final ImageResponse image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _ImageHeaderDelegate(
                    context: context,
                    image: image,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context).padding.bottom + 16),
                  sliver: SliverFillRemaining(
                    hasScrollBody: false,
                    child: AnimatedText(image: image),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height,
                    child: GestureDetector(
                      onTap: () {
                        context.push(ImagePreview(image: image));
                      },
                      child: Hero(
                        tag: image.title!,
                        child: AppNetworkImage(
                          image: image,
                          fit: BoxFit.fitHeight,
                          isButton: false,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppOutlinedButton.back(
                                onPressed: () => context.pop(),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AnimatedTitle(
                                  title: image.title!,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                top: 16,
                                left: 16,
                                right: 16,
                                bottom:
                                    MediaQuery.of(context).padding.bottom + 16),
                            child: AnimatedText(image: image),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _ImageHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _ImageHeaderDelegate({required this.image, required this.context});

  final ImageResponse image;
  final BuildContext context;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ImageAndTitle(image: image);
  }

  @override
  double get maxExtent => MediaQuery.of(context).size.height * 0.7;

  @override
  double get minExtent => MediaQuery.of(context).size.height * 0.3;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
