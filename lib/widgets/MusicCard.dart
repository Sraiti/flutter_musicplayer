import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  MusicCard({this.position});
  final int position;

  @override
  Widget build(BuildContext context) {
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
            ? playerManager.play(dataManager.allSongs[position])
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
  }
}
