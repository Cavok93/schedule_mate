import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';
import 'package:today_mate_clean/domain/repositories/schedule_repository.dart';

class UpdateSchduleUseCase {
  final ScheduleRepository scheduleRepository;
  UpdateSchduleUseCase({
    required this.scheduleRepository,
  });
  Future<void> call(Schedule schedule) async {
    await scheduleRepository.updateSchedule(schedule);
  }
}
