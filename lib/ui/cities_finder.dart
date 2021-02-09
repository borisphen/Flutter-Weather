import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_weather/bloc/bloc_provider.dart';
import 'package:flutter_weather/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weather/persistance/model/city.dart';

class CitiesFinder extends StatefulWidget {
  @override
  _CitiesFinderState createState() => _CitiesFinderState();
}

class _CitiesFinderState extends State<CitiesFinder> {
  final TextEditingController _typeAheadController = TextEditingController();


  @override
  void dispose() {
    _typeAheadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentWeatherBloc = BlocProvider.of<CurrentWeatherBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('City finder'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(labelText: 'City'),
              controller: this._typeAheadController,
            ),
            suggestionsCallback: (pattern) async {
              return await currentWeatherBloc.getSuggestions(pattern);
            },
            transitionBuilder:
                (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text((suggestion as City).name),
              );
            },
            onSuggestionSelected: (suggestion) {
              this._typeAheadController.text = (suggestion as City).name;
              currentWeatherBloc.setFavoriteCity(suggestion);
              Navigator.of(context).pop();
            }),
      ),
    );
  }
}