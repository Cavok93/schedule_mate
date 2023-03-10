part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class CreateScheduleEvent extends ScheduleEvent {
  final Schedule schedule;
  const CreateScheduleEvent({
    required this.schedule,
  });
}

class SelectSchedulesEvent extends ScheduleEvent {
  final List<Schedule> schedules;
  const SelectSchedulesEvent({
    required this.schedules,
  });
}

class ResetSelectedSchedulesEvent extends ScheduleEvent {}

class GetSchedulesEvent extends ScheduleEvent {}

class UpdateScheduleEvent extends ScheduleEvent {
  final Schedule schedule;
  const UpdateScheduleEvent({
    required this.schedule,
  });
}

class DeleteScheduleEvent extends ScheduleEvent {
  final int id;
  const DeleteScheduleEvent({
    required this.id,
  });
}
