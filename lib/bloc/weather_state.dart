import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_response_model.dart';
import 'package:flutter_weather/persistance/repository.dart';

class WeatherState extends ChangeNotifier {
  WeatherResponse weatherResponse;
  final Repository _repository = Repository();

  fetchWeather() async {
    weatherResponse = await _repository.fetchLondonWeather();
    notifyListeners();
  }
}

final weatherProvider = WeatherState();