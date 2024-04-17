import 'package:apod/modules/home/view/widgets/today_image_sections.dart';
import 'package:apod/modules/image_list/images_by_month/providers/images_by_month_provider.dart';
import 'package:apod/modules/image_list/images_by_month/view/images_by_month_page.dart';
import 'package:apod/modules/image_list/random_images/providers/random_images_provider.dart';
import 'package:apod/modules/image_list/random_images/view/random_images.dart';
import 'package:apod/shared/widgets/buttons/app_tile.dart';
import 'package:apod/utilities/app_color_enum.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreImagesOptions extends ConsumerWidget {
  const ExploreImagesOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    AppColorTheme.deepSpaceBlack.color.withOpacity(0.6),
                    AppColorTheme.deepSpaceBlack.color.withOpacity(0.4),
                    AppColorTheme.deepSpaceBlack.color.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TodayImageSection(),
                    const SizedBox(height: 32),
                    AppTile.button(
                      title: 'Explore Pictures by Month',
                      color: AppColorTheme.deepSpaceBlack.color,
                      onTap: () {
                        ref.invalidate(imagesByMonthProvider);
                        context.push(const ImagesByMonthPage());
                      },
                    ),
                    AppTile.button(
                      title: 'View Random Pictures',
                      color: AppColorTheme.deepSpaceBlack.color,
                      onTap: () {
                        ref.invalidate(randomImagesProvider);
                        context.push(const RandomImages());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
