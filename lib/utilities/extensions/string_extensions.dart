import 'package:intl/intl.dart';

extension DateTimeExtension on String {
  String toDate() {
    final now = DateTime.now().toLocal();
    DateFormat formatDate;

    var date = DateTime.parse(this);

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Today';
    } else if (date.year == now.year) {
      formatDate = DateFormat.MMMMd();
    } else {
      formatDate = DateFormat.yMMMMd();
    }

    var formattedDate = formatDate.format(date);

    return formattedDate;
  }

  bool isToday() {
    final now = DateTime.now().toLocal();
    var date = DateTime.parse(this);

    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }
}
