import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_musicplayer/Managers/PlayerManager.dart';
import 'package:flutter_musicplayer/Models/Song.dart';

class DataManager {
  static DataManager Instanse;

  static DataManager getInstance() {
    if (Instanse == null) Instanse = DataManager();
    return Instanse;
  }

  List<Song> allSongs = [];
  List<Audio> allSongsPaths = [];
  void getAllSongsNames(BuildContext context) async {
    PlayerManager playerManager = PlayerManager.getInstance();
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines
    final imagePaths =
        manifestMap.keys.where((String key) => key.contains('songs/')).toList();
    int i = 0;
    for (String item in imagePaths) {
      Song song = Song(id: i, isFav: false, path: item);
      allSongs.add(song);
      allSongsPaths.add(
        Audio(
          song.path.replaceAll("%20", " "),
        ),
      );
      print(allSongs[i].path);
      i++;
    }
    playerManager.assetsAudioPlayer.open(
      Playlist(
        audios: allSongsPaths,
      ),
    );
    playerManager.pause();
  }
}
