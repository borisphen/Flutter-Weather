import 'package:flutter/material.dart';
import 'package:flutter_weather/bloc/bloc_provider.dart';
import 'package:flutter_weather/bloc/cities_list/cities_list_bloc.dart';
import 'package:flutter_weather/bloc/cities_list/get_cities_list_event.dart';
import 'package:flutter_weather/model/weather/weather_response_model.dart';
import 'package:flutter_weather/ui/place_tile.dart';

class PlacesListPage extends StatefulWidget {
  final String title;

  PlacesListPage({Key key, this.title}) : super(key: key);

  @override
  _PlacesListPageState createState() => _PlacesListPageState();
}

class _PlacesListPageState extends State<PlacesListPage> {
  CitiesListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CitiesListBloc();
    bloc.putEvent(GetCitiesListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocProvider(
            bloc: bloc,
            child: StreamBuilder<List<WeatherResponse>>(
                    stream: bloc.stateStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<WeatherResponse>> snapshot) =>
                        ListView.separated(
                          separatorBuilder: (context, index) =>
                              Divider(
                                color: Colors.black,
                              ),
                          itemCount: (snapshot.data != null)
                              ? snapshot.data.length + 2
                              : 0,
                          itemBuilder: (context, index) {
                            if (index == 0 ||
                                index == snapshot.data.length + 1) {
                              return Container();
                            }
                            final weather = snapshot.data[index - 1];
                            return PlaceTile(
                              key: ValueKey(weather.id),
                              weather: weather,
                            );
                          },
                        ),
                  )
        )
    );
  }
}