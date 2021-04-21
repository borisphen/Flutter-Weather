import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/model/one_call/OneCallResponse.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/providers/repository_provider.dart';

final forecastProvider = StateNotifierProvider<ForecastViewModel, OneCallResponse>((ref) {
  final Repository repository = ref.watch(repositoryProvider);
  return ForecastViewModel(repository);
});

class ForecastViewModel extends StateNotifier<OneCallResponse> {
  final Repository _repository;

  ForecastViewModel(this._repository): super(null);

  Future<OneCallResponse> getOneCallResponse(double lat, double lon) =>
      _repository.getOneCallResponse(lat, lon);
}