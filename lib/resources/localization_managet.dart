import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class LocalizationManager {
  static final LocalizationManager _instance = LocalizationManager._internal();
  factory LocalizationManager() => _instance;
  LocalizationManager._internal();

  Future<void> saveLocalization(int lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefsKey.langLevel, lang);
  }

  Future<int> getLocalization() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getInt(PrefsKey.langLevel);
    return result ?? 0;
  }
}
