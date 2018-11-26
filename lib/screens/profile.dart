import 'package:flutter/material.dart';
import '../components/IM.dart';
class Profile extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    //App Bar
    appBar: new IMAppBar(
      title: "MY PROFILE",
      context: context,
    ),

    //Content of tabs
    body: new Stack(
      children: <Widget>[
        ClipPath(child: Container(
          color: Colors.black.withOpacity(0.8),
        ),
        clipper: getClipper(),
        )
      ],
    ),
  );
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size){
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
      // TODO: implement shouldReclip
      return true;
    }
}