import 'package:today_mate_clean/core/enums/week_day.dart';

class DayItemProperties {
  DayItemProperties({
    required this.dayNumber,
    required this.isInMonth,
    required this.isCurrentDay,
    required this.notFittedEventsCount,
    required this.isSelected,
    required this.isInRange,
    required this.isFirstInRange,
    required this.isLastInRange,
  });

  final int dayNumber;
  final bool isInMonth;
  final bool isCurrentDay;
  final int notFittedEventsCount;
  final bool isSelected;
  final bool isInRange;
  final bool isFirstInRange;
  final bool isLastInRange;
}

class DateItemProperties {
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime initialMonth;
  final DateTime minMonth;
  final DateTime maxMonth;
  final WeekDay startWeekDay;
  DateItemProperties(
      {required this.initialDate,
      required this.minDate,
      required this.maxDate,
      required this.initialMonth,
      required this.minMonth,
      required this.maxMonth,
      required this.startWeekDay});
}

class DateItemStore {
  static DateItemProperties _dateItemProperties = DateItemProperties(
      initialDate: DateTime.now(),
      minDate: DateTime.now(),
      startWeekDay: WeekDay.sunday,
      maxDate: DateTime.now(),
      initialMonth: DateTime.now(),
      minMonth: DateTime.now(),
      maxMonth: DateTime.now());
  DateItemProperties get dateItemProperties => _dateItemProperties;

  static final DateItemStore _dateItemStore = DateItemStore._internal();
  DateItemStore._internal();
  factory DateItemStore() {
    return _dateItemStore;
  }
  set({
    required DateItemProperties properties,
  }) {
    _dateItemProperties = properties;
  }
}
