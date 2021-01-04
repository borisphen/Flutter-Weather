import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  Repository _repository = Repository();

  final _weatherFetcher = PublishSubject<WeatherResponse>();

  Observable<WeatherResponse> get weather => _weatherFetcher.stream;

  // fetchLondonWeather() async {
  //   WeatherResponse weatherResponse = await _repository.fetchLondonWeather();
  //   _weatherFetcher.sink.add(weatherResponse);
  // }

  dispose() {
    _weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();