import 'package:apod/modules/image_preview/view/image_preview_page.dart';
import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/animated/animated_ttitle.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/shared/widgets/media/app_network_image.dart';
import 'package:apod/utilities/constants/custom_color.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
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
            context.push(ImagePreviewPage(image: image));
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
                  CustomColor.deepSpaceBlack,
                  CustomColor.deepSpaceBlack.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppOutlinedButton.back(
                  useMaxContrast: false,
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
