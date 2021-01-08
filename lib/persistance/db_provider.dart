import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_weather/model/city/city_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/city.dart';

class DbProvider {
  static Database _database;
  static final tblCity = 'city';

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
        join(await getDatabasesPath(), 'weather_database.db'),
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE City ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "state TEXT,"
              "country TEXT,"
              "lat REAL,"
              "lon REAL"
              ")");
        }
    );
  }

  insertCities(List<CityModel> citiesList) async {
    final db = await database;
    Batch batch = db.batch();
    citiesList.forEach((val) {
      batch.insert(tblCity, val.toMap());
    });
    batch.commit(noResult: true);
  }

  getCity(int id) async {
    final db = await database;
    var res =await  db.query(tblCity, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? City.fromMap(res.first) : Null ;
  }

  Future<bool> isCityTableNotEmpty() async {
    final db = await database;
    var res = await db.rawQuery("SELECT count(*) FROM $tblCity");
    var count = Sqflite.firstIntValue(res);
    return count > 0;
  }

  Future<List<City>> getCitiesByKeyWord(String keyWord) async {
    List<City> result = [];
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $tblCity WHERE name LIKE '%$keyWord%'");
    res.forEach((element) {
      result.add(City.fromMap(element));
    });
    return result;
  }
}
