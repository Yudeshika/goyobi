import 'package:flutter/material.dart';

class IMAppBar extends AppBar{
  IMAppBar({Key key,String title, BuildContext context, Widget bottom}):
  super(
    key:key,
    bottom: bottom,
    title:new Text(
      title,
      style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        )
    ),
    actions: <Widget>[
    new IconButton(
      icon: new Icon(Icons.help),
      onPressed: (){
        Navigator.of(context).pushNamed("/guide");
      }
    ),
    new IconButton(
      icon: new Icon(Icons.notifications_none),
      onPressed: () => print("tap")
    )
  ],
  elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
  );
}