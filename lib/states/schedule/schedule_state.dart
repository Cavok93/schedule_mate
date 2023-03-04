part of 'schedule_bloc.dart';

enum ScheduleStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
}

class ScheduleState extends Equatable {
  final ScheduleStateStatus status;
  final List<Schedule> schedules;
  final Exception? error;
  const ScheduleState({
    required this.status,
    required this.schedules,
    this.error,
  });

  factory ScheduleState.initial() {
    return const ScheduleState(
        status: ScheduleStateStatus.initial, schedules: []);
  }

  @override
  List<Object> get props => [status, schedules, error ?? Exception()];

  ScheduleState copyWith({
    ScheduleStateStatus? status,
    List<Schedule>? schedules,
    Exception? error,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      schedules: schedules ?? this.schedules,
      error: error ?? this.error,
    );
  }
}
