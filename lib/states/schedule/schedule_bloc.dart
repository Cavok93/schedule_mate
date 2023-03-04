import 'dart:developer';
import 'package:equatable/equatable.dart';
import '../../domain/entities/schedule/schedule.dart';
import '../../domain/usecases/schedule_usecases.dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleUseCases scheduleUseCases;
  ScheduleBloc({required this.scheduleUseCases})
      : super(ScheduleState.initial()) {
    on<CreateScheduleEvent>(_createSchedule);
    on<GetSchedulesEvent>(_getSchedules);
    on<UpdateScheduleEvent>(_updateSchedule);
    on<DeleteScheduleEvent>(_deleteSchedule);
  }

  Future<void> _createSchedule(
      CreateScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(state.copyWith(status: ScheduleStateStatus.loading));

    try {
      await scheduleUseCases.createScheduleUseCase(event.schedule);
      final schedules = await scheduleUseCases.getSchedulesUseCase();
      emit(state.copyWith(
          status: ScheduleStateStatus.loadSuccess, schedules: schedules));
    } on Exception catch (e) {
      log("$e");
      emit(state.copyWith(status: ScheduleStateStatus.loadFailure, error: e));
    }
  }

  Future<void> _getSchedules(
      GetSchedulesEvent event, Emitter<ScheduleState> emit) async {
    emit(state.copyWith(status: ScheduleStateStatus.loading));
    try {
      final schedules = await scheduleUseCases.getSchedulesUseCase();
      emit(state.copyWith(
          status: ScheduleStateStatus.loadSuccess, schedules: schedules));
    } on Exception catch (e) {
      log("$e");
      emit(state.copyWith(status: ScheduleStateStatus.loadFailure, error: e));
    }
  }

  Future<void> _updateSchedule(
      UpdateScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(state.copyWith(status: ScheduleStateStatus.loading));

    try {
      await scheduleUseCases.updateScheduleUseCase(event.schedule);
      final schedules = await scheduleUseCases.getSchedulesUseCase();
      emit(state.copyWith(
          status: ScheduleStateStatus.loadSuccess, schedules: schedules));
    } on Exception catch (e) {
      log("$e");
      emit(state.copyWith(status: ScheduleStateStatus.loadFailure, error: e));
    }
  }

  Future<void> _deleteSchedule(
      DeleteScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(state.copyWith(status: ScheduleStateStatus.loading));

    try {
      await scheduleUseCases.deleteScheduleUseCase(event.id);
      final schedules = await scheduleUseCases.getSchedulesUseCase();
      emit(state.copyWith(
          status: ScheduleStateStatus.loadSuccess, schedules: schedules));
    } on Exception catch (e) {
      log("$e");
      emit(state.copyWith(status: ScheduleStateStatus.loadFailure, error: e));
    }
  }
}
