import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:apod/constants/app_color.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/modules/image_details/image_details.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/texts/animated_ttitle.dart';
import 'package:apod/widgets/loaders/loader.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.image,
    this.height,
  })  : borderRadius = 8,
        isButton = true;

  const AppNetworkImage.noButton({
    super.key,
    required this.image,
  })  : height = 100,
        borderRadius = 8,
        isButton = false;

  const AppNetworkImage.part({
    super.key,
    required this.image,
  })  : height = 100,
        borderRadius = 8,
        isButton = true;

  const AppNetworkImage.full({
    super.key,
    required this.image,
  })  : height = null,
        borderRadius = 0,
        isButton = true;

  final ImageResponse image;
  final double? height;
  final double borderRadius;
  final bool isButton;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl:
            image.mediaType == 'image' ? image.url! : image.thumbnailUrl ?? '',
        height: height,
        placeholder: (_, __) => const Loader(),
        imageBuilder: (_, imageProvider) => Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: imageProvider,
              fit: BoxFit.fitWidth,
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
                      context.push(ImageDetails(image: image));
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
                AppColor.galacticPurple,
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.centerLeft,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.broken_image,
                    color: AppColor.galacticPurple,
                    size: 46,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedTitle(
                  title: image.mediaType == 'image'
                      ? 'Couldn\'t retrieve image'
                      : 'No preview image available',
                  style: context.textTheme.bodyMedium,
                ),
              ),
              if (isButton && image.url == null)
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.push(ImageDetails(image: image));
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
