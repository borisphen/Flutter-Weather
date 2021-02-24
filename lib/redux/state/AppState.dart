import 'package:flutter/widgets.dart';
import 'package:flutter_weather/redux/state/CurrentWeatherState.dart';

@immutable
class AppState {
    final CurrentWeatherState currentWeatherState;

    const AppState({
    @required this.currentWeatherState,
  });

    factory AppState.initial() {
      return AppState(
        currentWeatherState: CurrentWeatherState.initial(),
      );
    }

    AppState copyWith({
    CurrentWeatherState currentWeatherState,
  }) {
    if ((currentWeatherState == null ||
        identical(currentWeatherState, this.currentWeatherState))) {
      return this;
    }

    return AppState(
      currentWeatherState: currentWeatherState ?? this.currentWeatherState,
    );
  }

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          currentWeatherState == other.currentWeatherState;

  @override
  int get hashCode => currentWeatherState.hashCode;
}