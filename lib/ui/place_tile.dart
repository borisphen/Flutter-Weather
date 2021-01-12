import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/persistance/model/city.dart';
import 'package:provider/provider.dart';


class PlaceTile extends StatelessWidget {
  final WeatherResponse weather;
  final City city;

  PlaceTile({
    Key key,
    @required this.weather, this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<WeatherState>(context, listen: false);

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      leading: Hero(
        tag: 'hero-${weather.id}',
        child:
          Image.network(appState.getIconUrl(weather.weather[0].icon)),
      ),
      title: Text(weather.name),
      // trailing: FavoriteButton(
      //   faved: faved,
      //   onPressed: () =>
      //       !faved ? appState.addFavorite(weather) : appState.removeFavorite(weather),
      // ),
      onTap: () => Navigator.pushNamed(context, '/details', arguments: weather.id),
    );
  }
}
