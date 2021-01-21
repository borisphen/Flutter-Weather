import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/weather_bloc.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/one_call/OneCallResponse.dart';
import 'package:flutter_weather/model/weather/coord_model.dart';
import 'package:flutter_weather/model/weather/main_model.dart';
import 'package:flutter_weather/model/weather/sys_model.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/model/weather/wind_model.dart';
import 'package:flutter_weather/ui/week_day_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherState>(
        builder: (context, weather, child) {
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
            _buildCoord(data.coord, titleColor),
            _buildMain(data.main, titleColor),
            _buildWindInfo(data.wind, titleColor),
            _buildSys(data.sys, titleColor),
            _buildForeCast(data.coord.lat, data.coord.lon, titleColor),
          ],
        ),
      ),
    );
  }

  Center _buildTitle(String name, Color titleColor) {
    return Center(
      child: Text(
        "Weather in " + name,
        style:
        TextStyle(color: titleColor, fontSize: 40.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Column _buildCoord(Coord coord, Color titleColor) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Coord",
            style: TextStyle(
                color: titleColor, fontSize: 18.0),
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

  Column _buildMain(Main main, Color titleColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Main",
            style: TextStyle(
                color: titleColor, fontSize: 18.0),
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

  Column _buildWindInfo(Wind wind, Color titleColor) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0, top: 12.0),
          child: Text(
            "Wind",
            style: TextStyle(
                color: titleColor, fontSize: 18.0),
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

  Column _buildSys(Sys sys, Color titleColor) {
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
                color: titleColor, fontSize: 18.0),
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

  @override
  void initState() {
    super.initState();
    final weatherProvider = Provider.of<WeatherState>(context, listen: false);
    weatherProvider.getCurrentLocation();
    weatherProvider.loadCitiesList();
    // compute (null, weatherProvider.loadCitiesList());
  }

  Widget _buildForeCast(double lat, double lon, Color titleColor) {
    final appState = Provider.of<WeatherState>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Week forecast",
              style: TextStyle(
                  color: titleColor, fontSize: 18.0),
            ),
          ),
          FutureBuilder<OneCallResponse>(
          future: appState.getOneCallResponse(lat, lon),
          builder: (BuildContext context,
              AsyncSnapshot<OneCallResponse> snapshot) =>
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.black,
                ),
                itemCount: (snapshot.data != null)
                    ? snapshot.data.daily.length + 2
                    : 0,
                itemBuilder: (context, index) {
                  var weekData = snapshot.data.daily;
                  if (index == 0 || index == weekData.length + 1) {
                    return Container();
                  }
                  final weather = weekData[index - 1];
                  return WeekTile(
                    key: ValueKey(weather.weather[0].id),
                    weather: weather,
                  );
                },
              ),
        ),],
      ),
    );
  }

}