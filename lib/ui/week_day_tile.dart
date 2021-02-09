import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/bloc_provider.dart';
import 'package:flutter_weather/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weather/model/one_call/OneCallResponse.dart';
import 'package:flutter_weather/utils/TimeUtils.dart';

class WeekTile extends StatelessWidget {
  final Daily weather;

  WeekTile({Key key, @required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<WeatherState>(context, listen: false);
    var currentWeatherBloc = BlocProvider.of<CurrentWeatherBloc>(context);

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      title: Text(_getWeekDay(weather)),
      leading: Image.network(currentWeatherBloc.getIconUrl(weather.weather[0].icon),
          fit: BoxFit.fitWidth),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_getHumidity(weather)),
          Text(_getMinMaxTemp(weather)),
        ],
      ),
    );
  }

  String _getCurrentTemp(Daily daily) {
    return "Curr temp: ${daily.temp.day.toInt()}";
  }

  String _getMinMaxTemp(Daily daily) {
    return "${daily.temp.max.toInt()}\u2103 / ${daily.temp.min.toInt()}\u2103";
  }

  String _getWeekDay(Daily daily) {
    var weekDay = getDateFormatted(daily.dt);
    return weekDay;
  }

  String _getHumidity(Daily daily) {
    return "${daily.humidity}%";
  }
}
