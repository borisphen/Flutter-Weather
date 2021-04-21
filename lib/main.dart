import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/persistance/prefs_provider.dart';
import 'package:flutter_weather/persistance/repository.dart';
import 'package:flutter_weather/providers/repository_provider.dart';
import 'package:flutter_weather/ui/cities_finder.dart';
import 'package:flutter_weather/ui/places_list.dart';
import 'package:flutter_weather/ui/weather_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///D:/Bender/Development/Projects/flutter_weather/lib/providers/theme/theme_view_model.dart';

import 'bloc/theme_state.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var themState = ThemeState();
  await themState.initTheme();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      // ChangeNotifierProvider<ThemeState>(
      //   create: (context) => themState,
      // ),
      // StateNotifierProvider<WeatherState, WeatherResponse>((ref) {
      //   return WeatherState();
      // }),
      repositoryProvider.overrideWithValue(Repository()),
      sharedPreferencesProvider.overrideWithValue(PrefsProvider(sharedPreferences)),
    ],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget  {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var themeViewModel = watch(themeViewModelProvider.notifier);
      return MaterialApp(
        title: 'Weather App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeViewModel.getCurrentTheme(),
        // home: MyHomePage(),
        routes: {
          Navigator.defaultRouteName: (context) =>
              MyHomePage(title: "Weather App"),
          '/finder': (context) => CitiesFinder(),
          '/favorites': (context) => PlacesListPage(title: "Favorite Cities")
        },
      );
  }
}

class MyHomePage extends ConsumerWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final appState = Provider.of<ThemeState>(context, listen: false);
    var themeViewModel = watch(themeViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                }),
            ListTile(
                leading: Icon(Icons.list),
                title: Text('Cities management'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/favorites');
                }),
            ListTile(
              leading: Switch(
                onChanged: (value) => {themeViewModel.switchTheme()},
                value: themeViewModel.state.isLightTheme,
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
