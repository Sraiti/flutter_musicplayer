import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_musicplayer/Models/Song.dart';

import 'SQLiteDB.dart';

class DataManager extends ChangeNotifier {
  final List<Song> _allSongs = [];
  List<Song> _allFavoritedSongs = [];

  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  Duration _duration = new Duration();
  Duration _position = new Duration();

  Duration second = new Duration(seconds: 1);

  Song playingNow = Song(name: "");
  bool isPlaying = false;
  bool looping = false;
  bool shuffled = false;

  DataManager(context) {
    getAllFavImages().then(
      (value) => {
        _allFavoritedSongs.forEach((element) {
          print("path ${element.path}");
        }),
        getAllSongsNames(context),
        initPlayer(),
      },
    );
  }
  void addToFav(Song song) {
    print("add");
    DBHelper dbHelper = DBHelper();
    song.isFav = 1;
    dbHelper.addToFavorites(song);
    notifyListeners();
  }

  void deleteFav(Song song) {
    print("deleteFav");
    DBHelper dbHelper = DBHelper();
    song.isFav = 0;
    dbHelper.deleteFromFavorites(song);
    notifyListeners();
  }

  Future<List<Song>> getAllFavImages() async {
    DBHelper dbHelper = DBHelper();
    _allFavoritedSongs = await dbHelper.getFavorites();
    return _allFavoritedSongs;
  }

  void loop() {
    if (!looping) {
      audioCache.loop(playingNow.path.replaceFirst("assets/", ""));
      looping = true;

      print("true");
    } else {
      audioCache.play(playingNow.path.replaceFirst("assets/", ""));
      looping = false;

      print("false");
    }
    notifyListeners();
  }

  String getDurationString() {
    List<String> parts = getPosition().toString().split(':');
    String firstPart = parts[1].padLeft(2, '0');
    List<String> secondPartList = parts[2].padLeft(2, '0').split('.');
    String secondPart = secondPartList[0];

    return '$firstPart'
        ':$secondPart';
  }

  Duration getDuration() {
    return _duration;
  }

  Duration getPosition() {
    return _position;
  }

  set position(Duration value) {
    _position = value;
  }

  set duration(Duration value) {
    _duration = value;
  }

  List<Song> get allSongs => _allSongs;

  Song getSong(position) {
    if (position > _allSongs.length - 1 || position < 0) {
      return _allSongs[0];
    } else {
      return _allSongs[position];
    }
  }

  void shuffleSongs() {
    allSongs.shuffle(Random(2));
    shuffled = true;
    print("shuffleSong Called");
    allSongs.forEach((element) {
      print(" ID :${element.id} Name:${element.name}");
    });
    notifyListeners();
  }

  void setSong(Song value) {
    _allSongs.add(value);
    notifyListeners();
  }

  void play(int position) {
    playingNow = getSong(position);
    audioCache.play(getSong(position).path.replaceFirst("assets/", ""));

    isPlaying = true;
    //notifyListeners();
  }

  void pause() {
    isPlaying = false;
    advancedPlayer.pause();
    notifyListeners();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
    notifyListeners();
  }

  void initPlayer() async {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.completionHandler = () {
      if (!looping) {
        play(playingNow.id + 1);
        notifyListeners();
      }
    };
    advancedPlayer.durationHandler = (d) {
      _duration = d;
      notifyListeners();
    };
    advancedPlayer.positionHandler = (p) {
      _position = p;
      notifyListeners();
    };
  }

  //Getting Data From the Asset then creating song objects and extracting song
  void getAllSongsNames(BuildContext context) async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths =
        manifestMap.keys.where((String key) => key.contains('songs/')).toList();
    int i = 0;
    for (String item in imagePaths) {
      String songName = item.replaceAll("assets/songs/", "");
      songName = songName.replaceAll("%20", " ");
      songName = songName.replaceAll(".flac", "");
      songName = songName.replaceAll(".mp3", "");

      Song song = Song(
        id: i,
        isFav: 0,
        name: songName,
        path: item.replaceAll("%20", " "),
      );

      setSong(song);
      i++;
    }
    for (Song item in allSongs) {
      Song isFavouriteCheck = _allFavoritedSongs.firstWhere(
        (song) => song.path == item.path,
        orElse: () => null,
      );
      (isFavouriteCheck == null) ? item.isFav = 0 : item.isFav = 1;
      notifyListeners();
    }

    allSongs.forEach((element) {
      print("Filtring ${element.isFav}");
    });
    playingNow = getSong(0);
  }
}
