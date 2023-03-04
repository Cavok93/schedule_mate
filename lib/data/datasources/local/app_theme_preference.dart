import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_mate_clean/configs/constants.dart';

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
    final prefs = await sharedPreferences;
    return prefs.getInt(AppThemeKey.appThemeKey);
  }

  Future<void> setAppThemeId({required int id}) async {
    final prefs = await sharedPreferences;
    await prefs.setInt(AppThemeKey.appThemeKey, id);
  }

  Future<void> removeAppThemeId() async {
    final prefs = await sharedPreferences;
    await prefs.remove(AppThemeKey.appThemeKey);
  }
}
