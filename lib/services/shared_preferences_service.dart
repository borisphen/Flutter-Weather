import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/persistance/prefs_provider.dart';

final sharedPreferencesServiceProvider =
Provider<SharedPreferencesService>((ref) => throw UnimplementedError());

class SharedPreferencesService {
  SharedPreferencesService(this._prefsProvider);
  final PrefsProvider _prefsProvider;

  Future<int> getCurrentPlaceCode() => _prefsProvider.getCurrentPlaceCode();

  saveCurrentPlaceCode(int code) => _prefsProvider.saveCurrentPlaceCode(code);
}
