import 'package:flutter/material.dart';
import '../components/IM.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Guide extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    //App Bar
    appBar: new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: new IconThemeData(color: Colors.cyan)
    ),

    //Content of tabs
    body: new PageView(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
    height: 600.0,
    width: 350.0,
    child: new Carousel(
      images: [
        new NetworkImage('https://firebasestorage.googleapis.com/v0/b/goyobi-base.appspot.com/o/1.jpg?alt=media&token=dbc8de9d-584e-4f20-bfe2-34b46d3d0a81'),
        new NetworkImage('https://firebasestorage.googleapis.com/v0/b/goyobi-base.appspot.com/o/2.jpg?alt=media&token=44576e98-7cef-45ec-839e-92a400cca7cd'),
        new NetworkImage('https://firebasestorage.googleapis.com/v0/b/goyobi-base.appspot.com/o/3.jpg?alt=media&token=349edf9e-a862-4541-8da7-ad28b688b3c3'),
        new NetworkImage('https://firebasestorage.googleapis.com/v0/b/goyobi-base.appspot.com/o/4.jpg?alt=media&token=1fb97bc4-04be-4f2c-a74c-8294471f90f6'),
        
      ],
      dotSize: 4.0,
      dotSpacing: 15.0,
      dotColor: Colors.amberAccent,
      indicatorBgPadding: 5.0,
      dotBgColor: Colors.cyan.withOpacity(0.5),
      borderRadius: false,
      moveIndicatorFromBottom: 10.0,
      noRadiusForIndicator: true,
      overlayShadow: true,
      overlayShadowColors: Colors.white,
      overlayShadowSize: 0.7,
    )
),
          ],
        )
      ],
    ),
  );
}