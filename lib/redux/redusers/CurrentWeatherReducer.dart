import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/redux/actions/CurrentWeatherActions.dart';
import 'package:flutter_weather/redux/state/AppState.dart';
import 'package:flutter_weather/redux/state/AppState.dart';
import 'package:redux/redux.dart';



  final appReducer = combineReducers<AppState>([
    TypedReducer<AppState, WeatherResponseAction>(
        _weatherResponseReceived),
    TypedReducer<AppState, WeatherErrorAction>(_weatherError),
    TypedReducer<AppState, StartLoadingAction>(_startLoading),
  ]);


AppState _weatherResponseReceived(AppState state,
    WeatherResponseAction action) {
  var newWeatherState = state.currentWeatherState.copyWith(weatherResponse: action
      .weatherResponse,
      isLoading: false,
      loginError: false);
  return state.copyWith(currentWeatherState: newWeatherState);
}

AppState _weatherError(AppState state,
    WeatherErrorAction action) {
  var newWeatherState =  state.currentWeatherState.copyWith(
      weatherResponse: null, isLoading: false, loginError: true);
  return state.copyWith(currentWeatherState: newWeatherState);
}

AppState _startLoading(AppState state,
    StartLoadingAction action) {
  var newWeatherState =  state
    .currentWeatherState.copyWith(isLoading: true, loginError: false);
  return state.copyWith(currentWeatherState: newWeatherState);
}
