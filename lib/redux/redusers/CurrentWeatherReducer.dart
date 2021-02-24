import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/redux/actions/CurrentWeatherActions.dart';
import 'package:flutter_weather/redux/state/AppState.dart';
import 'package:flutter_weather/redux/state/CurrentWeatherState.dart';
import 'package:redux/redux.dart';



  final currentWeatherReducer = combineReducers<CurrentWeatherState>([
    TypedReducer<CurrentWeatherState, WeatherResponseAction>(
        _weatherResponseReceived),
    TypedReducer<CurrentWeatherState, WeatherErrorAction>(_weatherError),
    TypedReducer<CurrentWeatherState, StartLoadingAction>(_startLoading),
  ]);


CurrentWeatherState _weatherResponseReceived(CurrentWeatherState state,
    WeatherResponseAction action) {
  return state.copyWith(weatherResponse: action.weatherResponse,
      isLoading: false,
      loginError: false);
}

CurrentWeatherState _weatherError(CurrentWeatherState state,
    WeatherErrorAction action) {
  return state.copyWith(
      weatherResponse: null, isLoading: false, loginError: true);
}

CurrentWeatherState _startLoading(CurrentWeatherState state,
    StartLoadingAction action) {
  return state.copyWith(isLoading: true, loginError: false);
}
