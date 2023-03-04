import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/schedule_sheet.dart';
import 'package:today_mate_clean/states/calendar/calendar_bloc.dart';
import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../../configs/constants.dart';
import '../../../../core/utils/calendar_utils.dart';
import '../../../../domain/entities/calendar/drawers.dart';
import '../../../../domain/entities/calendar/event_counts.dart';
import '../../../../domain/entities/schedule/schedule.dart';
import '../../../../states/calendar/calendar_selector.dart';

class CalendarCell extends StatelessWidget {
  final Jiffy begin;
  final Jiffy end;
  final double itemHeight;
  final double itemWidth;
  final double topPadding;
  final int beginOffset;
  final int daysInMonth;
  final DateTime displayMonth;
  final int maxLines;
  const CalendarCell(
      {super.key,
      required this.begin,
      required this.end,
      required this.itemHeight,
      required this.itemWidth,
      required this.topPadding,
      required this.beginOffset,
      required this.daysInMonth,
      required this.displayMonth,
      required this.maxLines});

  @override
  Widget build(BuildContext context) {
    final overflowedEvents = NotFittedPageEventCount();
    final colorScheme = Theme.of(context).colorScheme;
    return CalendarSelectors((events) {
      final drawersForWeek = <List<EventProperties>>[];
      for (int week = 0; week < CalendarConstants.kMaxWeekPerMoth; week++) {
        final drawers = <EventProperties>[];
        final beginDate = Jiffy(begin).add(weeks: week);
        final endDate = Jiffy(beginDate).add(days: 7 - 1);
        for (final e in events) {
          final simpleEvent = CalendarUtils.mapSimpleEventToDrawerOrNull(
              e, beginDate, endDate, colorScheme);
          if (simpleEvent != null) {
            drawers.add(simpleEvent);
          }
        }
        drawersForWeek.add(drawers);
      }
      overflowedEvents.weeks =
          CalendarUtils.calculateOverflowedEvents(drawersForWeek, maxLines);

      final weeks = List.generate(
        CalendarConstants.kMaxWeekPerMoth,
        (index) => Row(
          children: _buildDays(
              week: index,
              itemWidth: itemWidth,
              itemHeight: itemHeight,
              begin: begin,
              beginOffset: beginOffset,
              daysInMonth: daysInMonth,
              eventList: events,
              overflowedEvents: overflowedEvents,
              context: context,
              colorScheme: colorScheme),
        ),
      );
      return Column(
        children: weeks,
      );
    });
  }

  List<Widget> _buildDays(
      {required int week,
      required double itemWidth,
      required double itemHeight,
      required Jiffy begin,
      required int beginOffset,
      required int daysInMonth,
      required List<Schedule> eventList,
      required NotFittedPageEventCount overflowedEvents,
      required BuildContext context,
      required ColorScheme colorScheme}) {
    final days = List.generate(CalendarConstants.kWeekDaysCount, (i) {
      final index = week * CalendarConstants.kWeekDaysCount + i;
      Tuple2<int, bool> day = const Tuple2(0, false);
      final consideringPrevMonth = begin.date + index;
      if (consideringPrevMonth <= begin.daysInMonth && begin.date != 1) {
        day = Tuple2(consideringPrevMonth, false);
      } else {
        final commonDay = index - beginOffset + 1;
        if (commonDay <= daysInMonth) {
          day = Tuple2(commonDay, true);
        } else {
          day = Tuple2(commonDay - daysInMonth, false);
        }
      }

      final column = index % CalendarConstants.kWeekDaysCount;
      final row = index ~/ CalendarConstants.kWeekDaysCount;
      final notFittedEventsCount =
          overflowedEvents.weeks[row].eventCount[column];

      final lineHeight = (itemHeight - topPadding) / maxLines;

      final height = lineHeight -
          itemHeight / CalendarConstants.kDistanceBetweenEventsCoef;
      final double emptySpace =
          itemHeight - topPadding - (height * CalendarConstants.kMaxLines);
      final double singleSpace = emptySpace / CalendarConstants.kMaxLines;
      return GestureDetector(
        onTap: () {
          final tappedDate = Jiffy(begin).add(days: index);
          context
              .read<CalendarBloc>()
              .add(SelectDateEvent(selectedDate: tappedDate.dateTime));
          final events = CalendarUtils.calculateAvailableEventsForDate(
              eventList, tappedDate);
          _showDayEventsInModalSheet(
              context: context, day: tappedDate.dateTime, events: events);
        },
        child: Container(
          width: itemWidth,
          height: itemHeight,
          decoration: BoxDecoration(
              color: !day.item2 ? Colors.grey.shade100 : Colors.white,
              border: Border.all(color: Colors.grey.shade400, width: 0)),
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Container(
                height: (itemWidth / 3),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "${day.item1}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1,
                        color: Jiffy(begin).add(days: index).dateTime.weekday ==
                                DateTime.sunday
                            ? Colors.red
                            : Colors.black),
                  ),
                ),
              ),
              if (notFittedEventsCount > 0)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height,
                    width: itemWidth,
                    margin: EdgeInsets.only(bottom: singleSpace),
                    // color: Colors.red,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        child: Text(
                          "+$notFittedEventsCount",
                          style: TextStyle(color: colorScheme.primary),
                        )),
                  ),
                ),
              CalendarSelectedDateSelector((selectedDate) {
                final bool isSelected = CalendarUtils.isSelectedDate(
                    index, selectedDate,
                    begin: begin, end: end);
                return Container(
                  decoration: isSelected
                      ? BoxDecoration(
                          border: Border.all(
                              width: 1.4, color: colorScheme.primary))
                      : null,
                  height: itemHeight,
                  width: itemWidth,
                );
              })
            ],
          ),
        ),
      );
    });
    return days;
  }

  void _showDayEventsInModalSheet(
      {required List<Schedule> events,
      required DateTime day,
      required BuildContext context}) {
    if (events.isEmpty) {
      return;
    }

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        // backgroundColor: Colors.white,
        builder: (context) {
          return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<ScheduleBloc>(),
                ),
              ],
              child: ScheduleSheet(
                schedules: events,
              ));
        });
  }
}
