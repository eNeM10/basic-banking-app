import 'package:intl/intl.dart';

String formatTimeSecond(DateTime dateTime) {
  return DateFormat('ss').format(dateTime);
}

String formatTimeMinute(DateTime dateTime) {
  return DateFormat('mm').format(dateTime);
}

String formatTimeHour(DateTime dateTime) {
  return DateFormat('h').format(dateTime);
}

String formatTimeHourMin(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}

String formatDay(DateTime dateTime) {
  return DateFormat('EEEE').format(dateTime);
}

String formatDateDayMonth(DateTime dateTime) {
  return DateFormat('MMMM d').format(dateTime);
}

String formatDateDayMonthYear(DateTime dateTime) {
  return DateFormat('MMMM d, y').format(dateTime);
}

String getTransactionTime(DateTime dateTime) {
  if (formatDateDayMonthYear(dateTime) ==
      formatDateDayMonthYear(DateTime.now())) {
    return formatTimeHourMin(dateTime);
  } else if (dateTime.year == DateTime.now().year) {
    return formatDateDayMonth(dateTime);
  } else {
    return formatDateDayMonthYear(dateTime);
  }
}
