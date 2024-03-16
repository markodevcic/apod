import 'package:apod/constants/initial_date.dart';

List<DateTime> getMonthsAfter1995() {
  List<DateTime> result = [];

  for (DateTime date = initialDate;
      date.isBefore(DateTime.now());
      date = DateTime(date.year, date.month + 1)) {
    result.add(date);
  }

  return result.reversed.toList();
}

List<int> yearsAfter1995() {
  List<int> years = [];
  DateTime startDate = initialDate;

  for (DateTime date = startDate;
      date.isBefore(DateTime.now());
      date = DateTime(date.year + 1)) {
    years.add(date.year);
  }

  return years.reversed.toList();
}

List<int> monthsInYear([int? year]) {
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
