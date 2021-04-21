import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/model/one_call/OneCallResponse.dart';
import 'package:flutter_weather/providers/forecast_view_model.dart';

import 'file:///D:/Bender/Development/Projects/flutter_weather/lib/providers/current_weather/current_weather_view_model.dart';

import '../week_day_tile.dart';

class Forecast extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final weatherResponse = watch(currentWeatherViewModelProvider).weatherResponse;
    var lat = weatherResponse.coord.lat;
    var lon = weatherResponse.coord.lon;
    final onCallFuture = watch(forecastProvider.notifier).getOneCallResponse(lat, lon);
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Week forecast",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          FutureBuilder<OneCallResponse>(
            future: onCallFuture,
            builder: (BuildContext context,
                    AsyncSnapshot<OneCallResponse> snapshot) =>
                ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.black,
              ),
              itemCount:
                  (snapshot.data != null) ? snapshot.data.daily.length + 2 : 0,
              itemBuilder: (context, index) {
                var weekData = snapshot.data.daily;
                if (index == 0 || index == weekData.length + 1) {
                  return Container();
                }
                final weather = weekData[index - 1];
                return WeekTile(
                  key: ValueKey(weather.weather[0].id),
                  weather: weather,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
