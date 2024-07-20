import 'package:intl/intl.dart';

class DatetimeUtils {
    static String formatDateToHumanLanguage(DateTime date, String locale) {
    final DateFormat dateFormat = DateFormat.yMMMMd(locale);

    // Format the date
    return dateFormat.format(date);
  }
}
