import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/persistance/prefs_provider.dart';

import 'file:///D:/Bender/Development/Projects/flutter_weather/lib/providers/theme/current_theme_state.dart';

final themeViewModelProvider = StateNotifierProvider<ThemeViewModel, CurrentThemeState>((ref) {
  final PrefsProvider prefsProvider = ref.watch(sharedPreferencesProvider);
  return ThemeViewModel(prefsProvider);
});

class ThemeViewModel extends StateNotifier<CurrentThemeState>{
  final PrefsProvider _prefsProvider;

  ThemeViewModel(this._prefsProvider): super(CurrentThemeState.initial());

  _saveCurrentTheme(bool isLight) => _prefsProvider.saveCurrentTheme(isLight);

  switchTheme() {
    state = state.copyWith(isLightTheme: !state.isLightTheme);
    _saveCurrentTheme(state.isLightTheme);
  }

  initTheme() async {
    var isLightTheme = await _prefsProvider.getCurrentTheme();
    state = state.copyWith(isLightTheme: isLightTheme);
  }

  ThemeMode getCurrentTheme() => state.isLightTheme ? ThemeMode.light : ThemeMode.dark;
}