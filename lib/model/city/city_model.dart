import 'package:flutter_weather/model/city/coord_model.dart';

class CityModel {
  int id;
  String name;
  String state;
  String country;
  CoordModel coordModel;

  CityModel({this.id, this.name, this.state, this.country, this.coordModel});

  factory CityModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return CityModel(
        //several ids are double
        id: (parsedJson['id'] is int)
            ? parsedJson['id']
            : (parsedJson['id'] as double).toInt(),
        name: parsedJson['name'],
        state: parsedJson['state'],
        country: parsedJson['country'],
        coordModel: CoordModel(parsedJson['coord']));
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "state": state,
        "country": country,
        "lat": coordModel.lat,
        "lon": coordModel.lon,
        "favorite": 0,
      };
}
