// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class SelectDateEvent extends CalendarEvent {
  final DateTime selectedDate;
  const SelectDateEvent({
    required this.selectedDate,
  });
}

class SelectAppBarDateEvent extends CalendarEvent {
  final DateTime initialDate;
  final int initialPage;
  final int currentPage;
  const SelectAppBarDateEvent({
    required this.initialDate,
    required this.initialPage,
    required this.currentPage,
  });
}

class GetCalendarItemsEvent extends CalendarEvent {
  final List<Schedule> schedules;
  const GetCalendarItemsEvent({
    required this.schedules,
  });
}
