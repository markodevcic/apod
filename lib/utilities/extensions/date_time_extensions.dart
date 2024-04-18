import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toDate() {
    DateFormat formatDate = DateFormat('yyyy-MM-dd');

    var formattedDate = formatDate.format(this);

    return formattedDate;
  }

  DateTime toMonth() {
    DateFormat formatDate = DateFormat('MM');

    var formattedDate = formatDate.format(this);

    return DateTime(int.parse(formattedDate));
  }

  DateTime toYear() {
    DateFormat formatDate = DateFormat('yyyy');

    var formattedDate = formatDate.format(this);

    return DateTime(int.parse(formattedDate));
  }

  String stringify() {
    DateFormat formatDate = DateFormat.yMMMM();

    var formattedDate = formatDate.format(this);

    return formattedDate;
  }

  bool isCurrentMonth([DateTime? datetime]) {
    final DateTime date = datetime ?? DateTime.now().toLocal();

    return month == date.month && year == date.year;
  }
}
