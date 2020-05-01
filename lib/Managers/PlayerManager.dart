import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_musicplayer/Models/Song.dart';

class PlayerManager {
  static PlayerManager Instanse;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  static PlayerManager getInstance() {
    if (Instanse == null) Instanse = PlayerManager();
    return Instanse;
  }

  bool isPlaying;
  int progressValue;
  Song playingNow;

  void play(Song song) {
    print(song.id);
    isPlaying = true;
    if (playingNow != song) {
      playingNow = song;
      assetsAudioPlayer.playlistPlayAtIndex(song.id);
    } else {
      pause();
    }
  }

  void pause() {
    isPlaying = false;
    assetsAudioPlayer.pause();
  }

  void seekTo(Duration duration) {
    assetsAudioPlayer.seek(duration);
  }

  void dispose() {
    assetsAudioPlayer.dispose();
  }
}
