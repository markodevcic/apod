import 'package:apod/utilities/constants/custom_color.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle(
      {super.key, required this.title, this.style, this.wrapAlignment});

  final String title;
  final TextStyle? style;
  final WrapAlignment? wrapAlignment;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: wrapAlignment ?? WrapAlignment.start,
      children: AnimateList(
        interval: 50.ms,
        effects: [FadeEffect(duration: 400.ms)],
        children: [
          for (var char in title.split(' '))
            if (!char.contains('\n'))
              Text(
                '$char ',
                style: style ??
                    context.textTheme.titleSmall!.copyWith(
                      color: CustomColor.lunarWhite,
                    ),
              ),
        ],
      ),
    );
  }
}
