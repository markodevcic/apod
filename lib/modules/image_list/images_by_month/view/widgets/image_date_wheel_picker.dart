import 'package:apod/modules/image_list/images_by_month/providers/images_by_month_provider.dart';
import 'package:apod/modules/image_list/images_by_month/providers/images_date_provider.dart';
import 'package:apod/modules/image_list/shared/providers/page_storage_key_provider.dart';
import 'package:apod/shared/providers/app_color_provider.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/utilities/constants/custom_color.dart';
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
  late DateTime selectedDate = DateTime(widget.year, widget.month);

  @override
  Widget build(BuildContext context) {
    final imagesDate = ref.read(imagesDateProvider.notifier);
    final pageStorageKey = ref.read(pageStorageKeyProvider);

    return SizedBox(
      width: 168,
      child: AppOutlinedButton(
        title: DateTime(widget.year, widget.month).stringify(),
        buttonShape: ButtonShape.square,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            barrierColor: CustomColor.deepSpaceBlack.withOpacity(0.3),
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
                                      context.textTheme.bodyMedium,
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
                                  setState(() => selectedDate = datetime);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppOutlinedButton(
                                title: 'Cancel',
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              AppOutlinedButton(
                                title: 'Get Pictures',
                                onPressed: () {
                                  context.pop();
                                  imagesDate.setMonth(selectedDate);
                                  ref.invalidate(imagesByMonthProvider);
                                  pageStorageKey.updateKeys();
                                },
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
      ),
    );
  }
}
