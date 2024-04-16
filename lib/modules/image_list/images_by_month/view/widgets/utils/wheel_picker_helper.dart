import 'package:apod/utilities/constants/initial_date.dart';

class WheelPickerHelper {
  static List<int> yearsAfter1995() {
    List<int> years = [];
    DateTime startDate = initialDate;

    for (DateTime date = startDate;
        date.isBefore(DateTime.now());
        date = DateTime(date.year + 1)) {
      years.add(date.year);
    }

    return years.reversed.toList();
  }

  static List<int> monthsInYear([int? year]) {
    List<int> months = [];

    if (year == initialDate.year) {
      for (int month = initialDate.month; month <= 12; month++) {
        months.add(month);
      }
    } else if (year == DateTime.now().year) {
      for (int month = 1; month <= DateTime.now().month; month++) {
        months.add(month);
      }
    } else {
      for (int month = 1; month <= 12; month++) {
        months.add(month);
      }
    }

    return months;
  }
}
