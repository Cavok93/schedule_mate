import '../entities/schedule/schedule.dart';

abstract class ScheduleRepository {
  Future<List<Schedule>> getSchedules();
  Future<Schedule> createSchedule(Schedule schedule);
  Future<void> updateSchedule(Schedule schedule);
  Future<void> deleteSchedule(int id);
}
