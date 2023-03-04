import 'package:today_mate_clean/data/datasources/local/app_theme_preference.dart';
import 'package:today_mate_clean/domain/repositories/app_theme_repository.dart';

class AppThemeRepositoryImpl implements AppThemeRepository {
  final AppThemePreference appThemePreference;
  AppThemeRepositoryImpl({
    required this.appThemePreference,
  });
  @override
  Future<int?> getAppThemeId() async {
    return await appThemePreference.getAppThemeId();
  }

  @override
  Future<void> removeAppThemeId() async {
    await appThemePreference.removeAppThemeId();
  }

  @override
  Future<void> setAppThemeId(int id) async {
    await appThemePreference.setAppThemeId(id: id);
  }
}
