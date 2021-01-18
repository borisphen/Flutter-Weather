import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:provider/provider.dart';

class PlaceTile extends StatelessWidget {
  final WeatherResponse weather;

  PlaceTile({Key key, @required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<WeatherState>(context, listen: false);

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0),
/*      leading: Hero(
        tag: 'hero-${weather.id}',
        child: Image.network(appState.getIconUrl(weather.weather[0].icon)),
      ),*/
      trailing: IconButton(
        icon: Icon(Icons.remove),
        color: Colors.red,
        onPressed: () => {
          FutureBuilder<bool>(
              future: appState.removeFavoriteCityById(weather.id),
              builder: (context, snapshot) {
                print('In Builder');
                return null;
              })
        },
      ),
      title: Text(weather.name),
      // trailing: FavoriteButton(
      //   faved: faved,
      //   onPressed: () =>
      //       !faved ? appState.addFavorite(weather) : appState.removeFavorite(weather),
      // ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(appState.getIconUrl(weather.weather[0].icon),
          width: 24,
          height: 24,),
          Text(_getCurrentTemp(weather)),
          Text(_getMinMaxTemp(weather)),
        ],
      ),
      onTap: () {
        appState.setFavoriteCityById(weather.id);
        Navigator.of(context).pop();
      }
    );
  }

  String _getCurrentTemp(WeatherResponse weatherResponse) {
    return "Curr temp: ${weatherResponse.main.temp.toInt()}";
  }

  String _getMinMaxTemp(WeatherResponse weatherResponse) {
    return "Min/Max temp: ${weatherResponse.main.tempMax.toInt()} / ${weatherResponse.main.tempMin.toInt()}";
  }
}
