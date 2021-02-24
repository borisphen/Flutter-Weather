import 'package:flutter_weather/model/weather/weather_response_model.dart';

class StartLoadingAction {
  StartLoadingAction();
}

class WeatherResponseAction {
  final WeatherResponse weatherResponse;

  WeatherResponseAction(this.weatherResponse);
}

class WeatherErrorAction {
  WeatherErrorAction();
}