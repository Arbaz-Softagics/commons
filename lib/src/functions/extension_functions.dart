import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// String extension functions
extension StringExtensions on String {
  String toCapitalize() {
    var text = this.trim();
    if (text.length == 0) return text;
    if (text.length == 1) return text.toUpperCase();
    return text[0].toUpperCase() + text.substring(1);
  }

  String toTitleCase() {
    var text = this.trim();
    if (text.length == 0) return text;
    if (text.length == 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ').trim();
  }

  int toInt({int defaultValue = 0}) {
    return int.tryParse(this.trim()) ?? defaultValue;
  }

  double toDouble({double defaultValue = 0.0}) {
    return double.tryParse(this.trim()) ?? defaultValue;
  }
}

/// TextEditingController extension functions
extension TextEditingControllerExtension on TextEditingController {
  selectAllOnFocus(FocusNode node) {
    node.addListener(() {
      if (node.hasFocus) {
        this.selection =
            TextSelection(baseOffset: 0, extentOffset: this.text.trim().length);
      }
    });
  }

  String getText({String defaultText = ""}) {
    String value = this.text.trim();
    return value.isEmpty ? defaultText : value;
  }

  int getInt({int defaultInteger = 0}) {
    String value = this.text.trim();
    return value.isEmpty
        ? defaultInteger
        : int.tryParse(value) ?? defaultInteger;
  }

  double getDouble({double defaultDouble = 0.0}) {
    String value = this.text.trim();
    return value.isEmpty
        ? defaultDouble
        : double.tryParse(value) ?? defaultDouble;
  }
}

/// select all text on focus
selectAllOnFocus(TextEditingController controller, FocusNode node) {
  node.addListener(() {
    if (node.hasFocus) {
      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: controller.text.length);
    }
  });
}

/// datetime extension functions
extension DateTimeExtension on DateTime {
  String toDateString({separator: '-'}) {
    return formatDate(this, [dd, separator, mm, separator, yyyy]);
  }

  String toTimeString({separator: ':'}) {
    return formatDate(this, [hh, separator, nn, separator, ss, ' ', am]);
  }

  String toTimeWithMillisecondsString({separator: ':'}) {
    return formatDate(
        this, [hh, separator, nn, separator, ss, ',', SSS, ' ', am]);
  }

  String toDateTimeString(
      {dateSeparator: '-', timeSeparator: ':', dateTimeSeparator: ' '}) {
    return formatDate(this, [
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

  String toDateTimeWithMillisecondsString(
      {dateSeparator: '-', timeSeparator: ':', dateTimeSeparator: ' '}) {
    return formatDate(this, [
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
      ',',
      SSS,
      ' ',
      am
    ]);
  }

  DateTime lastDateOfMonth() {
    return DateTime(this.year, this.month + 1, 0);
  }

  DateTime firstDateOfMonth() {
    return DateTime(this.year, this.month, 1);
  }

  String format(
      {format: "${DateFormats.DD_MM_YYYY} ${TimeFormats.hh_mm_ss_a}"}) {
    return DateFormat(format).format(this);
  }
}

/// double extension functions
extension DoubleExtension on double {
  String format({format: "#,###.00"}) {
    return NumberFormat(format, 'en_US').format(this);
  }
}

/// int extension functions
extension IntExtension on int {
  String format({format: "#,###"}) {
    return NumberFormat(format, 'en_US').format(this);
  }
}
