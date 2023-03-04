import 'package:flutter/material.dart';
import 'package:today_mate_clean/domain/entities/calendar/day_props.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/schedule_item.dart';

import '../../../../domain/entities/schedule/schedule.dart';

class ScheduleSheet extends StatelessWidget {
  final List<Schedule> schedules;

  const ScheduleSheet({
    super.key,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 16),
            height: 4,
            width: 24,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.grey),
          ),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              return ScheduleItem(
                schedule: schedules[index],
              );
            },
          )),
        ],
      ),
    );
  }
}
