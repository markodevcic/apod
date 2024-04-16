import 'package:apod/shared/models/image_response.dart';
import 'package:apod/shared/widgets/media/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerticalImageList extends ConsumerWidget {
  const VerticalImageList({super.key, required this.images});

  final List<ImageResponse> images;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        return GridView.builder(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 4,
              right: 4,
              bottom: MediaQuery.of(context).padding.bottom + 4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final image = images[index];

            return Hero(
              tag: image.title!,
              child: AppNetworkImage(
                image: image,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      } else {
        return ListView.separated(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 4,
              right: 4,
              bottom: MediaQuery.of(context).padding.bottom + 4),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final image = images[index];

            return Hero(
              tag: image.title!,
              child: AppNetworkImage.part(
                image: image,
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 4),
        );
      }
    });
  }
}
