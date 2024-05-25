import 'package:flutter/material.dart';

class MyDateUtil {
  // getting formated time=============
  static String getFormatedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  // getting chating last time=============
  static String getlastChatTime(
      {required BuildContext context, required String time}) {
    final DateTime sendTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();
    if (now.day == sendTime.day &&
        now.month == sendTime.month &&
        now.year == sendTime.year) {
      return TimeOfDay.fromDateTime(sendTime).format(context);
    }
    return "${sendTime.day} ${getMonth(sendTime)}";
  }

  static String getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return "jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Agu";
      case 9:
        return "Sept";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
    return "NA";
  }
}
