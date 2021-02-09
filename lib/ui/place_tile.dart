import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/bloc_provider.dart';
import 'package:flutter_weather/bloc/cities_list/cities_list_bloc.dart';
import 'package:flutter_weather/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';

class PlaceTile extends StatelessWidget {
  final WeatherResponse weather;

  PlaceTile({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<WeatherState>(context, listen: false);
    var currentWeatherBloc = BlocProvider.of<CurrentWeatherBloc>(context);
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        trailing: IconButton(
          icon: Icon(Icons.remove),
          color: Colors.red,
          onPressed: () => {showAlertDialog(context)},
        ),
        title: Text(weather.name),
        subtitle: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: '${weather.id}',
              child: Image.network(
                currentWeatherBloc.getIconUrl(weather.weather[0].icon),
                width: 24,
                height: 24,
              ),
            ),
            Text(_getCurrentTemp(weather)),
            Text(_getMinMaxTemp(weather)),
          ],
        ),
        onTap: () {
          currentWeatherBloc.setFavoriteCityById(weather.id);
          Navigator.of(context).pop();
        });
  }

  String _getCurrentTemp(WeatherResponse weatherResponse) {
    return "Curr temp: ${weatherResponse.main.temp.toInt()}";
  }

  String _getMinMaxTemp(WeatherResponse weatherResponse) {
    return "Min/Max temp: ${weatherResponse.main.tempMax.toInt()} / ${weatherResponse.main.tempMin.toInt()}";
  }

  showAlertDialog(BuildContext context) {
    // final appState = Provider.of<WeatherState>(context, listen: false);
    var citiesBloc = BlocProvider.of<CitiesListBloc>(context);
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        await citiesBloc.removeFavoriteCityById(weather.id);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(
          "Would you like to delete city from favorites"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
