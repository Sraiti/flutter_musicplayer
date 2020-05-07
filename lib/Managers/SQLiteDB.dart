import 'dart:async';
import 'dart:io' as io;

 import 'package:flutter_musicplayer/Models/Song.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

   Context context;

  final String tableName = "Songs";

  static Database dbInstance;
 
  Future<Database> get db async {
    if (dbInstance == null) dbInstance = await initDB();
    return dbInstance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FavouritSongs.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateDB);
    return db;
  }

  void onCreateDB(Database db, int version) async {

     await db.execute(
        'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT , path TEXT , isFav INTEGER)');
  }

  Future<List<Song>> getFavorites() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM $tableName');
    List<Song> favorites = new List();

    for (int i = 0; i < list.length; i++) {
      Song image = new Song();
      image.name = list[i]['name'];
      image.path = list[i]['path'];
      image.isFav = list[i]['isFav'];
      favorites.add(image);
    }

    return favorites;
  }

  void addToFavorites(Song song) async {
     final values = <String, dynamic>{
      'name': song.name,
      'path': song.path,
      'isFav': song.isFav,
    };
    await dbInstance.insert(tableName, values, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deleteFromFavorites(Song song) async {
    await dbInstance.delete(tableName,where: "path = ?",whereArgs: [song.path]);
  }
}
