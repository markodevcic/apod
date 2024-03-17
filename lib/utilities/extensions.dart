import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NavigationExtension on BuildContext {
  void push(Widget widget, {Duration? transitionDuration}) {
    Navigator.push(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration:
            transitionDuration ?? const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void pushReplacement(Widget widget, {Duration? transitionDuration}) {
    Navigator.pushReplacement(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration:
            transitionDuration ?? const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.decelerate;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return FadeTransition(
            opacity: tween.animate(curvedAnimation),
            child: child,
          );
        },
      ),
    );
  }

  void pop() {
    Navigator.pop(this);
  }

  bool canPop() {
    return Navigator.canPop(this);
  }

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension DateStringExtension on String {
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
}

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

  String beautify() {
    DateFormat formatDate = DateFormat.yMMMM();

    var formattedDate = formatDate.format(this);

    return formattedDate;
  }
}

extension StringExtension on int {
  String toMonth() {
    DateFormat formatDate = DateFormat.MMMM();

    var formattedDate = formatDate.format(DateTime(2021, this));

    return formattedDate;
  }
}
