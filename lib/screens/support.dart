import 'package:flutter/material.dart';
import '../components/IM.dart';

class Support extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    appBar: new IMAppBar(
      title: 'Support',
      context: context,
    ),

    //Content of tabs
    body: new PageView(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Support page content'),
          ],
        )
      ],
    ),
  );
}