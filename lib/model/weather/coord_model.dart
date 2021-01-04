
class Coord {
  double _lon;
  double _lat;

  Coord(parsedJson) {
    _lon = parsedJson['lon'] * 1.0;
    _lat = parsedJson['lat'] * 1.0;
  }

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
  }

  double get lon => _lon;

  set lon(double value) {
    _lon = value;
  }
}