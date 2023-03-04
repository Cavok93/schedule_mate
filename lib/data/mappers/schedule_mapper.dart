import '../../domain/entities/schedule/schedule.dart';
import '../models/schedule_data.dart';

class ScheduleMapper {
  static Schedule toEntity(final ScheduleData data) {
    return Schedule(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      begin: DateTime.fromMillisecondsSinceEpoch(data["begin"]),
      end: DateTime.fromMillisecondsSinceEpoch(data["end"]),
      created: DateTime.fromMillisecondsSinceEpoch(data["created"]),
      isCompleted: data["is_completed"] == 1,
      level: data["level"],
    );
  }

  static ScheduleData toMap(final Schedule entity) {
    return {
      "id": entity.id,
      "title": entity.title,
      "description": entity.description,
      "begin": entity.begin.millisecondsSinceEpoch,
      "end": entity.end.millisecondsSinceEpoch,
      "created": entity.created.millisecondsSinceEpoch,
      "is_completed": entity.isCompleted ? 1 : 0,
      "level": entity.level
    };
  }

  static List<Schedule> toEntities(final List<ScheduleData> datas) {
    return datas.map((data) => ScheduleMapper.toEntity(data)).toList();
  }

  static List<ScheduleData> toMaps(final List<Schedule> scheduls) =>
      scheduls.map((value) => ScheduleMapper.toMap(value)).toList();
}
