import 'package:shared_preferences/shared_preferences.dart';

class PrefsProvider {
  static const CURRENT_PLACE_CODE = 'CURRENT_PLACE_CODE';
  static const CURRENT_THEME = 'CURRENT_THEME';

  saveCurrentPlaceCode(int code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(CURRENT_PLACE_CODE, code);
  }

  Future<int> getCurrentPlaceCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(CURRENT_PLACE_CODE) ?? 0;
  }

  saveCurrentTheme(bool isLight) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(CURRENT_THEME, isLight);
  }

  Future<bool> getCurrentTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(CURRENT_THEME) ?? true;
  }

}