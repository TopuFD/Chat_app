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

  //get user last active time=======================>
  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;
    if (i == -1) return "last seen Time not available";
    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formatedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return "Last seen today at $formatedTime";
    }
    if (now.difference(time).inHours / 24.round() == 1) {
      return "Last seen yesterday at $formatedTime";
      
    }
    String munth = getMonth(time);
    return "Last seen on ${time.day} $munth on $formatedTime";
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
