import 'package:apod/shared/models/image_response.dart';
import 'package:apod/modules/home/providers/today_image_provider.dart';
import 'package:apod/shared/widgets/media/app_network_image.dart';
import 'package:apod/shared/widgets/animated/animated_ttitle.dart';
import 'package:apod/shared/widgets/wrappers/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodayImageSection extends ConsumerWidget {
  const TodayImageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTodayImage = ref.watch(getTodayImageProvider);

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AnimatedTitle(
            title: 'Today\'s Picture',
          ),
          const SizedBox(height: 16),
          Flexible(
            child: SizedBox(
              height: 200,
              child: AsyncBuilder(
                await: getTodayImage,
                builder: (data) {
                  final image = data as ImageResponse;

                  return Hero(
                    tag: image.title!,
                    child: AppNetworkImage(image: image),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
