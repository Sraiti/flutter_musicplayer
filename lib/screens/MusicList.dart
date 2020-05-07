import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_musicplayer/Constants.dart';
import 'package:flutter_musicplayer/Managers/DataManger.dart';
import 'package:flutter_musicplayer/screens/PlayingNow.dart';
import 'package:flutter_musicplayer/widgets/Drawer.dart';
import 'package:flutter_musicplayer/widgets/MusicCard.dart';
import 'package:provider/provider.dart';

class MusicList extends StatefulWidget {
  static final String id = "MusicList";
  String origin;
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          "$kArtistName's Songs",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: "FiraSans",
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/back.png',
            ),
          ),
        ),
        child: Consumer<DataManager>(
          builder: (context, data, child) =>Stack(
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                            itemCount: data.allSongs.length,
                            itemBuilder: (context, position) {
                              return MusicCard(
                                data: data,
                                position: position,
                                childConsumer: child,
                                function: () {
                                  data.play(position);
                                },
                              );
                            },
                          ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800.withAlpha(225),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                          children: [
                            GestureDetector(
                              onVerticalDragStart: (v) {
                                Navigator.pushNamed(context, PlayingNow.id);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Flexible(
                                    flex: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${data.playingNow.name}",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.visible,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "FiraSans",
                                              ),
                                            ),
                                            Divider(
                                              height: 10,
                                              color: Colors.transparent,
                                            ),
                                            Text(
                                              kArtistName.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey.shade200,
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
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                        right: 10,
                                        left: 5,
                                      ),
                                      child: Container(
                                        child: IconButton(
                                          onPressed: () {
                                            (!data.isPlaying)
                                                ? data
                                                    .play(data.playingNow.id)
                                                : data.pause();
                                          },
                                          icon: Hero(
                                            tag: "PalyButton",
                                            child: Icon(
                                              (data.isPlaying)
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: (data.isPlaying)
                                                  ? kPrimaryColor
                                                  : kSecondaryColor,
                                              size: 45.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value:
                                        data.getPosition().inSeconds.toDouble(),
                                    min: 0.0,
                                    max:
                                        data.getDuration().inSeconds.toDouble(),
                                    activeColor: Colors.deepPurple,
                                    inactiveColor: Colors.grey,
                                    onChanged: (double value) {
                                      data.seekToSecond(value.toInt());
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child:Hero(
                                    tag: "Duration",
                                    child: Text(
                                      "${data.getDurationString()}",
                                      style: TextStyle(
                                        color: (data.isPlaying)
                                            ? kPrimaryColor
                                            : Colors.grey.shade200,
                                        fontSize: 18.0,
                                        fontFamily: "FiraSans",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
