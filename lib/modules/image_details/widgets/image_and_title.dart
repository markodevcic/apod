import 'package:apod/constants/app_color.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/modules/image_preview/image_preview.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/widgets/media/app_network_image.dart';
import 'package:apod/widgets/texts/animated_ttitle.dart';
import 'package:flutter/material.dart';

class ImageAndTitle extends StatelessWidget {
  const ImageAndTitle({super.key, required this.image});

  final ImageResponse image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! > 10) {
              context.pop();
            }
          },
          onTap: () {
            context.push(ImagePreview(image: image));
          },
          child: Hero(
            tag: image.title!,
            child: AppNetworkImage.noButton(image: image),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColor.deepSpaceBlack,
                  AppColor.deepSpaceBlack.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppOutlinedButton.back(
                  onPressed: () => context.pop(),
                  color: Colors.transparent,
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
        ),
      ],
    );
  }
}
