import 'package:today_mate_clean/core/errors/exceptions.dart';
import 'package:today_mate_clean/core/errors/failures.dart';
import 'package:today_mate_clean/data/datasources/local/app_theme_preference.dart';
import 'package:today_mate_clean/domain/repositories/app_theme_repository.dart';

class AppThemeRepositoryImpl implements AppThemeRepository {
  final AppThemePreference appThemePreference;
  AppThemeRepositoryImpl({
    required this.appThemePreference,
  });
  @override
  Future<int?> getAppThemeId() async {
    try {
      return await appThemePreference.getAppThemeId();
    } on CacheException catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<void> removeAppThemeId() async {
    try {
      await appThemePreference.removeAppThemeId();
    } on CacheException catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<void> setAppThemeId(int id) async {
    try {
      await appThemePreference.setAppThemeId(id: id);
    } on CacheException catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }
}
