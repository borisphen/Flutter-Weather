import 'dart:convert';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' show Client;

const _apiKey = 'b4f1ce98c8299eae7983989d138f01ab';
final _baseUrl = "https://api.openweathermap.org";

final _baseHttpsUrl = "api.openweathermap.org";
final dataPath = '/data/2.5/weather';

class ApiProvider {
  Client client = Client();
  // final url = "$_baseUrl/data/2.5/weather?q=Kharkiv,UA&appid=b4f1ce98c8299eae7983989d138f01ab";


  // Future<WeatherResponse> fetchLondonWeather() async {
  //   final response = await client.get("$url");
  //   print(response.body.toString());
  //
  //   if (response.statusCode == 200) {
  //     return WeatherResponse.fromJson(json.decode(response.body));
  //   } else {
  //     return null;
  //   }
  // }

  // Map<String, String> getQueryParams() {
  //   var queryParameters = {
  //     'param1': 'one',
  //     'param2': 'two',
  //   };
  // }

  String _getWeatherUrlByLocation(Position position) {
      var queryParameters = {
        'lat': position.latitude.toString(),
        'lon': position.longitude.toString(),
        'appid': _apiKey,
      };
      var uri = Uri.https(_baseHttpsUrl, dataPath, queryParameters);
      print('Constructed ===========================> ${uri.toString()}');
      return uri.toString();
  }

  Future<WeatherResponse> fetchWeatherByLocation(Position position) async {
    final response = await client.get(_getWeatherUrlByLocation(position));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}