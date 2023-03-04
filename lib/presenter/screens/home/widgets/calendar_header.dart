import 'package:flutter/material.dart';
import 'package:today_mate_clean/domain/entities/calendar/day_props.dart';

import '../../../../configs/constants.dart';
import '../../../../core/enums/week_day.dart';
import '../../../../core/utils/calendar_utils.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final weeks = List<Widget>.generate(WeekDay.values.length, (index) {
      final sortedWeekDays = CalendarUtils.sortWeekdays(
          DateItemStore().dateItemProperties.startWeekDay);
      return Container(
          padding: const EdgeInsets.all(4),
          height: CalendarConstants.kWeekHeaderHeight,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Center(
              child: Text(
                sortedWeekDays[index].value,
                style: TextStyle(
                    color: (sortedWeekDays[index] == WeekDay.sunday)
                        ? Colors.red
                        : Colors.black),
              ),
            ),
          ));
    });
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.shade200),
              bottom: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weeks,
      ),
    );
  }
}
