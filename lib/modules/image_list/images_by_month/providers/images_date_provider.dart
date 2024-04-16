import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagesDateProvider =
    StateNotifierProvider.autoDispose<ImagesDateNotifier, DateTime>(
  (ref) => ImagesDateNotifier(ref),
);

class ImagesDateNotifier extends StateNotifier<DateTime> {
  ImagesDateNotifier(this.ref)
      : super(DateTime(DateTime.now().year, DateTime.now().month));

  Ref ref;

  void setMonth({required int year, required int month}) {
    state = state.copyWith(year: year, month: month);
  }

  void incrementOneMonth() {
    if (state.month == 12) {
      state = state.copyWith(month: 1, year: state.year + 1);
    } else {
      state = state.copyWith(month: state.month + 1);
    }
  }

  void decrementOneMonth() {
    if (state.month == 1) {
      state = state.copyWith(month: 12, year: state.year - 1);
    } else {
      state = state.copyWith(month: state.month - 1);
    }
  }
}
