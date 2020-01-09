import 'package:flutter/material.dart';

/// Navigator push function
Future<T> push<T extends Object>(BuildContext context, Widget route) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (c) => route,
    ),
  );
}

/// Navigator push replacement function
Future<T> replaceWith<T extends Object>(BuildContext context, Widget route) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (c) => route,
    ),
  );
}

/// Navigator pop function
bool pop<T extends Object>(BuildContext context, [T result]) {
  return Navigator.of(context).pop<T>(result);
}
