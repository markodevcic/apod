import 'package:apod/modules/image_list/images_by_month/providers/images_by_month_provider.dart';
import 'package:apod/modules/image_list/images_by_month/providers/images_date_provider.dart';
import 'package:apod/modules/image_list/images_by_month/view/widgets/utils/wheel_picker_helper.dart';
import 'package:apod/modules/image_list/shared/providers/page_storage_key_provider.dart';
import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/utilities/constants/app_color.dart';
import 'package:apod/utilities/constants/initial_date.dart';
import 'package:apod/utilities/extensions/build_context_extensions.dart';
import 'package:apod/utilities/extensions/date_time_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageDateWheelPicker extends ConsumerStatefulWidget {
  const ImageDateWheelPicker(
      {super.key, required this.month, required this.year});

  final int month;
  final int year;

  @override
  ConsumerState<ImageDateWheelPicker> createState() => _ImageDateWheelState();
}

class _ImageDateWheelState extends ConsumerState<ImageDateWheelPicker> {
  late FixedExtentScrollController monthScrollController;
  late FixedExtentScrollController yearScrollController;

  late List<int> months = WheelPickerHelper.monthsInYear(widget.year);
  late List<int> years = WheelPickerHelper.yearsAfter1995();

  @override
  void initState() {
    super.initState();
    monthScrollController = FixedExtentScrollController(
      initialItem:
          WheelPickerHelper.monthsInYear(widget.year).indexOf(widget.month),
    );
    yearScrollController = FixedExtentScrollController(
      initialItem: WheelPickerHelper.yearsAfter1995().indexOf(widget.year),
    );
  }

  @override
  void didUpdateWidget(covariant ImageDateWheelPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    monthScrollController = FixedExtentScrollController(
      initialItem:
          WheelPickerHelper.monthsInYear(widget.year).indexOf(widget.month),
    );
    yearScrollController = FixedExtentScrollController(
      initialItem: WheelPickerHelper.yearsAfter1995().indexOf(widget.year),
    );
  }

  @override
  void dispose() {
    monthScrollController.dispose();
    yearScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(imagesDateProvider);
    final pageStorageKey = ref.read(pageStorageKeyProvider);

    return SizedBox(
      width: 160,
      child: AppOutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            barrierColor: AppColor.deepSpaceBlack.withOpacity(0.3),
            builder: (builderContext) {
              return Center(
                child: Material(
                  color: Colors.black87,
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  child: Material(
                    color: ref.read(appColorProvider).withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 32,
                      ),
                      width: 280,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 80,
                            child: CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle:
                                      context.textTheme.bodySmall,
                                ),
                              ),
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.monthYear,
                                maximumYear: DateTime.now().year,
                                minimumYear: initialDate.year,
                                initialDateTime:
                                    DateTime(widget.year, widget.month),
                                maximumDate: DateTime.now(),
                                minimumDate: DateTime(
                                    initialDate.year, initialDate.month),
                                backgroundColor: Colors.transparent,
                                itemExtent: 30,
                                onDateTimeChanged: (datetime) {
                                  ref
                                      .read(imagesDateProvider.notifier)
                                      .setMonth(
                                        year: datetime.year,
                                        month: datetime.month,
                                      );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppOutlinedButton(
                                onPressed: () {
                                  context.pop();
                                  months = WheelPickerHelper.monthsInYear(
                                      widget.year);
                                  years = WheelPickerHelper.yearsAfter1995();
                                },
                                title: 'Cancel',
                              ),
                              AppOutlinedButton(
                                onPressed: () {
                                  context.pop();
                                  ref.invalidate(imagesByMonthProvider);
                                  pageStorageKey.updateKeys();
                                },
                                title: 'Get Pictures',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        title: selectedDate.stringify(),
      ),
    );
  }
}
