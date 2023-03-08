// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'schedule_bloc.dart';

enum ScheduleStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
}

class ScheduleState extends Equatable {
  final ScheduleStateStatus status;
  final List<Schedule> selectedSchedules;
  final List<Schedule> schedules;
  final Exception? error;
  const ScheduleState({
    required this.status,
    required this.schedules,
    required this.selectedSchedules,
    this.error,
  });

  factory ScheduleState.initial() {
    return const ScheduleState(
        status: ScheduleStateStatus.initial,
        schedules: [],
        selectedSchedules: []);
  }

  @override
  List<Object> get props => [status, schedules, selectedSchedules];

  ScheduleState copyWith({
    ScheduleStateStatus? status,
    List<Schedule>? selectedSchedules,
    List<Schedule>? schedules,
    Exception? error,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      selectedSchedules: selectedSchedules ?? this.selectedSchedules,
      schedules: schedules ?? this.schedules,
      error: error ?? this.error,
    );
  }
}
