import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_musicplayer/Managers/DataManger.dart';
import 'package:flutter_musicplayer/screens/PlayingNow.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    this.position,
    this.data,
    this.childConsumer,
    this.function,
  });

  final DataManager data;
  final int position;
  final Widget childConsumer;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade700.withAlpha(170),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(2.0),
        onTap: function,
        onLongPress: () {
          Navigator.pushNamed(context, PlayingNow.id);
        },
        leading: IconButton(
          onPressed: () {
            (data.getSong(position).isFav == 1)
                ? data.deleteFav(data.getSong(position))
                : data.addToFav(data.getSong(position));
          },
          icon: Icon(
            Icons.favorite,
            color:
                (data.getSong(position).isFav == 1) ? Colors.red : Colors.grey,
            size: 30.0,
          ),
        ),
        title: Text(
          data.getSong(position).name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: "FiraSans",
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }
}
