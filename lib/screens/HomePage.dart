import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_musicplayer/screens/MusicList.dart';
import 'package:flutter_musicplayer/widgets/Drawer.dart';
import 'package:flutter_musicplayer/widgets/MenuCard.dart';

import '../Constants.dart';

class MyHomePage extends StatelessWidget {
  static final String id = "HomePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

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
          Column(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Container(
                     decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/artist.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(180.0)),
                      border: Border.all(
                        color: Colors.white,
                        width: 4.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  kArtistName,
                  style: kArtistNameStyle,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        MenuCard(
                          text: "Play",
                          icon: Icons.play_circle_filled,
                          position: [true, true],
                          color: Colors.grey.shade800,
                          function: () {
                            Navigator.pushNamed(
                              context,
                              MusicList.id,
                            );
                          },
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        MenuCard(
                          text: "My List",
                          icon: Icons.favorite,
                          position: [true, false],
                          color: Colors.pink.shade600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Row(
                      children: <Widget>[
                        MenuCard(
                          text: "More Apps",
                          icon: Icons.open_in_browser,
                          position: [false, true],
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        MenuCard(
                          text: "Share",
                          icon: Icons.share,
                          position: [false, false],
                        ),
                      ],
                    ),

                    ///Privacy Policy
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          GestureDetector(
                            onTap:(){

                            } ,
                            child: Text(
                              "Privacy policy",
                              style: KPrivacyStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
