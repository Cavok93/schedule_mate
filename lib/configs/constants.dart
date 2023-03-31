import 'package:flutter/material.dart';

class CalendarElemetOptions {
  static const int kDistanceBetweenEventsCoef = 34;
  static const int kMaxWeekPerMoth = 6;
  static const int kWeekDaysCount = 7;
  static const int kMaxLines = 5;
  static const double kWeekHeaderHeight = 26.0;
}

class AppThemeKey {
  static const appThemeKey = "APPTHEMEKEY";
}

class TextOptions {
  static Size textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
