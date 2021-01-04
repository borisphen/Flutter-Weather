import 'package:flutter_weather/model/city/cities_model.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/assets_provider.dart';
import 'package:flutter_weather/persistance/prefs_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'api_provider.dart';

class Repository {
  ApiProvider _appApiProvider = ApiProvider();
  PrefsProvider _prefsProvider = PrefsProvider();
  AssetsProvider _assetsProvider = AssetsProvider();

  // Future<WeatherResponse> fetchLondonWeather() =>
  //     appApiProvider.fetchLondonWeather();

  Future<WeatherResponse> fetchWeatherByLocation(Position position) =>
      _appApiProvider.fetchWeatherByLocation(position);

  Future<int> getCurrentPlaceCode() => _prefsProvider.getCurrentPlaceCode();

  saveCurrentPlaceCode(int code) => _prefsProvider.saveCurrentPlaceCode(code);

  Future<CitiesModel> loadCitiesList() => _assetsProvider.loadCitiesList();
}
