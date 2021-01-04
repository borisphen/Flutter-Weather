import 'package:flutter/material.dart';
import 'package:flutter_weather/model/city/cities_model.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:geolocator/geolocator.dart';

class WeatherState extends ChangeNotifier {
  WeatherResponse weatherResponse;
  Position currentPosition;
  final Repository _repository = Repository();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  // fetchWeather() async {
  //   weatherResponse = await _repository.fetchLondonWeather();
  //   notifyListeners();
  // }

  getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      currentPosition = position;
      weatherResponse = await _repository.fetchWeatherByLocation(position);
      notifyListeners();
    });
  }

  Future<CitiesModel> loadCitiesList() => _repository.loadCitiesList();
}

final weatherProvider = WeatherState();
