import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';

import 'file:///D:/Bender/Development/Projects/flutter_weather/lib/providers/current_weather/current_weather_view_model.dart';


class Coordinates extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final weatherResponse = watch(currentWeatherViewModelProvider).weatherResponse;
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
