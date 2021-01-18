import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_weather/bloc/weather_state.dart';
import 'package:flutter_weather/persistance/model/city.dart';
import 'package:provider/provider.dart';

class CitiesFinder extends StatelessWidget {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherState>(context, listen: false);
    // weatherProvider.loadCitiesList();
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
              return await weatherProvider.getSuggestions(pattern);
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
              weatherProvider.setFavoriteCity(suggestion);
              Navigator.of(context).pop();
            }),
      ),
    );
  }
}