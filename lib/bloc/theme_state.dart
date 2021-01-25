import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/persistance/repository.dart';

class ThemeState extends ChangeNotifier {
  final Repository _repository = Repository();
  bool isLightTheme = true;

  _saveCurrentTheme(bool isLight) => _repository.saveCurrentTheme(isLight);

  switchTheme() {
    isLightTheme = !isLightTheme;
    _saveCurrentTheme(isLightTheme);
    notifyListeners();
  }

  initTheme() async {
    isLightTheme = await _repository.getCurrentTheme();
  }

  ThemeMode getCurrentTheme() => isLightTheme ? ThemeMode.light : ThemeMode.dark;
}
