import 'package:flutter_weather/main.dart';

class City {
  int id;
  String name;
  String state;
  String country;
  double lon;
  double lat;
  bool favorite;

  City.fromMap(Map<String, dynamic> map) {
    print(map);
    try {
      //several ids are double
      id = map['id'];
      name = map['name'];
      state = map['state'];
      country = map['country'];
      lat = map['lat'];
      lon = map['lon'];
      favorite = map['favorite'] == 1 ? true : false;
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "state": state,
    "country": country,
    "lat": lat,
    "lon": lon,
    "favorite": favorite,
  };
}