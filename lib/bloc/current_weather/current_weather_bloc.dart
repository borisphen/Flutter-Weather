import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/model/web/location/WebLocationResponse.dart';
import 'package:flutter_weather/persistance/model/city.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:geolocator/geolocator.dart';

import '../bloc.dart';
import 'get_current_weather_event.dart';

class CurrentWeatherBloc extends Bloc<GetCurrentWeatherEvent, WeatherResponse> {
  String getIconUrl(String icon) => repository.getIconUrl(icon);

  Future<WeatherResponse> _getCurrentLocation() async {
    if (kIsWeb) {
      WebLocationResponse webLocationResponse =
          await repository.getWebLocation();
      var weatherResponse = await _getWeatherByPosition(
          webLocationResponse.latitude, webLocationResponse.longitude);
      return weatherResponse;
    } else {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      return geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) async {
        var weatherResponse =
            await _getWeatherByPosition(position.latitude, position.longitude);
        return weatherResponse;
      });
    }
  }

  Future<WeatherResponse> _getWeatherByPosition(double lat, double lon) async {
    return repository.fetchWeatherByLocation(lat, lon);
  }

  @override
  Future<WeatherResponse> retrieveData(GetCurrentWeatherEvent event) =>
      _getCurrentLocation();

  void setFavoriteCity(City city) async {
    data = await _getWeatherByPosition(city.lat, city.lon);
    city.favorite = true;
    repository.updateCity(city);
    inEvent.add(data);
  }

  setFavoriteCityById(int id) async {
    var city = await repository.getCityById(id);
    if (city != null) {
      data = await _getWeatherByPosition(city.lat, city.lon);
      city.favorite = true;
      repository.updateCity(city);
      inEvent.add(data);
    }
  }

  Future<List<City>> getSuggestions(String query) {
    if (query != null && query.isNotEmpty) {
      return repository.getCitiesByKeyWord(query);
    } else {
      return Future.value([]);
    }
  }
}