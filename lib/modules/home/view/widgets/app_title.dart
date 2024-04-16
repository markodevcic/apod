import 'package:apod/utilities/constants/app_color.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: 1000.ms,
      effects: [
        FadeEffect(
          duration: 500.ms,
          begin: 1,
          end: 0,
        ),
      ],
      child: OrientationBuilder(builder: (context, orientation) {
        return Hero(
          tag: 'title',
          child: Align(
            alignment: orientation == Orientation.portrait
                ? Alignment.topCenter
                : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                left: 80,
                right: orientation == Orientation.portrait
                    ? 80
                    : MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                'Astronomy Picture of the Day',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall!.copyWith(
                  color: AppColor.lunarWhite.withOpacity(0.7),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
