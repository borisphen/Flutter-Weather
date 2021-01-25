import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/weather_bloc.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/ui/weather_screen/coordinates.dart';
import 'package:flutter_weather/ui/weather_screen/forecast.dart';
import 'package:flutter_weather/ui/weather_screen/main_weather_data.dart';
import 'package:flutter_weather/ui/weather_screen/sys_info.dart';
import 'package:flutter_weather/ui/weather_screen/wind_info.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState() {
    super.initState();
    final weatherProvider = Provider.of<WeatherState>(context, listen: false);
    weatherProvider.getCurrentLocation();
    weatherProvider.loadCitiesList();
    // compute (null, weatherProvider.loadCitiesList());
  }

  @override
  void dispose() {
    super.dispose();
    weatherBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherState>(builder: (context, weather, child) {
      if (weather.weatherResponse != null) {
        return _buildWeatherScreen(weather.weatherResponse);
      } else {
        return Center(child: Text('Loading...'));
      }
      return Center(child: CircularProgressIndicator());
    });
  }

  SingleChildScrollView _buildWeatherScreen(WeatherResponse data) {
    var titleColor = Theme.of(context).accentColor;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(data.name, titleColor),
            Coordinates(),
            MainWeatherData(),
            WindInfo(),
            SysInfo(),
            Forecast(),
          ],
        ),
      ),
    );
  }

  Center _buildTitle(String name, Color titleColor) {
    return Center(
      child: Text(
        "Weather in " + name,
        style: TextStyle(color: titleColor, fontSize: 40.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
