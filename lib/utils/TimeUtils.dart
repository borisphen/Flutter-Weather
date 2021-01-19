import 'package:intl/intl.dart';

final dateFormat = new DateFormat('EEE');

String getDateFormatted(int sec) {
  var dateTime =
  new DateTime.fromMillisecondsSinceEpoch(sec * 1000);
  return dateFormat.format(dateTime);
}