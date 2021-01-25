import 'package:flutter/widgets.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';
import 'package:provider/provider.dart';

class WindInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wind = Provider.of<WeatherState>(context, listen: false).weatherResponse.wind;
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0, top: 12.0),
          child: Text(
            "Wind",
           /* style: TextStyle(color: titleColor, fontSize: 18.0),*/
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