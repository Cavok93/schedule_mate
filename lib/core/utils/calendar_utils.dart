import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../domain/entities/calendar/drawers.dart';
import '../../domain/entities/calendar/event_counts.dart';
import '../../domain/entities/schedule/schedule.dart';
import '../enums/week_day.dart';

class CalendarUtils {
  static int? returnCurrentDayForDateOrNull(DateTime display) {
    final now = DateTime.now();
    if (display.year == now.year && display.month == now.month) {
      return now.day;
    }
    return null;
  }

  static bool isSelectedDate(int index, DateTime? selectedDate,
      {required Jiffy begin}) {
    final selectedDay = Jiffy(selectedDate);
    if (Jiffy(begin).add(days: index).isSame(selectedDay)) {
      return true;
    }

    return false;
  }

  static List<WeekDay> sortWeekdays(WeekDay fistDayInWeek) {
    if (fistDayInWeek == WeekDay.sunday) {
      return WeekDay.values;
    } else {
      const days = WeekDay.values;
      final index = fistDayInWeek.index;
      final sorted = days.sublist(index)..addAll(days.sublist(0, index));
      return sorted;
    }
  }

  static List<Schedule> calculateAvailableEventsForDate(
      List<Schedule> events, Jiffy date) {
    final eventsHappen = <Schedule>[];
    for (final event in events) {
      final eventStartUtc =
          DateTime.utc(event.begin.year, event.begin.month, event.begin.day);
      final eventEndUtc =
          DateTime.utc(event.end.year, event.end.month, event.end.day);

      if (date.isSameOrAfter(Jiffy(eventStartUtc)) &&
          date.isSameOrBefore(Jiffy(eventEndUtc))) {
        eventsHappen.add(event);
      }
    }

    return eventsHappen;
  }

  static List<EventsLineDrawer> placeEventsToLines(
      List<EventProperties> events, int maxLines) {
    final copy = <EventProperties>[...events]
      ..sort((a, b) => b.size().compareTo(a.size()));

    final lines = List.generate(maxLines, (index) {
      final lineDrawer = EventsLineDrawer();
      for (var day = 1; day <= 7; day++) {
        final candidates = <EventProperties>[];

        for (final c in copy) {
          if (day == c.begin) {
            candidates.add(c);
          }
        }

        candidates.sort((a, b) => b.size().compareTo(a.size()));
        if (candidates.isNotEmpty) {
          lineDrawer.events.add(candidates.first);
          copy.remove(candidates.first);
          day += candidates.first.size() - 1;
        }
      }
      return lineDrawer;
    });
    return lines;
  }

  static List<EventProperties> resolveEventDrawersForWeek(int week,
      Jiffy monthStart, List<Schedule> events, ColorScheme colorScheme) {
    final drawers = <EventProperties>[];

    final beginDate = Jiffy(monthStart).add(weeks: week);
    final endDate = Jiffy(beginDate).add(days: 7 - 1);

    for (final e in events) {
      final simpleEvent =
          mapSimpleEventToDrawerOrNull(e, beginDate, endDate, colorScheme);
      if (simpleEvent != null) {
        drawers.add(simpleEvent);
      }
    }

    return drawers;
  }

  static EventProperties? mapSimpleEventToDrawerOrNull(
      Schedule event, Jiffy begin, Jiffy end, ColorScheme colorScheme) {
    final jBegin = Jiffy(DateTime.utc(
      event.begin.year,
      event.begin.month,
      event.begin.day,
      event.begin.hour,
      event.begin.minute,
    ));
    final jEnd = Jiffy(DateTime.utc(
      event.end.year,
      event.end.month,
      event.end.day,
      event.end.hour,
      event.end.minute,
    ));

    if (jEnd.isBefore(begin, Units.DAY) || jBegin.isAfter(end, Units.DAY)) {
      return null;
    }

    var beginDay = 1;
    if (jBegin.isSameOrAfter(begin)) {
      beginDay = (begin.day - jBegin.day < 1)
          ? 1 - (begin.day - jBegin.day)
          : 1 - (begin.day - jBegin.day) + WeekDay.values.length;
    }

    var endDay = 7;
    if (jEnd.isSameOrBefore(end)) {
      endDay = (begin.day - jEnd.day < 1)
          ? 1 - (begin.day - jEnd.day)
          : 1 - (begin.day - jEnd.day) + WeekDay.values.length;
    }

    return EventProperties(
        begin: beginDay,
        end: endDay,
        name: event.title,
        backgroundColor: extractLevelColor(event.level, colorScheme));
  }

  static Color extractLevelColor(int level, ColorScheme colorScheme) {
    switch (level) {
      case 1:
        return colorScheme.primary;
      case 2:
        return colorScheme.primaryContainer;
      case 3:
        return colorScheme.secondary;
      default:
        return colorScheme.tertiary;
    }
  }

  static List<NotFittedWeekEventCount> calculateOverflowedEvents(
      List<List<EventProperties>> monthEvents, int maxLines) {
    final weeks = <NotFittedWeekEventCount>[];
    for (final week in monthEvents) {
      var countList = List.filled(WeekDay.values.length, 0);

      for (final event in week) {
        for (var i = event.begin - 1; i < event.end; i++) {
          countList[i]++;
        }
      }
      countList = countList.map((count) {
        final notFitCount = count - (maxLines - 1);
        return notFitCount <= 0 ? 0 : notFitCount;
      }).toList();
      weeks.add(NotFittedWeekEventCount(countList));
    }
    return weeks;
  }
}
