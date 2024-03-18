import 'package:apod/constants/app_color.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Hero(
        tag: 'title',
        child: Align(
          alignment: orientation == Orientation.portrait
              ? Alignment.topCenter
              : Alignment.topLeft,
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
    });
  }
}
