// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../domain/entities/schedule/schedule.dart';

// enum CalendarStateStatus {
//   initial,
//   loading,
//   loadSuccess,
//   loadFailure,
// }

class CalendarState extends Equatable {
  // final CalendarStateStatus status;
  final DateTime selectedDate;
  final DateTime selectedAppBarDate;
  final List<Schedule> schedules;
  final Exception? error;
  const CalendarState({
    // required this.status,
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
  List<Object> get props => [
        // status,
        schedules, error ?? Exception()
      ];

  CalendarState copyWith({
    // CalendarStateStatus? status,
    DateTime? selectedDate,
    DateTime? selectedAppBarDate,
    List<Schedule>? schedules,
    Exception? error,
  }) {
    return CalendarState(
      // status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedAppBarDate: selectedAppBarDate ?? this.selectedAppBarDate,
      schedules: schedules ?? this.schedules,
      error: error ?? this.error,
    );
  }
}
