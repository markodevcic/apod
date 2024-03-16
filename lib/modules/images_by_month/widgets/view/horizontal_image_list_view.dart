import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apod/constants/app_color.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/widgets/media/app_network_image.dart';

class HorizontalImageListView extends ConsumerWidget {
  const HorizontalImageListView({super.key, required this.images});

  final List<ImageResponse> images;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
          top: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColor.galacticPurple,
                  width: 1,
                ),
              ),
              child: Hero(
                tag: image.title!,
                child: AppNetworkImage.full(
                  image: image,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
