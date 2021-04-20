import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/model/city/city_model.dart';
import 'package:flutter_weather/persistance/model/city.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/providers/repository_provider.dart';

final citiesAssetsProvider = StateNotifierProvider<CitiesAssetsViewModel, List<CityModel>>((ref) {
  final Repository repository = ref.watch(repositoryProvider);
  return CitiesAssetsViewModel(repository);
});

class CitiesAssetsViewModel extends StateNotifier<List<CityModel>> {
  final Repository _repository;
  List<City> cities = [];

  CitiesAssetsViewModel(this._repository): super([]);

  Future<List<CityModel>> getCitiesList() => _repository.loadCitiesList();

}