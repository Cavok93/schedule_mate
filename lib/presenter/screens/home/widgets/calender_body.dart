import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:today_mate_clean/configs/constants.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/calendar_cell.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/events_overlay.dart';

import '../../../../core/enums/week_day.dart';

class CalendarBody extends StatelessWidget {
  final Jiffy begin;
  final int beginOffset;
  final int daysInMonth;
  final DateTime displayMonth;
  const CalendarBody(
      {super.key,
      required this.begin,
      required this.beginOffset,
      required this.daysInMonth,
      required this.displayMonth});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: constraints.maxHeight,
          child: Stack(
            children: [
              CalendarCell(
                begin: begin,
                itemHeight: constraints.maxHeight /
                    CalendarElemetOptions.kMaxWeekPerMoth,
                itemWidth: constraints.maxWidth / WeekDay.values.length,
                beginOffset: beginOffset,
                daysInMonth: daysInMonth,
                displayMonth: displayMonth,
                topPadding: constraints.maxWidth / WeekDay.values.length / 2,
                maxLines: CalendarElemetOptions.kMaxLines,
              ),
              EventsOverlay(
                  begin: begin,
                  topPadding: constraints.maxWidth / WeekDay.values.length / 2,
                  itemWidth: constraints.maxWidth / WeekDay.values.length,
                  itemHeight: constraints.maxHeight /
                      CalendarElemetOptions.kMaxWeekPerMoth,
                  maxLines: CalendarElemetOptions.kMaxLines),
            ],
          ),
        ),
      );
    });
  }
}
