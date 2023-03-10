import 'package:today_mate_clean/domain/repositories/schedule_repository.dart';

import '../../entities/schedule/schedule.dart';

class CreateScheduleUseCase {
  final ScheduleRepository scheduleRepository;
  const CreateScheduleUseCase({
    required this.scheduleRepository,
  });
  Future<List<Schedule>> call(
      Schedule schedule, List<Schedule> selectedSchedules) async {
    try {
      final createdSchedule = await scheduleRepository.createSchedule(schedule);
      if (selectedSchedules.isNotEmpty) {
        return [...selectedSchedules, createdSchedule];
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
