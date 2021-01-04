import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/places_state.dart';
import 'package:flutter_weather/model/weather/coord_model.dart';
import 'package:flutter_weather/model/weather/main_model.dart';
import 'package:flutter_weather/model/weather/sys_model.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/model/weather/wind_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_weather/bloc/weather_bloc.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {

  // @override
  // Widget build(BuildContext context) {
  //   weatherBloc.fetchLondonWeather();
  //   return StreamBuilder(
  //       stream: weatherBloc.weather,
  //       builder: (context, AsyncSnapshot<WeatherResponse> snapshot) {
  //         if (snapshot.hasData) {
  //           return _buildWeatherScreen(snapshot.data);
  //         } else if (snapshot.hasError) {
  //           return Text(snapshot.error.toString());
  //         }
  //         return Center(child: CircularProgressIndicator());
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    // weatherBloc.fetchLondonWeather();
    // weatherProvider.fetchWeather();
    final weatherProvider = Provider.of<WeatherState>(context, listen: false);
    weatherProvider.getCurrentLocation();
    weatherProvider.loadCitiesList();
    return Consumer<WeatherState>(
        builder: (context, weather, child) {
          if (weather.weatherResponse != null) {
            return _buildWeatherScreen(weather.weatherResponse);
          } else {
            return Center(child: Text('Oops smth goes wrong!'));
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Container _buildWeatherScreen(WeatherResponse data) {
    return Container(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildTitle(data.name),
          _buildCoord(data.coord),
          _buildMain(data.main),
          _buildWindInfo(data.wind),
          _buildSys(data.sys),
        ],
      ),
    );
  }

  Center _buildTitle(String name) {
    return Center(
      child: Text(
        "Weather in " + name,
        style:
        TextStyle(color: Color.fromRGBO(0, 123, 174, 100), fontSize: 40.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Column _buildCoord(Coord coord) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Coord",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Lat: " + coord.lat.toString()),
            _buildVerticalDivider(),
            Text("Lng: " + coord.lon.toString())
          ],
        ),
      ],
    );
  }

  Column _buildMain(Main main) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Main",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Text("Temperature: " + main.temp.toString()),
        Text("Pressure: " + main.pressure.toString()),
        Text("Humidity: " + main.humidity.toString()),
        Text("Highest temperature: " + main.tempMax.toString()),
        Text("Lowest temperature: " + main.tempMin.toString()),
      ],
    );
  }

  Column _buildWindInfo(Wind wind) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Wind",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Speed: " + wind.speed.toString()),
            _buildVerticalDivider(),
            Text("Degree: " + wind.deg.toString()),
          ],
        )
      ],
    );
  }

  Container _buildVerticalDivider() {
    return Container(
        height: 20, child: VerticalDivider(color: Colors.blueGrey));
  }

  Column _buildSys(Sys sys) {
    final dateFormat = new DateFormat('hh:mm:ss');

    var sunriseDate =
    new DateTime.fromMillisecondsSinceEpoch(sys.sunrise * 1000);
    var sunsetDate = new DateTime.fromMillisecondsSinceEpoch(sys.sunset * 1000);
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Sys",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Sunrise: " + dateFormat.format(sunriseDate)),
            _buildVerticalDivider(),
            Text("Sunset: " + dateFormat.format(sunsetDate)),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    weatherBloc.dispose();
  }
}