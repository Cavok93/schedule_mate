import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';
import '../../domain/entities/schedule/schedule.dart';
import 'calendar_state.dart';
part 'calendar_event.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  late final StreamSubscription scheduleSubscription;
  final ScheduleBloc scheduleBloc;
  CalendarBloc({required this.scheduleBloc}) : super(CalendarState.initial()) {
    scheduleSubscription =
        scheduleBloc.stream.listen((ScheduleState scheduleState) {
      add(GetCalendarItemsEvent(schedules: scheduleState.schedules));
    });
    on<GetCalendarItemsEvent>(_getCalendarItems);
    on<SelectDateEvent>(_selecteDate);
    on<SelectAppBarDateEvent>(_selecteAppBarDate);
  }

  Future<void> _getCalendarItems(
      GetCalendarItemsEvent event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(schedules: event.schedules));
  }

  void _selecteDate(SelectDateEvent event, Emitter<CalendarState> emit) {
    emit(state.copyWith(selectedDate: event.selectedDate));
  }

  void _selecteAppBarDate(
      SelectAppBarDateEvent event, Emitter<CalendarState> emit) {
    final offset = event.currentPage - event.initialPage;
    final date = Jiffy([event.initialDate.year, event.initialDate.month])
        .add(months: offset)
        .dateTime;
    emit(state.copyWith(selectedAppBarDate: DateTime(date.year, date.month)));
  }

  @override
  Future<void> close() {
    scheduleSubscription.cancel();
    return super.close();
  }
}
