import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/widgets/media/app_network_image.dart';

class VerticalImageList extends ConsumerWidget {
  const VerticalImageList({super.key, required this.images});

  final List<ImageResponse> images;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
}
