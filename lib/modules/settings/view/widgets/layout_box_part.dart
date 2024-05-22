import 'package:apod/utilities/constants/custom_color.dart';
import 'package:flutter/material.dart';

enum LayoutDirection { vertical, horizontal }

enum LayoutAlignment { start, center, end }

class LayoutBoxPart extends StatelessWidget {
  const LayoutBoxPart.verticalStart({super.key})
      : height = 16,
        width = 70,
        direction = LayoutDirection.vertical,
        alignment = LayoutAlignment.start;
  const LayoutBoxPart.verticalCenter({super.key})
      : height = 30,
        width = 70,
        direction = LayoutDirection.vertical,
        alignment = LayoutAlignment.center;
  const LayoutBoxPart.verticalEnd({super.key})
      : height = 16,
        width = 70,
        direction = LayoutDirection.vertical,
        alignment = LayoutAlignment.end;
  const LayoutBoxPart.horizontalStart({super.key})
      : height = 70,
        width = 11,
        direction = LayoutDirection.horizontal,
        alignment = LayoutAlignment.start;
  const LayoutBoxPart.horizontalCenter({super.key})
      : height = 70,
        width = 40,
        direction = LayoutDirection.horizontal,
        alignment = LayoutAlignment.center;
  const LayoutBoxPart.horizontalEnd({super.key})
      : height = 70,
        width = 11,
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
            top: direction == LayoutDirection.vertical &&
                    alignment == LayoutAlignment.start
                ? BorderSide.none
                : const BorderSide(
                    color: CustomColor.lunarWhite,
                    width: 1,
                  ),
            bottom: direction == LayoutDirection.vertical &&
                    alignment == LayoutAlignment.end
                ? BorderSide.none
                : const BorderSide(
                    color: CustomColor.lunarWhite,
                    width: 1,
                  ),
            right: direction == LayoutDirection.horizontal &&
                    alignment == LayoutAlignment.end
                ? BorderSide.none
                : const BorderSide(
                    color: CustomColor.lunarWhite,
                    width: 1,
                  ),
            left: direction == LayoutDirection.horizontal &&
                    alignment == LayoutAlignment.start
                ? BorderSide.none
                : const BorderSide(
                    color: CustomColor.lunarWhite,
                    width: 1,
                  ),
          ),
          borderRadius: BorderRadius.only(
            topLeft: alignment == LayoutAlignment.start
                ? const Radius.circular(0)
                : const Radius.circular(8),
            topRight: direction == LayoutDirection.vertical &&
                        alignment == LayoutAlignment.start ||
                    direction == LayoutDirection.horizontal &&
                        alignment == LayoutAlignment.end
                ? const Radius.circular(0)
                : const Radius.circular(8),
            bottomLeft: direction == LayoutDirection.vertical &&
                        alignment == LayoutAlignment.end ||
                    direction == LayoutDirection.horizontal &&
                        alignment == LayoutAlignment.start
                ? const Radius.circular(0)
                : const Radius.circular(8),
            bottomRight: alignment == LayoutAlignment.end
                ? const Radius.circular(0)
                : const Radius.circular(8),
          )),
    );
  }
}
