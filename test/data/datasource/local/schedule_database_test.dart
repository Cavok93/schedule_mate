import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:today_mate_clean/data/datasources/local/schedule_database.dart';
import 'package:today_mate_clean/data/mappers/schedule_mapper.dart';
import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';

void main() {
  test("db test", () async {
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    const tableName = 'schedule_table';
    const columnId = 'id';
    const columnTitle = 'title';
    const columnDescription = 'description';
    const columnBegin = 'begin';
    const columnEnd = 'end';
    const columnCreated = 'created';
    const columnIsCompleted = 'is_completed';
    const columnLevel = 'level';
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnTitle TEXT,$columnDescription TEXT,$columnBegin INTEGER,$columnEnd INTEGER,$columnCreated INTEGER,$columnIsCompleted INTEGER,$columnLevel INTEGER)");
    final scheduleDataBase = ScheduleDataBase(testDatabase: db);
    final schduleEntity = Schedule(
        title: "",
        description: "",
        begin: DateTime.now(),
        end: DateTime.now(),
        created: DateTime.now(),
        isCompleted: false,
        level: 1);
    await scheduleDataBase.insertSchedule(ScheduleMapper.toMap(schduleEntity));
    final targetEntity =
        ScheduleMapper.toEntities(await scheduleDataBase.getSchedules());
    await scheduleDataBase.deleteSchedule(targetEntity.first.id ?? 0);
    expect((await scheduleDataBase.getSchedules()).length, 0);
    await db.close();
  });
}
