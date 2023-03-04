import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:today_mate_clean/domain/usecases/calender_usecases.dart';
import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';
import '../../domain/entities/schedule/schedule.dart';
import 'calendar_state.dart';
part 'calendar_event.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarUseCases calendarUseCases;
  late final StreamSubscription scheduleSubscription;
  final ScheduleBloc scheduleBloc;

  CalendarBloc({required this.calendarUseCases, required this.scheduleBloc})
      : super(CalendarState.initial()) {
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
    emit(state.copyWith(
        schedules: calendarUseCases.getCalendarItemsUseCase(event.schedules)));
  }

  void _selecteDate(SelectDateEvent event, Emitter<CalendarState> emit) {
    emit(state.copyWith(
        selectedDate: calendarUseCases.selectDateUseCase(event.selectedDate)));
  }

  void _selecteAppBarDate(
      SelectAppBarDateEvent event, Emitter<CalendarState> emit) {
    emit(state.copyWith(
        selectedAppBarDate: calendarUseCases.selectAppBarDateUseCase(
            event.initialDate, event.initialPage, event.currentPage)));
  }

  @override
  Future<void> close() {
    scheduleSubscription.cancel();
    return super.close();
  }
}
