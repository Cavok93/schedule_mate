import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:today_mate_clean/configs/constants.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/calendar_cell.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/events_overlay.dart';

import '../../../../core/enums/week_day.dart';

class CalendarBody extends StatelessWidget {
  final Jiffy begin;
  final Jiffy end;
  final int beginOffset;
  final int daysInMonth;
  final DateTime displayMonth;
  const CalendarBody(
      {super.key,
      required this.begin,
      required this.end,
      required this.beginOffset,
      required this.daysInMonth,
      required this.displayMonth});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const int kMaxWeekPerMoth = 6;
      final itemWidth = constraints.maxWidth / WeekDay.values.length;
      final itemHeight = constraints.maxHeight / kMaxWeekPerMoth;
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: itemHeight * kMaxWeekPerMoth,
          child: Stack(
            children: [
              CalendarCell(
                begin: begin,
                end: end,
                itemHeight: itemHeight,
                itemWidth: itemWidth,
                beginOffset: beginOffset,
                daysInMonth: daysInMonth,
                displayMonth: displayMonth,
                topPadding: itemWidth / 2,
                maxLines: CalendarElemetOptions.kMaxLines,
              ),
              EventsOverlay(
                  begin: begin,
                  topPadding: itemWidth / 2,
                  itemWidth: itemWidth,
                  itemHeight: itemHeight,
                  maxLines: CalendarElemetOptions.kMaxLines),
            ],
          ),
        ),
      );
    });
  }
}
