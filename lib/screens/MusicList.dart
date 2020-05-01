import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_musicplayer/Constants.dart';
import 'package:flutter_musicplayer/Managers/DataManger.dart';
import 'package:flutter_musicplayer/Managers/PlayerManager.dart';
import 'package:flutter_musicplayer/Models/Song.dart';
import 'package:flutter_musicplayer/screens/PlayingNow.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class MusicList extends StatefulWidget {
  static final String id = "MusicList";

  List<String> someImages = new List<String>();
  int index;
  IconData iconData;
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  DataManager dataManager = DataManager.getInstance();
  PlayerManager playerManager = PlayerManager.getInstance();
  Future _initImages() async {
    print("DataMangeSongsList");
    print(dataManager.allSongs);

    setState(
      () {
        print("ITEMS");
        for (Song item in dataManager.allSongs) {
          String songName = item.path.replaceAll("asset/songs/", "");
          songName = songName.replaceAll("%20", " ");
          songName = songName.replaceAll(".flac", "");
          songName = songName.replaceAll(".mp3", "");

          print(songName);
          widget.someImages.add(songName);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191a1f),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$kArtistName's Songs",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "FiraSans",
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.someImages.length,
                      itemBuilder: (context, position) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              playerManager.isPlaying
                                  ? widget.iconData = Icons.play_arrow
                                  : widget.iconData = Icons.pause;
                              widget.index = position;
                            });
                            print(position);
                            (!playerManager.isPlaying)
                                ? playerManager
                                    .play(dataManager.allSongs[position])
                                : playerManager.pause();
                            print("list click");
                            print(dataManager.allSongs[position].path);
                          },
                          leading: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25.0,
                          ),
                          title: Text(
                            widget.someImages[position],
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(2.0),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Divider(
                    height: 3.0,
                    thickness: 2.0,
                    color: Colors.grey.shade800,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, PlayingNow.id);
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    (widget.index == null)
                                        ? "AC_DC - If You Want Blood (You've Got It)"
                                        : widget.someImages[widget.index],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                    kArtistName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, right: 5, left: 5, top: 5),
                          child: Container(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  (playerManager.isPlaying)
                                      ? playerManager.pause()
                                      : playerManager
                                          .play(playerManager.playingNow);
                                  print("nav Buttons");
                                  print(playerManager.playingNow.path);
                                });
                              },
                              icon: Icon(
                                (widget.iconData == null)
                                    ? Icons.library_music
                                    : widget.iconData,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
