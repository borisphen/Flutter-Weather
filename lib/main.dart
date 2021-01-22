import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/cities_finder.dart';
import 'package:flutter_weather/ui/places_list.dart';
import 'package:flutter_weather/ui/weather_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'bloc/weather_state.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var state = WeatherState();
  await state.initTheme();
  runApp(ChangeNotifierProvider<WeatherState>(
    create: (context) => state,
    builder: (context, child) {
      return MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<WeatherState>(context, listen: false);
    return Consumer<WeatherState>(builder: (context, weather, child) {
      return MaterialApp(
        title: 'Weather App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: appState.getCurrentTheme(),
        // home: MyHomePage(),
        routes: {
          Navigator.defaultRouteName: (context) =>
              MyHomePage(title: "Weather App"),
          '/finder': (context) => CitiesFinder(),
          '/favorites': (context) => PlacesListPage(title: "Favorite Cities")
        },
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<WeatherState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Settings'),
              decoration:
                  BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add city'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/finder');
              }
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Cities management'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/favorites');
              }
            ),
            ListTile(
                leading: Switch(
                  onChanged: (value) => {appState.switchTheme()},
                  value: appState.isLightTheme,
                ),
                title: Text('Dark/Light mode'),
              ),
          ],
        ),
      ),
      body: WeatherScreen(),
      // body: CitiesFinder(),
    );
  }
}
