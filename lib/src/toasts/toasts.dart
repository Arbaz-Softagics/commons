import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

toast(
  String message, {
  position = ToastPosition.bottom,
  Color backgroundColor,
  textColor: Colors.black,
  fontSize: 16.0,
  Duration duration,
}) {
  showToast(
    message,
    backgroundColor: backgroundColor,
    position: ToastPosition.bottom,
    textPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    dismissOtherToast: true,
    radius: 25,
    duration: duration,
    textStyle: TextStyle(
      color: textColor,
      fontSize: fontSize,
    ),
  );
}

successToast(String message) {
  toast(
    message,
    backgroundColor: Colors.teal.withOpacity(0.9),
    textColor: Colors.white,
  );
}

errorToast(String message) {
  toast(
    message,
    backgroundColor: Colors.red.withOpacity(0.9),
    textColor: Colors.white,
  );
}

warningToast(String message) {
  toast(
    message,
    backgroundColor: Colors.deepOrange.withOpacity(0.9),
    textColor: Colors.white,
  );
}

infoToast(String message) {
  toast(
    message,
    backgroundColor: Colors.grey[350],
    textColor: Colors.black,
  );
}
