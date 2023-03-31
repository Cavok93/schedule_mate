// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:today_mate_clean/domain/usecases/schedule/create_schedule_usecase.dart';
import 'package:today_mate_clean/domain/usecases/schedule/delete_schedule_usecase.dart';
import 'package:today_mate_clean/domain/usecases/schedule/get_schedules_usecase.dart';
import 'package:today_mate_clean/domain/usecases/schedule/update_schedule_usecase.dart';

class ScheduleUseCases {
  final CreateScheduleUseCase createScheduleUseCase;
  final GetSchedulesUseCase getSchedulesUseCase;
  final UpdateSchduleUseCase updateScheduleUseCase;
  final DeleteScheduleUseCase deleteScheduleUseCase;

  ScheduleUseCases({
    required this.createScheduleUseCase,
    required this.getSchedulesUseCase,
    required this.updateScheduleUseCase,
    required this.deleteScheduleUseCase,
  });
}
