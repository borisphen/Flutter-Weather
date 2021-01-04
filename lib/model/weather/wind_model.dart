
class Wind {
  int _deg;
  double _speed;

  Wind(parsedJson) {
    _deg = parsedJson['deg'];
    _speed = parsedJson['speed'] * 1.0;
  }

  int get deg => _deg;

  set deg(int value) {
    _deg = value;
  }

  double get speed => _speed;

  set speed(double value) {
    _speed = value;
  }
}
