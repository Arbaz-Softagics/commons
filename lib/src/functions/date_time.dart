import 'package:commons/commons.dart';
import 'package:intl/intl.dart';

class DateFormats {
  static const D_MM_YY = "d MM yy"; // 4 07 17
  static const DD_MM_YY = "dd MM yy"; // 04 07 17
  static const D_MMM_YY = "d MMM yy"; // 4 Jul 17
  static const D_MMM_YYYY = "d MMM yyyy"; // 4 Jul 2017
  static const DD_MM_YYYY = "dd MM yyyy"; // 04 07 2017
  static const DD_MMM_YY = "dd MMM yy"; // 04 Jul 17
  static const DD_MMM_YYYY = "dd MMM yyyy"; // 04 Jul 2017
  static const DD_MMMM_YY = "dd MMMM yy"; // 04 July 17
  static const DD_MMMM_YYYY = "dd MMMM yyyy"; // 04 July 2017
  static const EEE_DD_MM_YY = "EEE, dd MM yy"; // WED, 04 07 17
  static const EEE_DD_MM_YYYY = "EEE, dd MM yyyy"; // WED, 04 07 2017
  static const EEE_D_MMM_YYYY = "EEE, d MMM yyyy"; // WED, 4 Jul 2017
  static const EEE_DD_MMM_YY = "EEE, dd MMM yy"; // WED, 04 Jul 17
  static const EEE_DD_MMM_YYYY = "EEE, dd MMM yyyy"; // WED, 04 Jul 2017
  static const EEE_DD_MMMM_YYYY = "EEE, dd MMMM yyyy"; // WED, 04 July 2017

  static const SQL_DATE_FORMAT = "yyyy-MM-dd"; // 2017-07-17
  static const SQL_DATE_TIME_FORMAT =
      "yyyy-MM-dd HH:mm:ss"; // 2017-07-17 16:05:30

  static const SQL_START_DATE_FORMAT =
      "yyyy-MM-dd 00:00:00"; // 2017-07-17 16:05:30
  static const SQL_END_DATE_FORMAT =
      "yyyy-MM-dd 23:59:59"; // 2017-07-17 16:05:30
}

class TimeFormats {
  static const h_mm_a = "h:mm a"; // 2:08 AM
  static const hh_mm_a = "hh:mm a"; // 02:08 AM
  static const hh_mm_ss_a = "hh:mm:ss a"; // 02:08:30 AM
  static const hh_mm_ss_S_a = "hh:mm:ss.S a"; // 02:08:30.956 AM
  static const HH_mm = "HH:mm"; // 21:08
  static const HH_mm_ss = "HH:mm:ss"; // 21:08:30
}

class DateTimeAPI {
  static String sqlDateFormat(DateTime dateTime) {
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
  }

  static String sqlDateTimeFormat(DateTime dateTime) {
    return formatDate(
        dateTime, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
  }

  static String sqlStartDateTimeFormat(DateTime dateTime) {
    return formatDate(
        dateTime, [yyyy, '-', mm, '-', dd, ' ', '00', ':', '00', ':', '00']);
  }

  static String sqlEndDateTimeFormat(DateTime dateTime) {
    return formatDate(
        dateTime, [yyyy, '-', mm, '-', dd, ' ', '23', ':', '59', ':', '59']);
  }

  static String format(
    DateTime dateTime, {
    String stringFormat,
    List<String> listFormat,
  }) {
    if (stringFormat != null) {
      return formatFromString(dateTime, stringFormat);
    }
    if (stringFormat != null) {
      return formatDate(dateTime, listFormat);
    }
    assert(false,
        "One of format parameters (stringFormat, listFormat) is required to format");
    return "00-00-00";
  }

  static String formatFromList(DateTime dateTime, List<String> format) {
    return formatDate(dateTime, format);
  }

  static String formatFromString(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  static String formatDateOnly(DateTime dateTime, {separator: '-'}) {
    return formatDate(dateTime, [dd, separator, mm, separator, yyyy]);
  }

  static String formatTimeOnly(DateTime dateTime,
      {separator: ':', milliseconds: false}) {
    List<String> format = [hh, separator, nn, separator, ss, ' ', am];
    if (milliseconds) {
      format = [hh, separator, nn, separator, ss, ',', SSS, ' ', am];
    }
    return formatDate(dateTime, format);
  }

  static String formatDateTime(DateTime dateTime,
      {dateSeparator: '-', timeSeparator: ':', dateTimeSeparator: ' '}) {
    return formatDate(dateTime, [
      dd,
      dateSeparator,
      mm,
      dateSeparator,
      yyyy,
      dateTimeSeparator,
      hh,
      timeSeparator,
      nn,
      timeSeparator,
      ss,
      ' ',
      am
    ]);
  }

  static DateTime lastDateOfMonth() {
    DateTime now = new DateTime.now();
    return DateTime(now.year, now.month + 1, 0);
  }

  static DateTime firstDateOfMonth() {
    DateTime now = new DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  static DateTime add(DateTime dateTime, Duration duration) {
    return dateTime + duration;
  }

  static DateTime subtract(DateTime dateTime, Duration duration) {
    return dateTime - duration;
  }

  static DateTime addDay(DateTime dateTime, int days) {
    return dateTime + Duration(days: days);
  }

  static DateTime subtractDay(DateTime dateTime, int days) {
    return dateTime - Duration(days: days);
  }

  static DateTime addMonth(DateTime dateTime, int months) {
    return DateTime(dateTime.year, dateTime.month + months, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond);
  }

  static DateTime subtractMonth(DateTime dateTime, int months) {
    return DateTime(dateTime.year, dateTime.month - months, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond);
  }

  static DateTime addYear(DateTime dateTime, int years) {
    return DateTime(dateTime.year + years, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond);
  }

  static DateTime subtractYear(DateTime dateTime, int years) {
    return DateTime(dateTime.year - years, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond);
  }

  static Duration difference(DateTime firstDate, DateTime afterDate) {
    return afterDate.difference(firstDate);
  }
}
