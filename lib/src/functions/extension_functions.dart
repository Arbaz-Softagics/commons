import 'package:flutter/material.dart';

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
}

extension TextEditingControllerExtension on TextEditingController {
  selectAllOnFocus(FocusNode node) {
    node.addListener(() {
      if (node.hasFocus) {
        this.selection = TextSelection(baseOffset: 0, extentOffset: this.text.trim().length);
      }
    });
  }
}

selectAllOnFocus(TextEditingController controller, FocusNode node) {
  node.addListener(() {
    if (node.hasFocus) {
      controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
    }
  });
}
