import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/redux/state/AppState.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SysInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateFormat = new DateFormat('hh:mm:ss');
    var weatherResponse = StoreProvider.of<AppState>(context).state
        .currentWeatherState.weatherResponse;
    final sys = weatherResponse.sys;
    var sunriseDate =
    new DateTime.fromMillisecondsSinceEpoch(sys.sunrise * 1000);
    var sunsetDate = new DateTime.fromMillisecondsSinceEpoch(sys.sunset * 1000);
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Sys",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Sunrise: " + dateFormat.format(sunriseDate)),
            AppVerticalDivider(),
            Text("Sunset: " + dateFormat.format(sunsetDate)),
          ],
        ),
      ],
    );
  }
}