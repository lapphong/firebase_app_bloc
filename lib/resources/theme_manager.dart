import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  Future<void> saveTheme(bool themeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKey.modeLevel, themeName);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool(PrefsKey.modeLevel);
    return result ?? true;
  }
}
