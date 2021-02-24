import 'package:flutter/widgets.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';

@immutable
class CurrentWeatherState {
  final bool isLoading;
  final bool loginError;
  final WeatherResponse weatherResponse;

  CurrentWeatherState({@required this.isLoading, @required this.loginError, @required this
      .weatherResponse});

  factory CurrentWeatherState.initial() {
    return new CurrentWeatherState(isLoading: false, loginError: false, weatherResponse: null);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentWeatherState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          loginError == other.loginError &&
          weatherResponse == other.weatherResponse;

  @override
  int get hashCode =>
      isLoading.hashCode ^ loginError.hashCode ^ weatherResponse.hashCode;

  CurrentWeatherState copyWith({
    bool isLoading,
    bool loginError,
    WeatherResponse weatherResponse,
  }) {
    if ((isLoading == null || identical(isLoading, this.isLoading)) &&
        (loginError == null || identical(loginError, this.loginError)) &&
        (weatherResponse == null ||
            identical(weatherResponse, this.weatherResponse))) {
      return this;
    }

    return new CurrentWeatherState(
      isLoading: isLoading ?? this.isLoading,
      loginError: loginError ?? this.loginError,
      weatherResponse: weatherResponse ?? this.weatherResponse,
    );
  }
}