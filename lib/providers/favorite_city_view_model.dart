import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/persistance/model/city.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/providers/repository_provider.dart';

final favoriteCityViewModelProvider = StateNotifierProvider<FavoriteCityViewModel, City>((ref) {
  final Repository repository = ref.watch(repositoryProvider);
  return FavoriteCityViewModel(repository);
});

class FavoriteCityViewModel extends StateNotifier<City> {
  final Repository _repository;

  FavoriteCityViewModel(this._repository)
      : super(null);


  setFavoriteCity(City city) async {
    final weatherResponse = await _repository.fetchWeatherByLocation(city.lat, city.lon);
    city.favorite = true;
    _repository.updateCity(city);
  }


}
