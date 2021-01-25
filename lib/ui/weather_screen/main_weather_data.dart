
import 'package:flutter/widgets.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:provider/provider.dart';

class MainWeatherData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<WeatherState>(context, listen: false);
    var weatherResponse = appState.weatherResponse;
    var weather = weatherResponse.weather[0];
    var main = weatherResponse.main;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Main",
     /*       style: TextStyle(color: titleColor, fontSize: 18.0),*/
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 4.0),
                child: Hero(
                    tag: '${weatherResponse.id}',
                    child: Image.network(appState.getIconUrl(weather.icon)))),
            Text("Temperature: " + weatherResponse.main.temp.toString()),
          ],
        ),
        Text("Pressure: " + main.pressure.toString()),
        Text("Humidity: " + main.humidity.toString()),
        Text("Highest temperature: " + main.tempMax.toString()),
        Text("Lowest temperature: " + main.tempMin.toString()),
      ],
    );
  }

}