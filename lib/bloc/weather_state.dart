import 'package:flutter/material.dart';
import 'package:flutter_weather/model/city/city_model.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/model/city.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:geolocator/geolocator.dart';

class WeatherState extends ChangeNotifier {
  WeatherResponse weatherResponse;
  Position currentPosition;
  City selectedCity;
  List<CityModel> favoriteCities;
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
      weatherResponse =
          await _getWeatherByPosition(position.latitude, position.longitude);
      notifyListeners();
    });
  }

  Future<WeatherResponse> _getWeatherByPosition(double lat, double lon) async {
    return _repository.fetchWeatherByLocation(lat, lon);
  }

  selectCity(City city) async {
    selectedCity = city;
    weatherResponse = await _getWeatherByPosition(
        city.lat, city.lon);
    city.favorite = true;
    _repository.updateCity(city);
    notifyListeners();
  }

  loadCitiesList() async {
    bool isDbHasCities = await _repository.isCityTableNotEmpty();
    if (!isDbHasCities) {
      await _repository.loadCitiesList().then((value) =>
          _repository.insertCities(value));
    }
  }

  Future<List<City>> getSuggestions(String query) {
    if (query != null && query.isNotEmpty) {
      return _repository.getCitiesByKeyWord(query);
    } else {
      return Future.value([]);
    }
  }
/*  {
    // List<CityModel> matches = [];
    // matches.addAll(cities);
    // matches
    //     .retainWhere((s) => s.name.toLowerCase().contains(query.toLowerCase()));
    // return matches;

  }*/

  Future<int> getCurrentPlaceCode() => _repository.getCurrentPlaceCode();

  saveCurrentPlaceCode(int code) => _repository.saveCurrentPlaceCode(code);

  Future<List<CityModel>> getCitiesList() => _repository.loadCitiesList();

  Future<bool> isCityTableNotEmpty() => _repository.isCityTableNotEmpty();

  Future<List<City>> getFavoriteCities() => _repository.getFavoriteCities();

  Future<List<WeatherResponse>> getFavoriteWeathers() => _repository.getFavoriteWeathers();

  String getIconUrl(String icon) => _repository.getIconUrl(icon);
}

// final weatherProvider = WeatherState();
