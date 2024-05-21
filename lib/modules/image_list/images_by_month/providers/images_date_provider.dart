import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'images_date_provider.g.dart';

@riverpod
class ImagesDate extends _$ImagesDate {
  @override
  DateTime build() => DateTime(DateTime.now().year, DateTime.now().month);

  void setMonth(DateTime date) {
    state = DateTime(date.year, date.month);
  }

  void incrementMonth() {
    if (state.month == 12) {
      state = DateTime(state.year + 1, 1);
    } else {
      state = DateTime(state.year, state.month + 1);
    }
  }

  void decrementMonth() {
    if (state.month == 1) {
      state = DateTime(state.year - 1, 12);
    } else {
      state = DateTime(state.year, state.month - 1);
    }
  }
}
