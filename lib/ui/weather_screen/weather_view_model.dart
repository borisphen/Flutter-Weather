import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/redux/state/AppState.dart';
import 'package:flutter_weather/redux/thunks/thunk_actions.dart';
import 'package:redux/redux.dart';

class WeatherViewModel {
  final bool isLoading;
  final bool loginError;
  final WeatherResponse weatherResponse;

  // final Function() getWeather;

  WeatherViewModel({this.isLoading, this.loginError, this.weatherResponse,
      /*this.getWeather*/});

  static WeatherViewModel fromStore(Store<AppState> store) {
    return WeatherViewModel(
      isLoading: store.state.currentWeatherState.isLoading,
      loginError: store.state.currentWeatherState.loginError,
      weatherResponse: store.state.currentWeatherState.weatherResponse,
      // getWeather: () {
      //   store.dispatch(getCurrentWeather());
      // },
    );
  }
}