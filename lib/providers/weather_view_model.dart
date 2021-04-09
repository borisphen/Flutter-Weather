import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/model/web/location/WebLocationResponse.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/providers/repository_provider.dart';
import 'package:geolocator/geolocator.dart';

import 'current_weather_state.dart';

final weatherViewModelProvider = StateNotifierProvider<WeatherViewModel, CurrentWeatherState>((ref) {
  final Repository repository = ref.watch(repositoryProvider);
  return WeatherViewModel(CurrentWeatherState.initial(), repository);
});

class WeatherViewModel extends StateNotifier<CurrentWeatherState> {
  final Repository _repository;

  CurrentWeatherState currentWeatherState;

  WeatherViewModel(this.currentWeatherState, this._repository)
      : super(null);

  getCurrentLocation() async {
    if (kIsWeb) {
      WebLocationResponse webLocationResponse =
          await _repository.getWebLocation();
      WeatherResponse weatherResponse = await _getWeatherByPosition(
          webLocationResponse.latitude, webLocationResponse.longitude);
      state = currentWeatherState.copyWith(weatherResponse: weatherResponse);
    } else {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) async {
        WeatherResponse weatherResponse =
        await _getWeatherByPosition(position.latitude, position.longitude);
        state = currentWeatherState.copyWith(weatherResponse: weatherResponse);
      });
    }
  }

  Future<WeatherResponse> _getWeatherByPosition(double lat, double lon) async {
    return _repository.fetchWeatherByLocation(lat, lon);
  }

  setIsLoading(bool isLoading) {
    state = currentWeatherState.copyWith(isLoading: isLoading);
  }
}