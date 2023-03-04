import 'package:today_mate_clean/domain/repositories/schedule_repository.dart';

class DeleteScheduleUseCase {
  final ScheduleRepository scheduleRepository;
  DeleteScheduleUseCase({
    required this.scheduleRepository,
  });
  Future<void> call(int id) async {
    await scheduleRepository.deleteSchedule(id);
  }
}
