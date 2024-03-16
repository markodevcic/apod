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

class ImageOfTheDay extends ConsumerStatefulWidget {
  const ImageOfTheDay({super.key});

  @override
  ConsumerState<ImageOfTheDay> createState() => _ImageOfTheDayState();
}

class _ImageOfTheDayState extends ConsumerState<ImageOfTheDay> {
  @override
  void initState() {
    super.initState();
    ref.read(todayImageProvider.notifier).get();
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(todayImageProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'splash',
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 32,
                left: 16,
                right: 160,
              ),
              child: Animate(
                delay: 500.ms,
                effects: [
                  FadeEffect(
                    begin: 0,
                    end: 1,
                    duration: 500.ms,
                  ),
                  BlurEffect(
                    curve: Curves.easeInOut,
                    delay: 500.ms,
                    begin: const Offset(10, 10),
                    end: const Offset(0, 0),
                    duration: 1000.ms,
                  )
                ],
                child: Text(
                  'Astronomy Picture of the Day',
                  style: context.textTheme.headlineSmall!.copyWith(
                    color: AppColor.lunarWhite.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
          Animate(
            delay: 2000.ms,
            effects: [
              FadeEffect(
                begin: 0,
                end: 1,
                duration: 500.ms,
              ),
            ],
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
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
                    const SizedBox(height: 24),
                    AnimatedSwitcher(
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
                              child: Center(
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
            ),
          ),
        ],
      ),
    );
  }
}
