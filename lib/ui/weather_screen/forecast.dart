import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/one_call/OneCallResponse.dart';
import 'package:flutter_weather/redux/state/AppState.dart';
import 'package:provider/provider.dart';

import '../week_day_tile.dart';

class Forecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<WeatherState>(context, listen: false);
    var weatherResponse = StoreProvider.of<AppState>(context).state
        .currentWeatherState.weatherResponse;
    var lat = weatherResponse.coord.lat;
    var lon = weatherResponse.coord.lon;
    Future<OneCallResponse> onCallFuture =
        appState.getOneCallResponse(lat, lon);
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
