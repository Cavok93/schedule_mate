// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/schedule/schedule.dart';
import 'calendar_bloc.dart';
import 'calendar_state.dart';

class CalendarStateSelector<T>
    extends BlocSelector<CalendarBloc, CalendarState, T> {
  CalendarStateSelector({
    super.key,
    required T Function(CalendarState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) {
            return builder(value);
          },
        );
}

class CalendarSchedulesSelector extends CalendarStateSelector<List<Schedule>> {
  CalendarSchedulesSelector(Widget Function(List<Schedule>) builder,
      {super.key})
      : super(
          selector: (state) => state.schedules,
          builder: builder,
        );
}

class CalendarSelectedDateSelector extends CalendarStateSelector<DateTime> {
  CalendarSelectedDateSelector(Widget Function(DateTime) builder, {super.key})
      : super(
          selector: (state) => state.selectedDate,
          builder: builder,
        );
}

class CalendarSelectedAppBarDateSelector
    extends CalendarStateSelector<DateTime> {
  CalendarSelectedAppBarDateSelector(Widget Function(DateTime) builder,
      {super.key})
      : super(
          selector: (state) => state.selectedAppBarDate,
          builder: builder,
        );
}
