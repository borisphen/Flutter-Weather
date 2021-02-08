import 'dart:async';

import 'package:flutter_weather/model/one_call/OneCallResponse.dart';
import 'package:flutter_weather/persistance/repository.dart';

import '../bloc.dart';
import 'forecast_weather_event.dart';

class WeatherForecastBloc extends Bloc<WeekForecastEvent, OneCallResponse> {

  WeatherForecastBloc() : super();

  Future<OneCallResponse> getOneCallResponse(double lat, double lon) =>
      repository.getOneCallResponse(lat, lon);

  @override
  Future<OneCallResponse> retrieveData(WeekForecastEvent event) =>
      getOneCallResponse(event.lat, event.lon);
}
