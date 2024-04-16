import 'package:apod/constants/initial_date.dart';
import 'package:apod/modules/images_by_month/widgets/image_date_picker/image_date_wheel_picker.dart';
import 'package:apod/providers/images_by_month/images_by_month_provider.dart';
import 'package:apod/providers/images_date_provider.dart';
import 'package:apod/providers/page_storage_key_provider.dart';
import 'package:apod/utilities/debouncer.dart';
import 'package:apod/widgets/buttons/app_outlined_buttons.dart';
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
      width: 256,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppOutlinedButton(
            onPressed: date.month == initialDate.toUtc().month &&
                    date.year == initialDate.toUtc().year
                ? null
                : () {
                    ref.read(imagesDateProvider.notifier).decrementOneMonth();
                    debouncer.run(() {
                      ref.invalidate(imagesByMonthProvider);
                      pageStorageKey.updateKeys();
                    });
                  },
            icon: Icons.keyboard_arrow_left_rounded,
          ),
          ImageDateWheelPicker(
            month: date.month,
            year: date.year,
          ),
          AppOutlinedButton(
            onPressed: date.month == DateTime.now().toUtc().month &&
                    date.year == DateTime.now().toUtc().year
                ? null
                : () {
                    ref.read(imagesDateProvider.notifier).incrementOneMonth();
                    debouncer.run(() {
                      ref.invalidate(imagesByMonthProvider);
                      pageStorageKey.updateKeys();
                    });
                  },
            icon: Icons.keyboard_arrow_right_rounded,
          ),
        ],
      ),
    );
  }
}
