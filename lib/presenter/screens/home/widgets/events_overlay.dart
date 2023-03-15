import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:today_mate_clean/states/calendar/calendar_selector.dart';

import '../../../../configs/constants.dart';
import '../../../../core/utils/calendar_utils.dart';
import '../../../../domain/entities/calendar/drawers.dart';

class EventsOverlay extends StatelessWidget {
  const EventsOverlay({
    required this.begin,
    required this.itemWidth,
    required this.itemHeight,
    required this.topPadding,
    required this.maxLines,
    this.padding,
    super.key,
  });

  final Jiffy begin;
  final double topPadding;
  final double itemWidth;
  final double itemHeight;
  final int maxLines;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CalendarSchedulesSelector((events) {
      final weeks =
          List.generate(CalendarElemetOptions.kMaxWeekPerMoth, (week) {
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
        final placedEvents =
            CalendarUtils.placeEventsToLines(drawers, maxLines);
        return WeekDrawer(placedEvents);
      });
      return IgnorePointer(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: weeks.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: topPadding),
              height: itemHeight - topPadding,
              child: Stack(
                children: _buildPositionedEvents(
                    eventLines: weeks[index].lines, colorScheme: colorScheme),
              ),
            );
          },
        ),
      );
    });
  }

  List<Widget> _buildPositionedEvents(
      {required List<EventsLineDrawer> eventLines,
      required ColorScheme colorScheme}) {
    final lineHeight = (itemHeight - topPadding) / maxLines;
    final widgets = <Widget>[];

    const int kWeekDaysCount = 7;
    const int kLinesPadding = 2;

    for (var i = 0; i < eventLines.length; i++) {
      for (var j = 0; j < eventLines[i].events.length; j++) {
        var item = eventLines[i].events[j];
        if (i < CalendarElemetOptions.kMaxLines - 1) {
          final double topPosition = i * lineHeight;
          final double leftPosition =
              (item.begin - 1) * itemWidth + (padding?.left ?? 0);
          final double rightPosition =
              (kWeekDaysCount - item.end) * itemWidth + (padding?.right ?? 0);
          final double drawHeight = lineHeight -
              itemHeight / CalendarElemetOptions.kDistanceBetweenEventsCoef;
          final double drawWidth = itemWidth * item.size() - kLinesPadding;

          widgets.add(
            Positioned(
              top: topPosition,
              left: leftPosition,
              right: rightPosition,
              child: SizedBox(
                height: drawHeight < 0 ? 0 : drawHeight,
                width: drawWidth < 0 ? 0 : drawWidth,
                child: Container(
                  color: item.backgroundColor,
                  padding: const EdgeInsets.only(left: 3),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
    return widgets;
  }
}
