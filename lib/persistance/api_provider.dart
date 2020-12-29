import 'dart:convert';
import 'package:flutter_weather/model/weather_response_model.dart';
import 'package:http/http.dart' show Client;

class ApiProvider {
  Client client = Client();
  final _baseUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=Kharkiv,UA&appid=b4f1ce98c8299eae7983989d138f01ab";

  Future<WeatherResponse> fetchLondonWeather() async {
    final response = await client.get("$_baseUrl");
    print(response.body.toString());

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}