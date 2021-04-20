import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/providers/weather_view_model.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';

class WindInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final weatherResponse = watch(weatherViewModelProvider).weatherResponse;
    final wind = weatherResponse.wind;
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0, top: 12.0),
          child: Text(
            "Wind",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Speed: " + wind.speed.toString()),
            AppVerticalDivider(),
            Text("Degree: " + wind.deg.toString()),
          ],
        )
      ],
    );
  }
}