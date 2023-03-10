import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';
import 'package:today_mate_clean/domain/repositories/schedule_repository.dart';

class UpdateSchduleUseCase {
  final ScheduleRepository scheduleRepository;
  UpdateSchduleUseCase({
    required this.scheduleRepository,
  });
  Future<List<Schedule>> call(
      Schedule schedule, List<Schedule> selectedSchedules) async {
    try {
      await scheduleRepository.updateSchedule(schedule);
      return selectedSchedules.map((e) {
        if (e.id == schedule.id) {
          return schedule;
        }
        return e;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
