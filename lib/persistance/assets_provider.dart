import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_weather/model/city/cities_model.dart';

class AssetsProvider {
  Future<CitiesModel> loadCitiesList() async {
    var citiesString =  await rootBundle.loadString('assets/city.list.json');
    print('cities ----> $citiesString');
    var citiesModel = CitiesModel.fromJsonString(citiesString);
    return citiesModel;
  }
}