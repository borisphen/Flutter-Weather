import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/one_call/OneCallResponse.dart';
import 'package:provider/provider.dart';

class WeekTile extends StatelessWidget {
  final Daily weather;

  WeekTile({Key key, @required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<WeatherState>(context, listen: false);

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(_getCurrentTemp(weather)),
      subtitle: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(appState.getIconUrl(weather.weather[0].icon),
          width: 24,
          height: 24,),
          Text(_getMinMaxTemp(weather)),
        ],
      ),
    );
  }

  String _getCurrentTemp(Daily daily) {
    return "Curr temp: ${daily.temp.day.toInt()}";
  }

  String _getMinMaxTemp(Daily daily) {
    return "Min/Max temp: ${daily.temp.max.toInt()} / ${daily.temp.max.toInt()}";
  }
}
