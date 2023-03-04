import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../../models/schedule_data.dart';

class ScheduleDataBase {
  static const _databaseName = 'schedule_database';
  static const _tableName = 'schedule_table';
  static const _databaseVersion = 1;
  static const _columnId = 'id';
  static const _columnTitle = 'title';
  static const _columnDescription = 'description';
  static const _columnBegin = 'begin';
  static const _columnEnd = 'end';
  static const _columnCreated = 'created';
  static const _columnIsCompleted = 'is_completed';
  static const _columnLevel = 'level';
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<List<ScheduleData>> getSchedules() async {
    final db = await database;
    return db.query(_tableName);
  }

  Future<ScheduleData> insertSchedule(final ScheduleData scheduleData) async {
    final db = await database;
    late final ScheduleData scheduleEntity;
    await db.transaction((txn) async {
      final id = await txn.insert(
        _tableName,
        scheduleData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final results =
          await txn.query(_tableName, where: '$_columnId = ?', whereArgs: [id]);
      scheduleEntity = results.first;
    });
    return scheduleEntity;
  }

  Future<void> updateSchedule(final ScheduleData scheduleData) async {
    final db = await database;
    final int id = scheduleData['id'];
    await db.update(
      _tableName,
      scheduleData,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteSchedule(final int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      p.join(await getDatabasesPath(), _databaseName),
      onCreate: (db, _) async {
        await db.execute(
            "CREATE TABLE $_tableName($_columnId INTEGER PRIMARY KEY AUTOINCREMENT,$_columnTitle TEXT,$_columnDescription TEXT,$_columnBegin INTEGER,$_columnEnd INTEGER,$_columnCreated INTEGER,$_columnIsCompleted INTEGER,$_columnLevel INTEGER)");
      },
      version: _databaseVersion,
    );
  }
}
