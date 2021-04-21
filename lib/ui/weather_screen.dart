import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/bloc/weather_bloc.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/providers/current_weather/current_weather_view_model.dart';
import 'package:flutter_weather/ui/weather_screen/coordinates.dart';
import 'package:flutter_weather/ui/weather_screen/forecast.dart';
import 'package:flutter_weather/ui/weather_screen/main_weather_data.dart';
import 'package:flutter_weather/ui/weather_screen/sys_info.dart';
import 'package:flutter_weather/ui/weather_screen/wind_info.dart';

class WeatherScreen extends StatefulWidget {

  @override
  WeatherScreenState createState() => WeatherScreenState(watch);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class WeatherScreenState extends State<WeatherScreen> {
  ScopedReader watch;

  WeatherScreenState(this.watch);

  @override
  void initState() {
    super.initState();
    final weatherProvider = Provider.of<WeatherState>(context, listen: false);
    weatherProvider.getCurrentLocation();
    // weatherProvider.loadCitiesList();
    load();
  }

  @override
  void dispose() {
    super.dispose();
    weatherBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final weatherResponse = watch(currentWeatherViewModelProvider).weatherResponse;
      if (weatherResponse != null) {
        return _buildWeatherScreen(weatherResponse);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  SingleChildScrollView _buildWeatherScreen(WeatherResponse data) {
    var titleColor = Theme.of(context).accentColor;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(data.name, titleColor),
            Coordinates(),
            MainWeatherData(),
            WindInfo(),
            SysInfo(),
            Forecast(),
          ],
        ),
      ),
    );
  }

  Center _buildTitle(String name, Color titleColor) {
    return Center(
      child: Text(
        "Weather in " + name,
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      ),
    );
  }
}

load() async {
  await compute(loadCitiesList(), null);
}

loadCitiesList() async {
  var _repository = Repository();
  bool isDbHasCities = await _repository.isCityTableNotEmpty();
  if (!isDbHasCities) {
    await _repository
        .loadCitiesList()
        .then((value) => _repository.insertCities(value));
  }
}
