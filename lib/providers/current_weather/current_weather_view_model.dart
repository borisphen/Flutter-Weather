import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/model/web/location/WebLocationResponse.dart';
import 'package:flutter_weather/persistance/model/city.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/providers/repository_provider.dart';
import 'package:geolocator/geolocator.dart';

import 'current_weather_state.dart';

final currentWeatherViewModelProvider = StateNotifierProvider<CurrentWeatherViewModel, CurrentWeatherState>((ref) {
  final Repository repository = ref.watch(repositoryProvider);
  return CurrentWeatherViewModel(repository);
});

class CurrentWeatherViewModel extends StateNotifier<CurrentWeatherState> {
  final Repository _repository;

  CurrentWeatherViewModel(this._repository)
      : super(CurrentWeatherState.initial());

  getCurrentLocation() async {
    if (kIsWeb) {
      WebLocationResponse webLocationResponse =
          await _repository.getWebLocation();
      WeatherResponse weatherResponse = await _getWeatherByPosition(
          webLocationResponse.latitude, webLocationResponse.longitude);
      state = state.copyWith(weatherResponse: weatherResponse);
    } else {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) async {
        WeatherResponse weatherResponse =
        await _getWeatherByPosition(position.latitude, position.longitude);
        state = state.copyWith(weatherResponse: weatherResponse);
      });
    }
  }

  Future<WeatherResponse> _getWeatherByPosition(double lat, double lon) async {
    return _repository.fetchWeatherByLocation(lat, lon);
  }

  setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  setFavoriteCity(City city) async {
    city.favorite = true;
    final weatherResponse = await _getWeatherByPosition(city.lat, city.lon);
    state = state.copyWith(weatherResponse: weatherResponse);
    _repository.updateCity(city);
  }

  String getIconUrl(String icon) => _repository.getIconUrl(icon);
}