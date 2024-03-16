import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apod/constants/app_color.dart';
import 'package:apod/constants/initial_date.dart';
import 'package:apod/providers/images_by_month/images_by_month_provider.dart';
import 'package:apod/providers/images_date_provider.dart';
import 'package:apod/providers/page_storage_key_provider.dart';
import 'package:apod/utilities/extensions.dart';
import 'package:apod/utilities/helpers.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';

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

  late List<int> months = monthsInYear(widget.year);
  late List<int> years = yearsAfter1995();

  @override
  void initState() {
    super.initState();
    monthScrollController = FixedExtentScrollController(
      initialItem: monthsInYear(widget.year).indexOf(widget.month),
    );
    yearScrollController = FixedExtentScrollController(
      initialItem: yearsAfter1995().indexOf(widget.year),
    );
  }

  @override
  void didUpdateWidget(covariant ImageDateWheelPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    monthScrollController = FixedExtentScrollController(
      initialItem: monthsInYear(widget.year).indexOf(widget.month),
    );
    yearScrollController = FixedExtentScrollController(
      initialItem: yearsAfter1995().indexOf(widget.year),
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

    return AppOutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: AppColor.deepSpaceBlack.withOpacity(0.3),
          builder: (builderContext) {
            return Center(
              child: Material(
                color: AppColor.cosmicBlue.withOpacity(0.8),
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
                  width: 260,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 80,
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle:
                                  context.textTheme.titleMedium,
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.monthYear,
                            maximumYear: DateTime.now().year,
                            minimumYear: initialDate.year,
                            initialDateTime:
                                DateTime(widget.year, widget.month),
                            maximumDate: DateTime.now(),
                            minimumDate:
                                DateTime(initialDate.year, initialDate.month),
                            backgroundColor: Colors.transparent,
                            itemExtent: 30,
                            onDateTimeChanged: (datetime) {
                              ref.read(imagesDateProvider.notifier).setMonth(
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
                              months = monthsInYear(widget.year);
                              years = yearsAfter1995();
                            },
                            title: 'Cancel',
                          ),
                          AppOutlinedButton(
                            onPressed: () async {
                              context.pop();
                              final success = await ref
                                  .refresh(getImagesByMonthProvider.future);

                              if (success) {
                                pageStorageKey.updateKeys();
                              }
                            },
                            title: 'Get Pictures',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            // return StatefulBuilder(
            //   builder: (stfContext, stfSetState) {
            //     return Center(
            //       child: Material(
            //         color: AppColor.cosmicBlue.withOpacity(0.8),
            //         child: Container(
            //           decoration: const BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(32)),
            //           ),
            //           padding: const EdgeInsets.only(
            //             left: 8,
            //             right: 8,
            //             top: 16,
            //           ),
            //           width: 260,
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               SizedBox(
            //                 height: 140,
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                   children: [
            //                     Stack(
            //                       children: [
            //                         Center(
            //                           child: Container(
            //                             height: 32,
            //                             width: 120,
            //                             decoration: const BoxDecoration(
            //                               border: Border(
            //                                 top: BorderSide(
            //                                   color: AppColor.lunarWhite,
            //                                   width: 0.5,
            //                                 ),
            //                                 bottom: BorderSide(
            //                                   color: AppColor.lunarWhite,
            //                                   width: 0.5,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           width: 120,
            //                           child: ListWheelScrollView.useDelegate(
            //                             controller: monthScrollController,
            //                             childDelegate:
            //                                 ListWheelChildBuilderDelegate(
            //                               builder: (context, index) {
            //                                 final month = months[index];
            //                                 return Text(
            //                                   month.toMonth(),
            //                                   style:
            //                                       context.textTheme.titleMedium,
            //                                 );
            //                               },
            //                               childCount: months.length,
            //                             ),
            //                             itemExtent: 30,
            //                             physics:
            //                                 const FixedExtentScrollPhysics(),
            //                             overAndUnderCenterOpacity: 0.4,
            //                             diameterRatio: 1.2,
            //                             onSelectedItemChanged: (index) {
            //                               ref
            //                                   .read(dateWheelPickerProvider)
            //                                   .setMonth(months[index]);
            //                             },
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     Stack(
            //                       children: [
            //                         Center(
            //                           child: Container(
            //                             height: 32,
            //                             width: 60,
            //                             decoration: const BoxDecoration(
            //                               border: Border(
            //                                 top: BorderSide(
            //                                   color: AppColor.lunarWhite,
            //                                   width: 0.5,
            //                                 ),
            //                                 bottom: BorderSide(
            //                                   color: AppColor.lunarWhite,
            //                                   width: 0.5,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           width: 60,
            //                           child: ListWheelScrollView.useDelegate(
            //                             controller: yearScrollController,
            //                             childDelegate:
            //                                 ListWheelChildBuilderDelegate(
            //                               builder: (context, index) {
            //                                 final year = years[index];
            //                                 return Text(
            //                                   year.toString(),
            //                                   style:
            //                                       context.textTheme.titleMedium,
            //                                 );
            //                               },
            //                               childCount: years.length,
            //                             ),
            //                             itemExtent: 30,
            //                             physics:
            //                                 const FixedExtentScrollPhysics(),
            //                             overAndUnderCenterOpacity: 0.4,
            //                             diameterRatio: 1.2,
            //                             onSelectedItemChanged: (index) async {
            //                               final currentYear =
            //                                   yearsAfter1995()[index];
            //                               final previousYear = ref
            //                                   .read(dateWheelPickerProvider)
            //                                   .date
            //                                   .year;
            //                               final now = DateTime.now();

            //                               if (currentYear > previousYear &&
            //                                   currentYear == now.year) {
            //                                 if (monthScrollController
            //                                         .selectedItem >
            //                                     monthsInYear(now.year).last) {
            //                                   monthScrollController
            //                                       .animateToItem(
            //                                           months.indexOf(
            //                                               monthsInYear(now.year)
            //                                                   .last),
            //                                           duration: const Duration(
            //                                               milliseconds: 300),
            //                                           curve: Curves.easeIn);

            //                                   await Future.delayed(
            //                                       const Duration(
            //                                           milliseconds: 400));
            //                                 }

            //                                 ref
            //                                     .read(dateWheelPickerProvider)
            //                                     .setMonth(
            //                                       monthsInYear(currentYear)
            //                                           .last,
            //                                     );
            //                               }

            //                               if (currentYear < previousYear &&
            //                                   currentYear == initialDate.year) {
            //                                 if (months[monthScrollController
            //                                         .selectedItem] <
            //                                     monthsInYear(initialDate.year)
            //                                         .first) {
            //                                   monthScrollController
            //                                       .animateToItem(
            //                                           months.indexOf(
            //                                             monthsInYear(initialDate
            //                                                     .year)
            //                                                 .first,
            //                                           ),
            //                                           duration: const Duration(
            //                                               milliseconds: 300),
            //                                           curve: Curves.easeIn);

            //                                   await Future.delayed(
            //                                       const Duration(
            //                                           milliseconds: 400));
            //                                 }

            //                                 ref
            //                                     .read(dateWheelPickerProvider)
            //                                     .setMonth(
            //                                       monthsInYear(currentYear)
            //                                           .first,
            //                                     );
            //                               }

            //                               stfSetState(() {
            //                                 months = monthsInYear(years[index]);

            //                                 if (currentYear < previousYear &&
            //                                     currentYear ==
            //                                         initialDate.year) {
            //                                   if (monthsInYear()[
            //                                           monthScrollController
            //                                               .selectedItem] <=
            //                                       months.first) {
            //                                     monthScrollController
            //                                         .jumpToItem(
            //                                       0,
            //                                     );
            //                                   } else {
            //                                     monthScrollController
            //                                         .jumpToItem(
            //                                             months.indexWhere(
            //                                       (element) =>
            //                                           element ==
            //                                           monthsInYear()[
            //                                               monthScrollController
            //                                                   .selectedItem],
            //                                     ));
            //                                   }
            //                                 }

            //                                 if (currentYear > previousYear &&
            //                                     previousYear ==
            //                                         initialDate.year) {
            //                                   if (monthsInYear(
            //                                               initialDate.year)[
            //                                           monthScrollController
            //                                               .selectedItem] <
            //                                       months.last) {
            //                                     monthScrollController
            //                                         .jumpToItem(
            //                                       months.indexOf(monthsInYear(
            //                                               initialDate.year)[
            //                                           monthScrollController
            //                                               .selectedItem]),
            //                                     );
            //                                   }
            //                                 }
            //                               });

            //                               ref
            //                                   .read(dateWheelPickerProvider)
            //                                   .setYear(years[index]);
            //                             },
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               const SizedBox(height: 16),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   AppOutlinedButton(
            //                     onPressed: () {
            //                       context.pop();
            //                       months = monthsInYear(widget.year);
            //                       years = yearsAfter1995();
            //                       monthScrollController =
            //                           FixedExtentScrollController(
            //                         initialItem: months.indexOf(widget.month),
            //                       );
            //                       yearScrollController =
            //                           FixedExtentScrollController(
            //                         initialItem: years.indexOf(widget.year),
            //                       );
            //                     },
            //                     title: 'Cancel',
            //                   ),
            //                   AppOutlinedButton(
            //                     onPressed: () async {
            //                       ref
            //                           .read(monthForImagesProvider.notifier)
            //                           .setMonth(
            //                             year: years[
            //                                 yearScrollController.selectedItem],
            //                             month: months[
            //                                 monthScrollController.selectedItem],
            //                           );
            //                       context.pop();
            //                       final success = await ref
            //                           .refresh(getImagesByMonthProvider.future);

            //                       if (success) {
            //                         pageStorageKey.updateKeys();
            //                       }
            //                     },
            //                     title: 'Get Pictures',
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
          },
        );
      },
      title: selectedDate.beautify(),
    );
  }
}
