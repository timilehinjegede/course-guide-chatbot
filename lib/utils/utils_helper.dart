import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UtilsHelper {
  UtilsHelper._();

  static String formatDateShort(String date, [String format]) {
    if (format == null) {
      format = 'MMMM d, y';
    }
    if (date == null || date.isEmpty) {
      return DateFormat(format).format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat(format).format(DateTime.now());
    }
    return DateFormat(format).format(datetime);
  }

  static String formatTimeMedium(String date, [String format]) {
    if (format == null) {
      format = 'H:mm:s';
    }

    if (date == null || date.isEmpty) {
      return DateFormat('$format').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('$format').format(DateTime.now());
    }
    return DateFormat('$format').format(datetime);
  }

  static String formatDateAndTime(DateTime dateTime) {
    String formattedDate =
        UtilsHelper.formatDateShort(dateTime.toString(), 'MMMM d yyyy');
    String formattedTime =
        UtilsHelper.formatTimeMedium(dateTime.toString(), 'hh:mm a');

    return formattedDate + ', ' + formattedTime;
  }

  static String getGreetingsFromTime(context) {
    var timeOfDay = MaterialLocalizations.of(context)
        .formatTimeOfDay(new TimeOfDay.now(), alwaysUse24HourFormat: true);
    var split = timeOfDay.split(new RegExp(r'(:)'));
    String hour = split[0];

    if (new RegExp(r'\b(0*([0-9]|1[01]))\b').hasMatch(hour)) {
      return "Good morning";
    } else if (new RegExp(r'\b(1[2-5])\b').hasMatch(hour)) {
      return "Good afternoon";
    } else {
      return "Good evening";
    }
  }
}
