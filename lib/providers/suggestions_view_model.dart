import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/persistance/model/city.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/providers/repository_provider.dart';

final suggestionsProvider = StateNotifierProvider<SuggestionsViewModel, List<City>>((ref) {
  final Repository repository = ref.watch(repositoryProvider);
  return SuggestionsViewModel(repository);
});

class SuggestionsViewModel extends StateNotifier<List<City>> {
  final Repository _repository;
  List<City> cities = [];

  SuggestionsViewModel(this._repository): super([]);

  Future<List<City>> getSuggestions(String query) async {
    if (query != null && query.isNotEmpty) {
      state = await _repository.getCitiesByKeyWord(query);
    } else {
      state = [];
    }
    return state;
  }

  Future<List<CityModel>> getCitiesList() => _repository.loadCitiesList();

  Future<bool> isCityTableNotEmpty() => _repository.isCityTableNotEmpty();

  Future<List<City>> getFavoriteCities() => _repository.getFavoriteCities();

}