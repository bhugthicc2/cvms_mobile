import 'package:intl/intl.dart';

class DateFormatter {
  static String formatFull(DateTime dateTime) {
    final datePart = DateFormat("MMMM d, y 'at' h:mm:ss a").format(dateTime);

    final offset = dateTime.timeZoneOffset;
    final hours = offset.inHours;
    final minutes = offset.inMinutes.remainder(60);

    final tzSign = hours >= 0 ? '+' : '-';
    final tzString =
        minutes == 0
            ? 'UTC$tzSign${hours.abs()}'
            : 'UTC$tzSign${hours.abs()}:${minutes.abs().toString().padLeft(2, '0')}';

    return "$datePart $tzString";
  }

  static String formatShort(DateTime dateTime) {
    return DateFormat("MMM. d, y - h:mm a").format(dateTime);
  }
}
