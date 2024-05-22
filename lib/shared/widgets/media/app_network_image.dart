import 'package:apod/modules/image_details/image_details_page.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/animated/animated_ttitle.dart';
import 'package:apod/shared/widgets/loaders/loader.dart';
import 'package:apod/utilities/constants/custom_color.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.borderRadius = 8,
    this.isButton = true,
  });

  const AppNetworkImage.noButton({
    super.key,
    required this.image,
    this.fit,
  })  : height = 100,
        width = null,
        borderRadius = 8,
        isButton = false;

  const AppNetworkImage.part({
    super.key,
    required this.image,
    this.fit,
  })  : height = 100,
        width = null,
        borderRadius = 8,
        isButton = true;

  const AppNetworkImage.full({
    super.key,
    required this.image,
    this.fit,
  })  : height = null,
        width = null,
        borderRadius = 0,
        isButton = true;

  final ImageResponse image;
  final double? height;
  final double? width;
  final double borderRadius;
  final bool isButton;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl:
            image.mediaType == 'image' ? image.url! : image.thumbnailUrl ?? '',
        height: height,
        width: width,
        placeholder: (_, __) => const Loader(),
        imageBuilder: (_, imageProvider) => Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: imageProvider,
              fit: fit ?? BoxFit.fitWidth,
            ),
            if (image.mediaType == 'video')
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: AnimatedTitle(
                  title: 'Video',
                  style: context.textTheme.bodyMedium,
                ),
              ),
            if (image.mediaType == 'other')
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: AnimatedTitle(
                  title: 'Other',
                  style: context.textTheme.bodyMedium,
                ),
              ),
            if (isButton)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      context.push(ImageDetailsPage(image: image));
                    },
                  ),
                ),
              )
          ],
        ),
        errorWidget: (_, __, ___) => Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                CustomColor.galacticPurple,
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.centerLeft,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(
                    image.mediaType == 'image'
                        ? Icons.broken_image
                        : Icons.error_outline_rounded,
                    color: CustomColor.galacticPurple,
                    size: 46,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedTitle(
                  title: 'Couldn\'t retrieve image',
                  style: context.textTheme.bodySmall,
                ),
              ),
              if (isButton && image.url == null)
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.push(ImageDetailsPage(image: image));
                      },
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
