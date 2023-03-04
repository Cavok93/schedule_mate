import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';

import '../../../../configs/routes.dart';
import '../../../../core/utils/calendar_utils.dart';

class ScheduleItem extends StatelessWidget {
  final Schedule schedule;

  const ScheduleItem({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        AppNavigator.push(Routes.form, schedule);
      },
      child: Card(
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          height: 100,
          child: Row(
            children: [
              Container(
                color: CalendarUtils.extractLevelColor(
                    schedule.level, colorScheme),
                width: 4,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(schedule.description),
                    Text(
                        "${DateFormat('yy.MM.dd').format(schedule.begin)} - ${DateFormat('yy.MM.dd').format(schedule.end)}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
