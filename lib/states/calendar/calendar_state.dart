// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../domain/entities/schedule/schedule.dart';

class CalendarState extends Equatable {
  final DateTime selectedDate;
  final DateTime selectedAppBarDate;
  final List<Schedule> schedules;
  final Exception? error;
  const CalendarState({
    required this.selectedDate,
    required this.selectedAppBarDate,
    required this.schedules,
    this.error,
  });

  factory CalendarState.initial() {
    return CalendarState(
        selectedDate: DateTime.utc(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        selectedAppBarDate: DateTime.now(),
        schedules: const []);
  }

  @override
  List<Object> get props => [schedules, error ?? Exception()];

  CalendarState copyWith({
    DateTime? selectedDate,
    DateTime? selectedAppBarDate,
    List<Schedule>? schedules,
    Exception? error,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedAppBarDate: selectedAppBarDate ?? this.selectedAppBarDate,
      schedules: schedules ?? this.schedules,
      error: error ?? this.error,
    );
  }
}
