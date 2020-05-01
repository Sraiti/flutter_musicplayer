import 'package:flutter/material.dart';

import '../Constants.dart';

class MenuCard extends StatelessWidget {
  const MenuCard(
      {this.text, this.icon, this.function, this.position, this.color});

  final String text;
  final IconData icon;
  final Color color;
  final Function function;
  final List<bool> position;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        child: GestureDetector(
          onTap: function,
          child: Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color: color,
                    size: 40.0,
                  ),
                ),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: kMenuItemsStyle,
                  ),
                )
              ],
            ),
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: (position[0] && position[1])
              ? Radius.circular(15.0)
              : Radius.circular(0),
          topRight: (position[0] && !position[1])
              ? Radius.circular(15.0)
              : Radius.circular(0),
          bottomLeft: (!position[0] && position[1])
              ? Radius.circular(15.0)
              : Radius.circular(0),
          bottomRight: (!position[0] && !position[1])
              ? Radius.circular(15.0)
              : Radius.circular(0),
        ),
      ),
    );
  }
}
