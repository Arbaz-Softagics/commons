import 'package:flutter/material.dart';

delay(Duration duration, Function fun) {
  Future.delayed(duration, () {
    fun();
  });
}

Widget highlightTitleTextWidget(
  BuildContext context,
  String string,
  String word, {
  TextStyle stringStyle,
  TextStyle wordStyle,
}) {
  if (stringStyle == null) {
    stringStyle = const TextStyle(color: Colors.black, fontSize: 16);
  }

  if (wordStyle == null) {
    wordStyle = const TextStyle(color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  }

  if (word == null || word.isEmpty) {
    return Text(
      string,
      style: stringStyle,
    );
  } else {
    final spans = _getSpans(string, word, wordStyle);

    return RichText(
      text: TextSpan(
        style: stringStyle,
        children: spans,
      ),
    );
  }
}

Widget highlightSubTitleTextWidget(
  BuildContext context,
  String string,
  String word, {
  TextStyle stringStyle,
  TextStyle wordStyle,
}) {
  if (stringStyle == null) {
    stringStyle = const TextStyle(color: Colors.black, fontSize: 16);
  }

  if (wordStyle == null) {
    wordStyle = const TextStyle(color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  }

  if (word == null || word.isEmpty) {
    return Text(
      string,
      style: stringStyle,
    );
  } else {
    final spans = _getSpans(string, word, wordStyle);

    return RichText(
      text: TextSpan(
        style: stringStyle,
        children: spans,
      ),
    );
  }
}

List<TextSpan> _getSpans(String text, String matchWord, TextStyle style) {
  List<TextSpan> spans = [];
  int spanBoundary = 0;

  List<String> values;
  var length = 0;
  if (matchWord.contains(' ')) {
    values = matchWord.split(' ');
    length = values.length;
  }

  if (length > 1) {
    var currentIndex = 0;

    do {
      // look for the next match
      var startIndex = text.toLowerCase().indexOf(values[0].toLowerCase(), spanBoundary);

      // if no more matches then add the rest of the string without style
      if (startIndex == -1) {
        startIndex = text.toLowerCase().indexOf(values[1].toLowerCase(), spanBoundary);
        currentIndex = 1;

        if (startIndex == -1) {
          if (length > 2) {
            startIndex = text.toLowerCase().indexOf(values[2].toLowerCase(), spanBoundary);
            currentIndex = 2;

            if (startIndex == -1) {
              spans.add(TextSpan(text: text.substring(spanBoundary)));
              return spans;
            }
          } else {
            spans.add(TextSpan(text: text.substring(spanBoundary)));
            return spans;
          }
        }
      }

      // add any unstyled text before the next match
      if (startIndex > spanBoundary) {
        spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
      }

      // style the matched text
      final endIndex = startIndex + values[currentIndex].length;
      final spanText = text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    } while (spanBoundary < text.length);
  } else {
    do {
      // look for the next match
      final startIndex = text.toLowerCase().indexOf(matchWord.toLowerCase(), spanBoundary);

      // if no more matches then add the rest of the string without style
      if (startIndex == -1) {
        spans.add(TextSpan(text: text.substring(spanBoundary)));
        return spans;
      }

      // add any unstyled text before the next match
      if (startIndex > spanBoundary) {
        spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
      }

      // style the matched text
      final endIndex = startIndex + matchWord.length;
      final spanText = text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    } while (spanBoundary < text.length);
  }

  return spans;
}
