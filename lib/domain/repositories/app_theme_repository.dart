abstract class AppThemeRepository {
  Future<int?> getAppThemeId();
  Future<void> setAppThemeId(int id);
  Future<void> removeAppThemeId();
}
