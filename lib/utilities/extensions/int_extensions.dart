import 'package:intl/intl.dart';

extension StringExtension on int {
  String toMonth() {
    DateFormat formatDate = DateFormat.MMMM();

    var formattedDate = formatDate.format(DateTime(2021, this));

    return formattedDate;
  }
}
