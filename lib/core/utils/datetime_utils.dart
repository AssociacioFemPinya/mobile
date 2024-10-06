import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDateToHumanLanguage(DateTime date, String locale) {
    final DateFormat dateFormat = DateFormat.yMMMMd(locale);

    // Format the date
    return dateFormat.format(date);
  }
}

class DateTimeRange {
  final DateTime start;
  final DateTime end;

  DateTimeRange(this.start, this.end);

  static DateTimeRange generateDateTimeRangeForDay(DateTime day) {
    DateTime startOfDay = DateTime(day.year, day.month, day.day, 0, 0, 0, 0);
    DateTime endOfDay = DateTime(day.year, day.month, day.day, 23, 59, 59, 999);
    return DateTimeRange(startOfDay, endOfDay);
  }

  static DateTimeRange forMonth(DateTime date) {
    DateTime startOfMonth = DateTime(date.year, date.month, 1, 0, 0, 0, 0);
    DateTime endOfMonth = DateTime(
      date.year,
      date.month + 1,
      0, // The 0th day of the next month is the last day of the current month
      23,
      59,
      59,
      999,
    );
    return DateTimeRange(startOfMonth, endOfMonth);
  }
}
