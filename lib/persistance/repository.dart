import 'package:flutter_weather/model/weather_response_model.dart';
import 'api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<WeatherResponse> fetchLondonWeather() => appApiProvider.fetchLondonWeather();
}