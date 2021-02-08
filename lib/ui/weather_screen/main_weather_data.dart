
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather/bloc/bloc_provider.dart';
import 'package:flutter_weather/bloc/current_weather/current_weather_bloc.dart';

class MainWeatherData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<WeatherState>(context, listen: false);
    var currentWeatherBloc = BlocProvider.of<CurrentWeatherBloc>(context);
    var weatherResponse = currentWeatherBloc.data;
    var weather = weatherResponse.weather[0];
    var main = weatherResponse.main;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Main",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 4.0),
                child: Hero(
                    tag: '${weatherResponse.id}',
                    child: Image.network(currentWeatherBloc.getIconUrl(weather.icon)))),
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