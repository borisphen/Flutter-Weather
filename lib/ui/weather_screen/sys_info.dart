import 'package:flutter/widgets.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/ui/weather_screen/vertical_divider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SysInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateFormat = new DateFormat('hh:mm:ss');
    final sys = Provider.of<WeatherState>(context, listen: false).weatherResponse.sys;
    var sunriseDate =
    new DateTime.fromMillisecondsSinceEpoch(sys.sunrise * 1000);
    var sunsetDate = new DateTime.fromMillisecondsSinceEpoch(sys.sunset * 1000);
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Sys",
/*            style: TextStyle(color: titleColor, fontSize: 18.0),*/
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