import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/states/schedule/schedule_selector.dart';
import '../../states/schedule/schedule_bloc.dart';
import '../widgets/schedule_card.dart';

class SchedulesBottomModal extends StatelessWidget {
  const SchedulesBottomModal({
    super.key,
  });

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 16),
      height: 4,
      width: 24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey),
    );
  }

  Widget _buildSchedules(BuildContext context) {
    return Expanded(child: SelectedSchedulesSelector((schedules) {
      return ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          return SelectedScheduleSelector(schedules[index], (_) {
            // for (var item in schedules) {
            //   log("upper builder: ${}");
            // }sc
            // log("${schedule.description}");
            return ScheduleCard(
              schedule: schedules[index],
              callBack: (id) async {
                final scheduleBloc = context.read<ScheduleBloc>();
                scheduleBloc.add(DeleteScheduleEvent(id: id));
                NavigatorState? navigator = Navigator.of(context);
                final nextState = await scheduleBloc.stream
                    .firstWhere((element) => element.selectedSchedules.isEmpty);
                if (nextState.selectedSchedules.isEmpty) {
                  navigator.pop();
                }
              },
            );
          });
        },
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [_buildHeader(), _buildSchedules(context)],
      ),
    );
  }
}
