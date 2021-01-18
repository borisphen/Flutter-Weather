import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/ui/place_tile.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  final String title;

  PlacesListPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<WeatherState>(context, listen: false);
    return Consumer<WeatherState>(
        builder: (context, weather, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              // actions: [
              //   IconButton(
              //     icon: Icon(Icons.favorite),
              //     onPressed: () => Navigator.pushNamed(context, '/faved'),
              //   )
              // ],
            ),
            body: FutureBuilder<List<WeatherResponse>>(
              future: appState.getFavoriteWeathers(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<WeatherResponse>> snapshot) =>
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                    itemCount: (snapshot.data != null)
                        ? snapshot.data.length + 2
                        : 0,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == snapshot.data.length + 1) {
                        return Container();
                      }
                      final weather = snapshot.data[index - 1];
                      return PlaceTile(
                        key: ValueKey(weather.id),
                        weather: weather,
                      );
                    },
                  ),
            ),
          );
        }
    );
  }
}