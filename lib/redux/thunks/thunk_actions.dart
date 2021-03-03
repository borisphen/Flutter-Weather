import 'package:flutter/foundation.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/model/web/location/WebLocationResponse.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/redux/actions/CurrentWeatherActions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final Repository _repository = Repository();

ThunkAction getCurrentWeather() {
  return (Store store) async {
    store.dispatch(new StartLoadingAction());
      if (kIsWeb) {
        WebLocationResponse webLocationResponse = await _repository.getWebLocation();
        var weatherResponse =
        await _getWeatherByPosition(webLocationResponse.latitude, webLocationResponse.longitude);
        store.dispatch(new WeatherResponseAction(weatherResponse));

      } else {
        final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
        geolocator
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position position) async {
          var weatherResponse =
          await _getWeatherByPosition(position.latitude, position.longitude);
          store.dispatch(new WeatherResponseAction(weatherResponse));
        });
      }
  };
}

Future<WeatherResponse> _getWeatherByPosition(double lat, double lon) async {
  return _repository.fetchWeatherByLocation(lat, lon);
}