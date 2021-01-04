// import 'package:flutter/material.dart';
// import 'package:flutter_weather/bloc/weather_state.dart';
// import 'package:flutter_weather/ui/place_tile.dart';
// import 'package:provider/provider.dart';
//
// class PlacesListPage extends StatelessWidget {
//   final String title;
//
//   PlacesListPage({Key key, this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () => Navigator.pushNamed(context, '/faved'),
//           )
//         ],
//       ),
//       body: Consumer<WeatherState>(
//         builder: (context, appState, child) => ListView.builder(
//           itemCount: appState.cats.length,
//           itemBuilder: (context, index) {
//             final cat = appState.cats[index];
//             return PlaceTile(
//               key: ValueKey(cat.id),
//               weather: cat,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }