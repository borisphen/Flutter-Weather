import 'package:flutter_weather/model/city/city_model.dart';
import 'package:flutter_weather/model/one_call/OneCallResponse.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/model/web/location/WebLocationResponse.dart';
import 'package:flutter_weather/persistance/assets_provider.dart';
import 'package:flutter_weather/persistance/db_provider.dart';
import 'package:flutter_weather/persistance/prefs_provider.dart';

import 'api_provider.dart';
import 'model/city.dart';

class Repository {
  ApiProvider _appApiProvider = ApiProvider();
  PrefsProvider _prefsProvider = PrefsProvider();
  AssetsProvider _assetsProvider = AssetsProvider();
  DbProvider _dbProvider = DbProvider();

  // Future<WeatherResponse> fetchLondonWeather() =>
  //     appApiProvider.fetchLondonWeather();

  Future<WeatherResponse> fetchWeatherByLocation(
          double latitude, double longitude) =>
      _appApiProvider.fetchWeatherByLocation(latitude, longitude);

  Future<int> getCurrentPlaceCode() => _prefsProvider.getCurrentPlaceCode();

  saveCurrentPlaceCode(int code) => _prefsProvider.saveCurrentPlaceCode(code);

  Future<List<CityModel>> loadCitiesList() => _assetsProvider.loadCitiesList();

  insertCities(List<CityModel> citiesList) =>
      _dbProvider.insertCities(citiesList);

  Future<List<City>> getCitiesByKeyWord(String keyWord) =>
      _dbProvider.getCitiesByKeyWord(keyWord);

  Future<bool> isCityTableNotEmpty() => _dbProvider.isCityTableNotEmpty();

  Future<List<City>> getFavoriteCities() => _dbProvider.getFavoriteCities();

  Future<int> updateCity(City city) => _dbProvider.updateCity(city);

  Future<bool> removeFavoriteCityById(int id) =>
      _dbProvider.removeFavoriteCityById(id);

  Future<List<WeatherResponse>> getFavoriteWeathers() async {
    List<City> favoriteCities = await getFavoriteCities();
    return _appApiProvider
        .getWeatherByCitiesIds(_getCitiesIdsList(favoriteCities));
  }

  List<int> _getCitiesIdsList(List<City> cities) {
    var ids = <int>[];
    cities.forEach((element) {
      ids.add(element.id);
    });
    return ids;
  }

  String getIconUrl(String icon) => _appApiProvider.getIconUrl(icon);

  Future<City> getCityById(int id) => _dbProvider.getCityById(id);

  Future<OneCallResponse> getOneCallResponse(double lat, double lon) =>
      _appApiProvider.getOneCallResponse(lat, lon);

  saveCurrentTheme(bool isLight) => _prefsProvider.saveCurrentTheme(isLight);

  Future<bool> getCurrentTheme() => _prefsProvider.getCurrentTheme();

  Future<WebLocationResponse> getWebLocation() => _appApiProvider.getWebLocation();
}
