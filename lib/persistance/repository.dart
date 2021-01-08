import 'package:flutter_weather/model/city/cities_model.dart';
import 'package:flutter_weather/model/city/city_model.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/assets_provider.dart';
import 'package:flutter_weather/persistance/db_provider.dart';
import 'package:flutter_weather/persistance/prefs_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'api_provider.dart';

class Repository {
  ApiProvider _appApiProvider = ApiProvider();
  PrefsProvider _prefsProvider = PrefsProvider();
  AssetsProvider _assetsProvider = AssetsProvider();
  DbProvider _dbProvider = DbProvider();

  // Future<WeatherResponse> fetchLondonWeather() =>
  //     appApiProvider.fetchLondonWeather();

  Future<WeatherResponse> fetchWeatherByLocation(double latitude, double longitude) =>
      _appApiProvider.fetchWeatherByLocation(latitude, longitude);

  Future<int> getCurrentPlaceCode() => _prefsProvider.getCurrentPlaceCode();

  saveCurrentPlaceCode(int code) => _prefsProvider.saveCurrentPlaceCode(code);

  Future<List<CityModel>> loadCitiesList() => _assetsProvider.loadCitiesList();

  insertCities(List<CityModel> citiesList) {
    _dbProvider.insertCities(citiesList);
  }

  Future<bool> isCityTableNotEmpty() => _dbProvider.isCityTableNotEmpty();
}
