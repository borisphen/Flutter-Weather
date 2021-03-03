import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/redux/state/AppState.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class Coordinates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var weatherResponse = StoreProvider.of<AppState>(context).state
        .currentWeatherState.weatherResponse;
    final coord = weatherResponse.coord;
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Coord",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Lat: " + coord.lat.toString()),
            AppVerticalDivider(),
            Text("Lng: " + coord.lon.toString())
          ],
        ),
      ],
    );
  }
}
