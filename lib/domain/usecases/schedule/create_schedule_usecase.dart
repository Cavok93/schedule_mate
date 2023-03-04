import 'package:today_mate_clean/domain/repositories/schedule_repository.dart';

import '../../entities/schedule/schedule.dart';

class CreateScheduleUseCase {
  final ScheduleRepository scheduleRepository;
  const CreateScheduleUseCase({
    required this.scheduleRepository,
  });
  Future<Schedule> call(Schedule schedule) async {
    return await scheduleRepository.createSchedule(schedule);
  }
}
