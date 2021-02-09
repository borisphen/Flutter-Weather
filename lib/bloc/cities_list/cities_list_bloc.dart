import 'dart:async';

import 'package:flutter_weather/bloc/cities_list/get_cities_list_event.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/repository.dart';

import '../bloc.dart';

class CitiesListBloc
    extends Bloc<GetCitiesListEvent, List<WeatherResponse>> {

  Future<List<WeatherResponse>> _getFavoriteWeathers() =>
      repository.getFavoriteWeathers();

  @override
  Future<List<WeatherResponse>> retrieveData(GetCitiesListEvent event) =>
      _getFavoriteWeathers();

  removeFavoriteCityById(int id) async {
    bool success = await repository.removeFavoriteCityById(id);
    mapEventToState(GetCitiesListEvent());
  }
}
