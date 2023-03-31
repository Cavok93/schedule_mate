import 'package:flutter/material.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/calender_sample_header.dart';

import 'calendar_sample.dart';
import 'week_row.dart';

class AppThemeHeader extends StatelessWidget {
  final double itemHeight;
  final double itemWidth;
  final double lineHeight;
  final double monthHeight;
  final double topPadding;
  const AppThemeHeader({
    super.key,
    required this.itemHeight,
    required this.itemWidth,
    required this.lineHeight,
    required this.monthHeight,
    required this.topPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CalendarHeaderSample(),
        const WeekRow(),
        CalendarSample(
            itemHeight: itemHeight,
            itemWidth: itemWidth,
            monthHeight: monthHeight,
            topPadding: topPadding,
            lineHeight: lineHeight)
      ],
    );
  }
}
