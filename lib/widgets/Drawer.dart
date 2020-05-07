import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_musicplayer/utils/Utils.dart';
import 'package:share/share.dart';

import '../Constants.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: -5,
              ),
              child: Image.asset('assets/images/ic_launcher.png'),
            ),
          ),
          Card(
            child: ListTile(
              trailing: Icon(
                Icons.contact_mail,
                color: Colors.pink,
              ),
              title: Text(
                'Contact Us',
                style: TextStyle(color: Colors.pink),
              ),
              subtitle: Text(
                'Send Email To Support',
              ),
              onTap: () {
                launchURL(
                    'mailto:specialonesteam@gmail.com?subject=what is your subject&body=');
              },
            ),
          ),
          Card(
            child: ListTile(
              trailing: Image.asset(
                'assets/images/insta.png',
                width: 25,
                height: 30,
              ),
              title: Text(
                'Instagram',
                style: TextStyle(color: Colors.pink.shade600),
              ),
              subtitle: Text(
                'Flowing Us In Instagram',
              ),
              onTap: () {
                launchURL('http://instagram.com/Morning_friends');
              },
            ),
          ),
          Card(
            child: ListTile(
              trailing: Icon(
                Icons.more,
                color: Colors.indigo,
              ),
              title: Text(
                'More Apps',
                style: TextStyle(color: Colors.indigo),
              ),
              subtitle: Text(
                'Find More Apps',
              ),
              onTap: () {
                launchURL(
                    'https://play.google.com/store/apps/developer?id=Special+Ones+Group');
              },
            ),
          ),
          Card(
            child: ListTile(
              trailing: Icon(
                Icons.share,
                color: Colors.orange,
              ),
              title: Text(
                'Share App',
                style: TextStyle(color: Colors.orange),
              ),
              subtitle: Text(
                'Share App With Your Friends',
              ),
              onTap: () {
                Share.share(
                  'best app for photos download it now ${kPrefixStore + kPackageName}',
                  subject: 'Share in ...',
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              trailing: Icon(
                Icons.insert_drive_file,
                color: Colors.green,
              ),
              title: Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.green),
              ),
              subtitle: Text(
                'Read The Privacy Ploicy',
              ),
              onTap: () {
                launchURL('http://dev3pro.com/index/privacy_policy.html');
              },
            ),
          ),
          Card(
            child: ListTile(
              trailing: Icon(
                Icons.stars,
                color: Colors.purple,
              ),
              title: Text(
                'Rate Us',
                style: TextStyle(color: Colors.purple),
              ),
              subtitle: Text(
                'Rate This App In Play Store',
              ),
              onTap: () {
                launchURL(kPrefixStore + kPackageName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
