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
    return Consumer<WeatherState>(
        builder: (context, weather, child) {
          if (weather.weatherResponse != null) {
            return _buildWeatherScreen(weather.weatherResponse);
            // return _buildForeCast(weather.weatherResponse.coord.lat, weather.weatherResponse.coord.lon);
          } else {
            return Center(child: Text('Loading...'));
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  SingleChildScrollView _buildWeatherScreen(WeatherResponse data) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(data.name),
            _buildCoord(data.coord),
            _buildMain(data.main),
            _buildWindInfo(data.wind),
            _buildSys(data.sys),
            _buildForeCast(data.coord.lat, data.coord.lon),
          ],
        ),
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
          margin: const EdgeInsets.only(bottom: 12.0, top: 12.0),
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

  @override
  void initState() {
    super.initState();
    final weatherProvider = Provider.of<WeatherState>(context, listen: false);
    weatherProvider.getCurrentLocation();
    weatherProvider.loadCitiesList();
    // compute (null, weatherProvider.loadCitiesList());
  }

  Widget _buildForeCast(double lat, double lon) {
    final appState = Provider.of<WeatherState>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: FutureBuilder<OneCallResponse>(
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
      ),
    );
  }

}