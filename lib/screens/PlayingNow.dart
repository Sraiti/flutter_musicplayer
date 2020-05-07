import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_musicplayer/Constants.dart';
import 'package:flutter_musicplayer/Managers/DataManger.dart';
import 'package:provider/provider.dart';

class PlayingNow extends StatelessWidget {
  static final String id = "PlayingNow";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/back.png',
              fit: BoxFit.cover,
            ),
          ),
          Consumer<DataManager>(
            builder: (context, data, child) => Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(150.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.8),
                              BlendMode.dstATop,
                            ),
                            image: AssetImage("assets/images/artist.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                  "${data.playingNow.name}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "FiraSans",
                  ),
                     ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Hero(
                    tag: "Duration",
                    child: Text(
                      "${data.getDurationString()}",
                      style: TextStyle(
                        color: (data.isPlaying)
                            ? Colors.deepPurpleAccent
                            : Colors.grey.shade200,
                        fontSize: 16.0,
                        fontFamily: "FiraSans",
                      ),
                    ),
                  ),
                ),
                Slider(
                  value: data.getPosition().inSeconds.toDouble(),
                  min: 0.0,
                  max: data.getDuration().inSeconds.toDouble(),
                  activeColor: Colors.deepPurple,
                  inactiveColor: Colors.white,
                  onChanged: (double value) {
                    data.seekToSecond(value.toInt());
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500.withAlpha(80),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.shuffle,
                            size: 30.0,
                            color: (data.shuffled)
                                ? Colors.deepPurpleAccent
                                : Colors.grey.shade200,
                          ),
                          onPressed: () {
                            data.shuffleSongs();
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 245,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey.shade600,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      data.play(data.playingNow.id - 1);
                                    },
                                    child: Icon(
                                      Icons.fast_rewind,
                                      color: (data.isPlaying)
                                          ? kPrimaryColor
                                          : kSecondaryColor,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kSecondaryColor,
                                  ),
                                  child: IconButton(
                                    icon: Hero(
                                      tag: "PalyButton",
                                      child: Icon(
                                        (data.isPlaying)
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: kPrimaryColor,
                                        size: 45.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      (!data.isPlaying)
                                          ? data.play(data.playingNow.id)
                                          : data.pause();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      data.play(data.playingNow.id + 1);
                                    },
                                    child: Icon(
                                      Icons.fast_forward,
                                      color: (data.isPlaying)
                                          ? kPrimaryColor
                                          : kSecondaryColor,
                                      size: 45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.repeat,
                            size: 30.0,
                            color: (data.looping)
                                ? Colors.deepPurpleAccent
                                : Colors.grey.shade200,
                          ),
                          onPressed: () {
                            data.loop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade500.withAlpha(50),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pink.shade600,
                      size: 35.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
