class CoordModel {
  double lon;
  double lat;

  CoordModel(parsedJson) {
    lon = parsedJson['lon'] * 1.0;
    lat = parsedJson['lat'] * 1.0;
  }
}