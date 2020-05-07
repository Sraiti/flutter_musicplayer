import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_musicplayer/screens/MusicList.dart';
import 'package:flutter_musicplayer/screens/PlayingNow.dart';
import 'package:provider/provider.dart';

import 'Managers/DataManger.dart';
import 'screens/HomePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataManager(context),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediaPlayer',
      home: MyHomePage(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        MusicList.id: (context) => MusicList(),
        PlayingNow.id: (context) => PlayingNow(),
      },
    );
  }
}
