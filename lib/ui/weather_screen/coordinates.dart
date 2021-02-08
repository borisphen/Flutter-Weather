import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather/bloc/bloc_provider.dart';
import 'package:flutter_weather/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';

class Coordinates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var coord = BlocProvider.of<CurrentWeatherBloc>(context).data.coord;
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
