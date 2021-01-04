// import 'package:cats/fav_button.dart';
// import 'package:cats/models/app_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_weather/bloc/weather_state.dart';
// import 'package:flutter_weather/model/weather_response_model.dart';
// import 'package:provider/provider.dart';
//
// import 'models/cat.dart';
//
// class PlaceTile extends StatelessWidget {
//   final WeatherResponse weather;
//
//   PlaceTile({
//     Key key,
//     @required this.weather,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<WeatherState>(context, listen: false);
//
//     return ListTile(
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//       leading: Hero(
//         tag: 'hero-${weather.id}',
//         child: CircleAvatar(
//           radius: 24.0,
//           backgroundColor: Theme.of(context).primaryColor,
//           backgroundImage: Image.network(
//             weather.avatarUrl,
//             width: 48,
//             height: 48,
//             fit: BoxFit.cover,
//           ).image,
//         ),
//       ),
//       title: Text(weather.name),
//       trailing: FavoriteButton(
//         faved: faved,
//         onPressed: () =>
//             !faved ? appState.addFavorite(weather) : appState.removeFavorite(weather),
//       ),
//       onTap: () => Navigator.pushNamed(context, '/details', arguments: weather.id),
//     );
//   }
// }
