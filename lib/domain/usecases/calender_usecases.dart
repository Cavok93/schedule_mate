import 'package:today_mate_clean/domain/usecases/calendar/select_app_bar_date_usecase.dart';
import 'package:today_mate_clean/domain/usecases/calendar/select_date_usecase.dart';

import 'calendar/get_calendar_item_usecase.dart';

class CalendarUseCases {
  final SelectAppBarDateUseCase selectAppBarDateUseCase;
  final SelectDateUseCase selectDateUseCase;
  final GetCalendarItemsUseCase getCalendarItemsUseCase;

  const CalendarUseCases(
      {required this.selectAppBarDateUseCase,
      required this.selectDateUseCase,
      required this.getCalendarItemsUseCase});
}
