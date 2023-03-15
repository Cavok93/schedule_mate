import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:today_mate_clean/configs/constants.dart';
import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';
import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';
import '../../configs/routes.dart';
import '../../core/extensions/date_time.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final Function(int id) callBack;
  const ScheduleCard(
      {super.key, required this.schedule, required this.callBack});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0.0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1.0)),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: MSHCheckbox(
                    size: 24,
                    value: schedule.isCompleted,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: colorScheme.primary,
                    ),
                    duration: const Duration(milliseconds: 100),
                    style: MSHCheckboxStyle.stroke,
                    onChanged: (selected) {
                      context.read<ScheduleBloc>().add(UpdateScheduleEvent(
                          schedule: Schedule(
                              id: schedule.id,
                              title: schedule.title,
                              description: schedule.description,
                              begin: schedule.begin,
                              end: schedule.end,
                              created: schedule.created,
                              isCompleted: selected,
                              level: schedule.level)));
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      AppNavigator.push(Routes.form, schedule);
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 0, top: 12, right: 12, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Builder(builder: (context) {
                            final style = TextStyle(
                                fontSize: 14.0,
                                color: schedule.isCompleted
                                    ? Colors.grey.shade500
                                    : Colors.black);
                            final Size txtSize =
                                TextOptions.textSize(schedule.title, style);
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  schedule.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: style,
                                ),
                                if (schedule.isCompleted)
                                  Container(
                                    height: 1,
                                    width: txtSize.width,
                                    color: Colors.black,
                                  )
                              ],
                            );
                          }),
                          const SizedBox(height: 8.0),
                          Text(
                            "${DateTimeX(schedule.begin).format()} - ${DateTimeX(schedule.end).format()}",
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child:
            //       _buildDeleteButton(context, colorScheme, schedule.id ?? 0),
            // )
          ],
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
