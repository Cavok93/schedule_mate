import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:today_mate_clean/presenter/modals/schedules_modal.dart';

import 'package:today_mate_clean/states/calendar/calendar_bloc.dart';
import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../../configs/constants.dart';
import '../../../../configs/routes.dart';
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
    return CalendarSchedulesSelector((events) {
      final drawersForWeek = <List<EventProperties>>[];
      for (int week = 0; week < CalendarElemetOptions.kMaxWeekPerMoth; week++) {
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
        CalendarElemetOptions.kMaxWeekPerMoth,
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
    final days = List.generate(CalendarElemetOptions.kWeekDaysCount, (i) {
      final index = week * CalendarElemetOptions.kWeekDaysCount + i;
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

      final column = index % CalendarElemetOptions.kWeekDaysCount;
      final row = index ~/ CalendarElemetOptions.kWeekDaysCount;
      final notFittedEventsCount =
          overflowedEvents.weeks[row].eventCount[column];

      final lineHeight = (itemHeight - topPadding) / maxLines;

      final height = lineHeight -
          itemHeight / CalendarElemetOptions.kDistanceBetweenEventsCoef;
      final double emptySpace =
          itemHeight - topPadding - (height * CalendarElemetOptions.kMaxLines);
      final double singleSpace = emptySpace / CalendarElemetOptions.kMaxLines;
      final currentDate = Jiffy(begin).add(days: index);

      return GestureDetector(
        onTap: () {
          context
              .read<CalendarBloc>()
              .add(SelectDateEvent(selectedDate: currentDate.dateTime));
          final targetEvents = CalendarUtils.calculateAvailableEventsForDate(
              eventList, currentDate);
          context
              .read<ScheduleBloc>()
              .add(SelectSchedulesEvent(schedules: targetEvents));
          // _showSchdulesModal(
          //     context: context,
          //     day: currentDate.dateTime,
          //     events: targetEvents);
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
                  alignment: Alignment.center,
                  height: itemHeight,
                  width: itemWidth,
                  child: (CalendarUtils.calculateAvailableEventsForDate(
                                  eventList, currentDate)
                              .isEmpty &&
                          isSelected)
                      ? IconButton(
                          onPressed: () {
                            AppNavigator.push(Routes.form, null);
                          },
                          color: colorScheme.primary,
                          icon: const Icon(Icons.add_circle_outline_sharp),
                          constraints: const BoxConstraints(),
                          iconSize: itemWidth / 3,
                        )
                      : null,
                );
              })
            ],
          ),
        ),
      );
    });
    return days;
  }

  void _showSchdulesModal(
      {required List<Schedule> events,
      required DateTime day,
      required BuildContext context}) {
    if (events.isEmpty) {
      return;
    }
    context.read<ScheduleBloc>().add(SelectSchedulesEvent(schedules: events));

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        // backgroundColor: Colors.white,
        builder: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider.value(
              value: context.read<ScheduleBloc>(),
            ),
          ], child: const SchedulesBottomModal());
        });
  }
}
