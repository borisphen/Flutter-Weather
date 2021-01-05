import 'package:flutter/material.dart';
import 'package:flutter_weather/model/city/city_model.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:geolocator/geolocator.dart';

class WeatherState extends ChangeNotifier {
  WeatherResponse weatherResponse;
  Position currentPosition;
  CityModel selectedCity;
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

  selectCity(CityModel cityModel) {
    selectedCity = cityModel;
    notifyListeners();
  }

  Future<int> getCurrentPlaceCode() => _repository.getCurrentPlaceCode();

  saveCurrentPlaceCode(int code) => _repository.saveCurrentPlaceCode(code);

  Future<List<CityModel>> getCitiesList() => _repository.loadCitiesList();
}

final weatherProvider = WeatherState();
