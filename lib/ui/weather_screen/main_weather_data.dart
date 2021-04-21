
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'file:///D:/Bender/Development/Projects/flutter_weather/lib/providers/current_weather/current_weather_view_model.dart';

class MainWeatherData extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentWeatherViewModel = watch(currentWeatherViewModelProvider.notifier);
    final weatherResponse = watch(currentWeatherViewModelProvider).weatherResponse;
    var weather = weatherResponse.weather[0];
    var main = weatherResponse.main;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Main",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 4.0),
                child: Hero(
                    tag: '${weatherResponse.id}',
                    child: Image.network(currentWeatherViewModel.getIconUrl(weather.icon)))),
            Text("Temperature: " + weatherResponse.main.temp.toString()),
          ],
        ),
        Text("Pressure: " + main.pressure.toString()),
        Text("Humidity: " + main.humidity.toString()),
        Text("Highest temperature: " + main.tempMax.toString()),
        Text("Lowest temperature: " + main.tempMin.toString()),
      ],
    );
  }

}