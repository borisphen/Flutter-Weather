import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/bloc_provider.dart';
import 'package:flutter_weather/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weather/bloc/forecast/forecast_weather_event.dart';
import 'package:flutter_weather/bloc/forecast/weather_forecast_bloc.dart';
import 'package:flutter_weather/model/one_call/OneCallResponse.dart';

import '../week_day_tile.dart';

class Forecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<WeatherState>(context, listen: false);
    var currentWeatherBloc = BlocProvider.of<CurrentWeatherBloc>(context);
    var weatherForecastBloc = BlocProvider.of<WeatherForecastBloc>(context);
    var lat = currentWeatherBloc.data.coord.lat;
    var lon = currentWeatherBloc.data.coord.lon;

    weatherForecastBloc.putEvent(WeekForecastEvent(lat, lon));
    // Future<OneCallResponse> onCallFuture =
    //     appState.getOneCallResponse(lat, lon);
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
          StreamBuilder<OneCallResponse>(
            stream: weatherForecastBloc.stateStream,
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
