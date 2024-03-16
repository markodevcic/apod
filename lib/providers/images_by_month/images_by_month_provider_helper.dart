import 'package:apod/constants/initial_date.dart';
import 'package:apod/utilities/extensions.dart';

class ImagesByMonthProviderHelper {
  static (String, String) setStarAndEndDate(DateTime selectedDate) {
    final now = DateTime.now().toUtc();

    late String startDate;
    late String endDate;

    if (selectedDate.year == now.year && selectedDate.month == now.month) {
      int year = now.year;
      int month = now.month;
      int day = now.day;

      startDate = DateTime(year, month, 1).toDate();
      endDate = DateTime(year, month, day).toDate();
    } else if (selectedDate.year == initialDate.year &&
        selectedDate.month == initialDate.month) {
      int year = initialDate.year;
      int month = initialDate.month;
      int day = initialDate.day;

      startDate = DateTime(year, month, day).toDate();
      endDate = DateTime(year, month + 1, 0).toDate();
    } else {
      startDate = DateTime(selectedDate.year, selectedDate.month, 1).toDate();
      endDate = DateTime(selectedDate.year, selectedDate.month + 1, 0).toDate();
    }

    return (startDate, endDate);
  }
}
