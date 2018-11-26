import 'package:flutter/material.dart';
import '../components/IM.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools extends StatelessWidget {
 


  final VoidCallback onLayoutToggle = null;
  @override
  Widget build(BuildContext context) => new Container(
    child: CustomScrollView(
      slivers: <Widget>[
        
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 2.0,

          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return 
              Padding(
                padding: EdgeInsets.only(top: 30.0,left: (index%2==0)?15.0:5.0, right:  (index%2==0)?5.0:15.0),
                child: IMButton(
                      title: allMenus[index].name,
                      icon: allMenus[index].icon,
                      context: context,
                      onPressed:(allMenus[index].url!='')? () {
                        Navigator.of(context).pushNamed(allMenus[index].url);
                      }:allMenus[index].action,
                      type: ButtonTypes.action,
                      
                    ),)
              ;
            },
            childCount: allMenus.length,
          ),
        ),
      ],
    )
  );
}


List<Menu> allMenus = [
  Menu(name: 'CAL', url: '/calc', icon: new Icon(Icons.computer)),
  Menu(name: 'BMI', url: '/bmi', icon: new Icon(Icons.assignment)),
  Menu(name: 'MAP', url: '', icon: new Icon(Icons.map), action: _openMap ),
  Menu(name: 'PHOTO', url: '/photo', icon: new Icon(Icons.photo_camera)),
];

class Menu {
  Menu({this.name, this.url, this.icon, this.action});
  final String name;
  final dynamic action;
  final String url;
  final Icon icon;
}


_openMap() async {
    const url = 'geo:6.92966,79.850096';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }