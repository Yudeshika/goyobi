import 'package:flutter/material.dart';
import '../components/IM.dart';
class About extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    //App Bar
    appBar: new IMAppBar(
      title: "ABOUT US",
      context: context,
    ),

    //Content of tabs
    body: new PageView(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('About page content')
          ],
        )
      ],
    ),
  );
}