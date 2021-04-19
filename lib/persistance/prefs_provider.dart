import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
Provider<PrefsProvider>((ref) => throw UnimplementedError());

class PrefsProvider {
  static const CURRENT_PLACE_CODE = 'CURRENT_PLACE_CODE';
  static const CURRENT_THEME = 'CURRENT_THEME';

  final SharedPreferences sharedPreferences;

  PrefsProvider(this.sharedPreferences);

  saveCurrentPlaceCode(int code) async {
    sharedPreferences.setInt(CURRENT_PLACE_CODE, code);
  }

  Future<int> getCurrentPlaceCode() async {
    return sharedPreferences.getInt(CURRENT_PLACE_CODE) ?? 0;
  }

  saveCurrentTheme(bool isLight) async {
    sharedPreferences.setBool(CURRENT_THEME, isLight);
  }

  Future<bool> getCurrentTheme() async {
    return sharedPreferences.getBool(CURRENT_THEME) ?? true;
  }

}