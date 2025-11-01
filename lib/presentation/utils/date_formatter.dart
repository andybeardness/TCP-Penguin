import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  static String format(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }
}
