import 'package:flutter_weather/model/city/coord_model.dart';

class CityModel {
  dynamic id;
  String name;
  String state;
  String country;
  CoordModel coordModel;

  CityModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    try {
      id = parsedJson['id'];
      name = parsedJson['name'];
      state = parsedJson['state'];
      country = parsedJson['country'];
      coordModel = CoordModel(parsedJson['coord']);
    } catch (e) {
      print(e.toString());
    }
  }
}