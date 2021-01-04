import 'package:shared_preferences/shared_preferences.dart';

class PrefsProvider {
  static const CURRENT_PLACE_CODE = 'CURRENT_PLACE_CODE';

  saveCurrentPlaceCode(int code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(CURRENT_PLACE_CODE, code);
  }

  Future<int> getCurrentPlaceCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(CURRENT_PLACE_CODE) ?? 0;
  }

}