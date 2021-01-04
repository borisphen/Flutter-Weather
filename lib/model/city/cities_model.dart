import 'dart:convert';

import 'package:flutter_weather/model/city/city_model.dart';

class CitiesModel {
  List<CityModel> citiesModels;

  CitiesModel.fromJsonString(String jsonString) {
    List<CityModel> cities = [];
    List<dynamic> list = json.decode(jsonString);
    for (int i = 0; i < list.length; i++) {
      CityModel model = CityModel.fromJson(list[i]);
      cities.add(model);
    }
    citiesModels = cities;
  }
}