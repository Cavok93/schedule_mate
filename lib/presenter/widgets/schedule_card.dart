import 'package:flutter/material.dart';
import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';
import '../../configs/routes.dart';
import '../../core/extensions/date_time.dart';
import '../../core/utils/calendar_utils.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final Function(int id) callBack;
  const ScheduleCard(
      {super.key, required this.schedule, required this.callBack});

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
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Stack(
            children: [
              Row(
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
                            "${SimpleTime(schedule.begin).format()} - ${SimpleTime(schedule.end).format()}"),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child:
                    _buildDeleteButton(context, colorScheme, schedule.id ?? 0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(
      BuildContext context, ColorScheme colorScheme, int id) {
    return IconButton(
      onPressed: () async {
        callBack(id);
      },
      icon: const Icon(Icons.delete),
      color: colorScheme.primary,
      constraints: const BoxConstraints(),
      iconSize: 50,
    );
  }
}
