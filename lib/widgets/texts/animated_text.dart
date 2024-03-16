import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:apod/constants/app_color.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/media/video_webview.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({super.key, required this.image});

  final ImageResponse image;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect(duration: 500.ms)],
      delay: 400.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            image.explanation!,
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColor.lunarWhite,
            ),
          ),
          if (image.mediaType == 'video')
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: VideoWebView(
                  url: image.url!,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              'Date: ${image.date!.toDate()}',
              style: context.textTheme.bodySmall,
            ),
          ),
          if (image.copyright != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Copyright: ${image.copyright}',
                  style: context.textTheme.bodySmall),
            ),
        ],
      ),
    );
  }
}
