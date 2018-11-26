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
        ),
        Positioned(
          width: 350.0,
          top: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage('https://www.atlassian.com/dam/jcr:13a574c1-390b-4bfb-956b-6b6d114bf98c/max-rehkopf.png'),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(75.0)
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 7.0, color: Colors.black)
                  ]
                ),
                ),
                SizedBox(height: 90.0),
                Text(
                  'Nadun Liyanage',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Subscribe Guys',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
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