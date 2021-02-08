import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather/bloc/bloc_provider.dart';
import 'package:flutter_weather/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';
import 'package:intl/intl.dart';

class SysInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateFormat = new DateFormat('hh:mm:ss');
    var currentWeatherBloc = BlocProvider.of<CurrentWeatherBloc>(context);
    final sys = currentWeatherBloc.data.sys;
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