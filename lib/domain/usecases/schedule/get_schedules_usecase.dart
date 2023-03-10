import '../../entities/schedule/schedule.dart';
import '../../repositories/schedule_repository.dart';

class GetSchedulesUseCase {
  final ScheduleRepository scheduleRepository;
  const GetSchedulesUseCase({
    required this.scheduleRepository,
  });
  Future<List<Schedule>> call() async {
    try {
      return await scheduleRepository.getSchedules();
    } catch (e) {
      rethrow;
    }
  }
}
