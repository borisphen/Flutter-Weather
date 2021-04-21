import 'package:flutter/foundation.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';

@immutable
class CurrentWeatherState {
  final bool isLoading;
  final bool gotError;
  final WeatherResponse weatherResponse;

  CurrentWeatherState({@required this.isLoading, @required this.gotError, @required this
      .weatherResponse});

  factory CurrentWeatherState.initial() {
    return new CurrentWeatherState(isLoading: false, gotError: false, weatherResponse: null);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CurrentWeatherState &&
              runtimeType == other.runtimeType &&
              isLoading == other.isLoading &&
              gotError == other.gotError &&
              weatherResponse == other.weatherResponse;

  @override
  int get hashCode =>
      isLoading.hashCode ^ gotError.hashCode ^ weatherResponse.hashCode;

  CurrentWeatherState copyWith({
    bool isLoading,
    bool loginError,
    WeatherResponse weatherResponse,
  }) {
    if ((isLoading == null || identical(isLoading, this.isLoading)) &&
        (loginError == null || identical(loginError, this.gotError)) &&
        (weatherResponse == null ||
            identical(weatherResponse, this.weatherResponse))) {
      return this;
    }

    return new CurrentWeatherState(
      isLoading: isLoading ?? this.isLoading,
      gotError: loginError ?? this.gotError,
      weatherResponse: weatherResponse ?? this.weatherResponse,
    );
  }
}