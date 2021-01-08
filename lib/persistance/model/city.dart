import 'package:flutter_weather/model/city/coord_model.dart';

class City {
  int id;
  String name;
  String state;
  String country;
  double lon;
  double lat;

  City.fromMap(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    try {
      //several ids are double
      id = parsedJson['id'];
      name = parsedJson['name'];
      state = parsedJson['state'];
      country = parsedJson['country'];
      lat = parsedJson['lat'];
      lon = parsedJson['lon'];
    } catch (e) {
      print(e.toString());
    }
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "state": state,
    "country": country,
    "lat": lat,
    "lon": lon,
  };
}