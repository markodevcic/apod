import 'package:apod/modules/image_list/images_by_month/providers/images_by_month_provider.dart';
import 'package:apod/modules/image_list/images_by_month/providers/images_date_provider.dart';
import 'package:apod/modules/image_list/images_by_month/view/widgets/image_date_wheel_picker.dart';
import 'package:apod/modules/image_list/shared/providers/page_storage_key_provider.dart';
import 'package:apod/shared/widgets/buttons/app_outlined_buttons.dart';
import 'package:apod/utilities/constants/initial_date.dart';
import 'package:apod/utilities/debouncer.dart';
import 'package:apod/utilities/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagesMonthPicker extends ConsumerWidget {
  const ImagesMonthPicker({super.key});

  static final debouncer = Debouncer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(imagesDateProvider);
    final pageStorageKey = ref.read(pageStorageKeyProvider);

    return SizedBox(
      width: 276,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppOutlinedButton(
            icon: Icons.keyboard_arrow_left_rounded,
            isDisabled: date.isCurrentMonth(initialDate),
            buttonShape: ButtonShape.squareedRight,
            onPressed: () {
              ref.read(imagesDateProvider.notifier).decrementMonth();
              debouncer.run(() {
                ref.invalidate(imagesByMonthProvider);
                pageStorageKey.updateKeys();
              });
            },
          ),
          ImageDateWheelPicker(
            month: date.month,
            year: date.year,
          ),
          AppOutlinedButton(
            icon: Icons.keyboard_arrow_right_rounded,
            isDisabled: date.isCurrentMonth(),
            buttonShape: ButtonShape.squareedLeft,
            onPressed: () {
              ref.read(imagesDateProvider.notifier).incrementMonth();
              debouncer.run(() {
                ref.invalidate(imagesByMonthProvider);
                pageStorageKey.updateKeys();
              });
            },
          ),
        ],
      ),
    );
  }
}
