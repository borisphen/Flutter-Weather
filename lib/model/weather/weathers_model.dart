
import 'package:flutter_weather/model/weather/weather_response_model.dart';

class WeathersModel {
  List<WeatherResponse> weathersModels;

  WeathersModel.fromJson(Map<String, dynamic> parsedJson) {
    List<WeatherResponse> weathers = [];
    var weathersString = parsedJson['list'] as List;
    weathersString.forEach((element) {
      var weather = WeatherResponse.fromJson(element);
      weathers.add(weather);
    });
    weathersModels = weathers;
  }
}