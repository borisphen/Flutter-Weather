import 'dart:convert';

import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/model/weather/weathers_model.dart';
import 'package:http/http.dart' show Client;

import '../main.dart';

const _apiKey = 'b4f1ce98c8299eae7983989d138f01ab';
final _baseUrl = "https://api.openweathermap.org";

final _baseHttpsUrl = "api.openweathermap.org";
final _weatherPath = '/data/2.5/weather';
final _groupPath = '/data/2.5/group';
final _iconPath = '/img/w/';

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

  String _getWeatherUrlByLocation(double latitude, double longitude) {
    var queryParameters = {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'units': 'metric',
      'appid': _apiKey,
    };
    var uri = Uri.https(_baseHttpsUrl, _weatherPath, queryParameters);
    print('Constructed ===========================> ${uri.toString()}');
    return uri.toString();
  }

  Future<WeatherResponse> fetchWeatherByLocation(
      double latitude, double longitude) async {
    final response =
        await client.get(_getWeatherUrlByLocation(latitude, longitude));
    logger.d(response.body.toString());

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<List<WeatherResponse>> getWeatherByCitiesIds(List<int> ids) async {
    String idsSeparated = ids.join(',');
    var queryParameters = {
      'id': idsSeparated,
      'units': 'metric',
      'appid': _apiKey,
    };
    var uri = Uri.https(_baseHttpsUrl, _groupPath, queryParameters);
    print('Constructed ===========================> ${uri.toString()}');
    final response = await client.get(uri.toString());
    logger.d(response.body.toString());

    if (response.statusCode == 200) {
      return WeathersModel.fromJson(json.decode(response.body))
          .weathersModels;
    } else {
      return null;
    }
  }

  String getIconUrl(String icon) {
    return "$_baseUrl$_iconPath$icon.png";
  }
}
