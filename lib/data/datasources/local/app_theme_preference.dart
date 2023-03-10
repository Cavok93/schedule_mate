import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_mate_clean/configs/constants.dart';
import 'package:today_mate_clean/core/errors/exceptions.dart';

class AppThemePreference {
  static SharedPreferences? _sharedPreferences;
  Future<SharedPreferences> get sharedPreferences async {
    _sharedPreferences ??= await _initSharedPreference();
    return _sharedPreferences!;
  }

  Future<SharedPreferences> _initSharedPreference() async {
    return await SharedPreferences.getInstance();
  }

  Future<int?> getAppThemeId() async {
    try {
      final prefs = await sharedPreferences;
      return prefs.getInt(AppThemeKey.appThemeKey);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> setAppThemeId({required int id}) async {
    try {
      final prefs = await sharedPreferences;
      await prefs.setInt(AppThemeKey.appThemeKey, id);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> removeAppThemeId() async {
    try {
      final prefs = await sharedPreferences;
      await prefs.remove(AppThemeKey.appThemeKey);
    } catch (e) {
      throw CacheException();
    }
  }
}
