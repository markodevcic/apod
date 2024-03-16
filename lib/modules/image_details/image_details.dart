import 'package:flutter/material.dart';
import 'package:apod/models/image_response/image_response.dart';
import 'package:apod/modules/image_details/widgets/image_and_title.dart';
import 'package:apod/widgets/texts/animated_text.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({super.key, required this.image});

  final ImageResponse image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
