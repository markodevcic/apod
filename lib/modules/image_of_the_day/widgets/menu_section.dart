import 'package:apod/constants/app_color.dart';
import 'package:apod/modules/images_by_month/images_by_month.dart';
import 'package:apod/modules/random_images/random_images.dart';
import 'package:apod/providers/images_by_month/images_by_month_provider.dart';
import 'package:apod/providers/random_images_provider.dart';
import 'package:apod/providers/today_image_provider.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/widgets/loaders/loader.dart';
import 'package:apod/widgets/media/app_network_image.dart';
import 'package:apod/widgets/texts/animated_ttitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuSection extends ConsumerWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(todayImageProvider);

    return Animate(
      delay: 1000.ms,
      effects: [
        MoveEffect(
          duration: 500.ms,
          begin: const Offset(0, 100),
          end: const Offset(0, 0),
        ),
        FadeEffect(
          duration: 500.ms,
          begin: 0,
          end: 1,
        ),
      ],
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Align(
            alignment: orientation == Orientation.portrait
                ? Alignment.bottomCenter
                : Alignment.centerRight,
            child: Container(
              width: orientation == Orientation.portrait
                  ? double.infinity
                  : MediaQuery.of(context).size.width * 0.65,
              padding: EdgeInsets.only(
                top: orientation == Orientation.portrait ? 46 : 16,
                left: orientation == Orientation.portrait ? 16 : 64,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: orientation == Orientation.portrait
                      ? Alignment.bottomCenter
                      : Alignment.centerRight,
                  end: orientation == Orientation.portrait
                      ? Alignment.topCenter
                      : Alignment.centerLeft,
                  stops: const [0.9, 0.93, 0.96, 1.0],
                  colors: [
                    AppColor.deepSpaceBlack.withOpacity(0.6),
                    AppColor.deepSpaceBlack.withOpacity(0.4),
                    AppColor.deepSpaceBlack.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AnimatedTitle(
                    title: 'Today\'s Picture',
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: AnimatedSwitcher(
                      duration: 500.ms,
                      child: image != null
                          ? Hero(
                              tag: image.title!,
                              child: AppNetworkImage(
                                image: image,
                                height: 200,
                              ),
                            )
                          : const SizedBox(
                              height: 200,
                              child: Loader(),
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const AnimatedTitle(
                        title: 'Explore Pictures by Month',
                      ),
                      const Spacer(),
                      AppOutlinedButton(
                        onPressed: () {
                          ref.invalidate(imagesByMonthProvider);
                          context.push(const ImagesByMonth());
                        },
                        icon: Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const AnimatedTitle(
                        title: 'View Random Pictures',
                      ),
                      const Spacer(),
                      AppOutlinedButton(
                        onPressed: () {
                          ref.invalidate(randomImagesProvider);
                          context.push(const RandomImages());
                        },
                        icon: Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
