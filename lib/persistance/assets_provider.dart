import 'dart:async' show Future;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_weather/model/city/cities_model.dart';
import 'package:flutter_weather/model/city/city_model.dart';

class AssetsProvider {
  Future<List<CityModel>> loadCitiesList() async {
    var citiesString =  await rootBundle.loadString('assets/city.list.json');
    print('cities ----> $citiesString');
    var citiesModel = CitiesModel.fromJsonString(citiesString);
    return citiesModel.citiesModels;
  }
}