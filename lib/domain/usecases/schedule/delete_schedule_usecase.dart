import 'package:today_mate_clean/domain/repositories/schedule_repository.dart';

import '../../entities/schedule/schedule.dart';

class DeleteScheduleUseCase {
  final ScheduleRepository scheduleRepository;
  DeleteScheduleUseCase({
    required this.scheduleRepository,
  });
  Future<List<Schedule>> call(int id, List<Schedule> selectedSchedules) async {
    try {
      await scheduleRepository.deleteSchedule(id);
      return selectedSchedules.where((element) => element.id != id).toList();
    } catch (e) {
      rethrow;
    }
  }
}
