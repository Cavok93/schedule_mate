// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';
import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';

class ScheduleStateSelector<T>
    extends BlocSelector<ScheduleBloc, ScheduleState, T> {
  ScheduleStateSelector({
    super.key,
    required T Function(ScheduleState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) {
            return builder(value);
          },
        );
}

class ScheduleStateStatusSelector
    extends ScheduleStateSelector<ScheduleStateStatus> {
  ScheduleStateStatusSelector(Widget Function(ScheduleStateStatus) builder,
      {super.key})
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class SelectedSchedulesSelector extends ScheduleStateSelector<List<Schedule>> {
  SelectedSchedulesSelector(Widget Function(List<Schedule>) builder,
      {super.key})
      : super(
          selector: (state) => state.selectedSchedules,
          builder: builder,
        );
}
