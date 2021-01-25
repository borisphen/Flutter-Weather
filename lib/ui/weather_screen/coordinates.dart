import 'package:flutter/widgets.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';
import 'package:provider/provider.dart';

class Coordinates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coord = Provider.of<WeatherState>(context, listen: false).weatherResponse.coord;
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Coord",
            /*        style: TextStyle(color: titleColor, fontSize: 18.0),*/
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
