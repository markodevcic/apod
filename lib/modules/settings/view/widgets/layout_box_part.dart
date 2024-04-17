import 'package:apod/utilities/constants/app_color.dart';
import 'package:flutter/material.dart';

enum LayoutDirection { vertical, horizontal }

enum LayoutAlignment { start, center, end }

class LayoutBoxPart extends StatelessWidget {
  const LayoutBoxPart.verticalStart({super.key})
      : height = 80,
        width = 16,
        direction = LayoutDirection.vertical,
        alignment = LayoutAlignment.start;
  const LayoutBoxPart.verticalCenter({super.key})
      : height = 80,
        width = 60,
        direction = LayoutDirection.vertical,
        alignment = LayoutAlignment.center;
  const LayoutBoxPart.verticalEnd({super.key})
      : height = 80,
        width = 16,
        direction = LayoutDirection.vertical,
        alignment = LayoutAlignment.end;
  const LayoutBoxPart.horizontalStart({super.key})
      : height = 16,
        width = 80,
        direction = LayoutDirection.horizontal,
        alignment = LayoutAlignment.start;
  const LayoutBoxPart.horizontalCenter({super.key})
      : height = 40,
        width = 80,
        direction = LayoutDirection.horizontal,
        alignment = LayoutAlignment.center;
  const LayoutBoxPart.horizontalEnd({super.key})
      : height = 16,
        width = 80,
        direction = LayoutDirection.horizontal,
        alignment = LayoutAlignment.end;

  final double height;
  final double width;
  final LayoutDirection direction;
  final LayoutAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border(
          top: direction == LayoutDirection.horizontal &&
                  alignment == LayoutAlignment.start
              ? BorderSide.none
              : const BorderSide(
                  color: AppColor.lunarWhite,
                  width: 1,
                ),
          bottom: direction == LayoutDirection.horizontal &&
                  alignment == LayoutAlignment.end
              ? BorderSide.none
              : const BorderSide(
                  color: AppColor.lunarWhite,
                  width: 1,
                ),
          right: direction == LayoutDirection.vertical &&
                  alignment == LayoutAlignment.end
              ? BorderSide.none
              : const BorderSide(
                  color: AppColor.lunarWhite,
                  width: 1,
                ),
          left: direction == LayoutDirection.vertical &&
                  alignment == LayoutAlignment.start
              ? BorderSide.none
              : const BorderSide(
                  color: AppColor.lunarWhite,
                  width: 1,
                ),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
