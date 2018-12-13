import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './tabs/home.dart' as _firstTab;
import './tabs/dashboard.dart' as _secondTab;
import './tabs/reminders.dart' as _thirdTab;
import './tabs/tools.dart' as _fourthTab;
import './screens/todo/create.dart' as _todosCreatePage;
import './components/IM.dart';
import './screens/user/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:math';

class Tabs extends StatefulWidget {


  final BaseAuth auth;

  FirebaseUser user;

  Tabs({this.auth, this.onSignOut}){
    auth.currentUserObject().then((userObj) {
      user = userObj;
    });
  }

  final VoidCallback onSignOut;
  @override
  TabsState createState() => new TabsState();


  
}

class TabsState extends State<Tabs>  with TickerProviderStateMixin{
  PageController _tabController;

  //Animation
  Random random;
  AnimationController sparklesAnimationController;
  Animation sparklesAnimation;
  final duration = new Duration(milliseconds: 400);
  
  double _sparklesAngle = 0.0;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
    random = new Random();
    sparklesAnimationController = new AnimationController(vsync: this, duration: duration);
    sparklesAnimation = new CurvedAnimation(parent: sparklesAnimationController, curve: Curves.easeIn);
    sparklesAnimation.addListener((){
      setState(() { });
    });

    increment(null);
  }


  Widget getAnimButton(){
    var stackChildren = <Widget>[
    ];

    var firstAngle = _sparklesAngle;
    var sparkleRadius = (sparklesAnimationController.value * 50) ;
    var sparklesOpacity = (1 - sparklesAnimation.value);

    for(int i = 0;i < 5; ++i) {
      var currentAngle = (firstAngle + ((2*pi)/5)*(i));
      var sparklesWidget =
        new Positioned(child: new Transform.rotate(
            angle: currentAngle - pi/2,
            child: new Opacity(opacity: sparklesOpacity,
                child : new Image.asset("assets/common/sparkles.png", width: 14.0, height: 14.0, ))
          ),
          left:(sparkleRadius*cos(currentAngle)) + 20,
          top: (sparkleRadius* sin(currentAngle)) + 20 ,
      );
      stackChildren.add(sparklesWidget);
    }

    stackChildren.add(new Opacity(opacity: 1.0, child: new Container(
        height: 50.0 ,
        width: 50.0 ,
        decoration: new ShapeDecoration(
          shape: new CircleBorder(
              side: BorderSide.none
          ),
          color: Colors.pink,
        ),
        child: new Center(child:
        new Text("+" ,
          style: new TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0),))
    )));


    var widget =  new Positioned(
        child: new Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: stackChildren,
        )
        ,
    );
    return widget;
  }

  void increment(Timer t) { 
    sparklesAnimationController.forward(from: 0.0);
    setState(() {
      _sparklesAngle = random.nextDouble() * (2*pi);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: (_tab == 0)
            ? null
            : new IMAppBar(
                title: _title_app,
                context: context,
              ),

        //Content of tabs
        body: new PageView(
          controller: _tabController,
          onPageChanged: onTabChanged,
          children: <Widget>[
            new _firstTab.Home(),
            new _secondTab.Dashboard(),
            new _thirdTab.Reminders(),
            new _fourthTab.Tools()
          ],
        ),

        //Tabs
        bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS
            ? new CupertinoTabBar(
                activeColor: Colors.blueGrey,
                backgroundColor: Colors.amberAccent,
                iconSize: 50.0,
                currentIndex: _tab,
                onTap: onTap,
                items: TabItems.map((TabItem) {
                  return new BottomNavigationBarItem(
                    title: new Text(TabItem.title),
                    icon: new Icon(TabItem.icon),
                  );
                }).toList(),
              )
            : new BottomNavigationBar(
                currentIndex: _tab,
                fixedColor: Colors.blueGrey,
                onTap: onTap,
                iconSize: 25.0,
                items: TabItems.map((TabItem) {
                  return new BottomNavigationBarItem(
                    backgroundColor: Colors.amberAccent,
                    title: new Text(TabItem.title),
                    icon: new Icon(TabItem.icon),
                  );
                }).toList(),
              ),

        //Drawer
        drawer: new Drawer(
            child: new ListView(
          children: <Widget>[
            new Container(
              height: 120.0,
              child: new DrawerHeader(
                padding: new EdgeInsets.all(0.0),
                decoration: new BoxDecoration(
                  color: new Color(0xFFECEFF1),
                ),
                child: new Center(
                  child: new FlutterLogo(
                    colors: Colors.blueGrey,
                    size: 54.0,
                  ),
                ),
              ),
            ),
            new Container(
                          padding: new EdgeInsets.all(10.0) ,
                          decoration:
                              new BoxDecoration(color: Colors.amber),
                              child:Center(
              child: new Text(
              "Your Name Here",
              style: new TextStyle(color: Colors.white70, fontSize: 20.0),
            ),
            )
            ),
            new SizedBox(height: 10.0),
            new Center(
              child: new Text(
              "tonadun@gmail.com",
              style: new TextStyle(color: Colors.lightBlue),
            ),
            ),
            
            new SizedBox(height: 10.0,)

            ,
            // new ListTile(
            //     leading: new Icon(Icons.security),
            //     title: new Text('Login'),
            //     onTap: () {
            //       //Navigator.pop(context);
            //       Navigator.of(context).pushNamed('/login');
            //     }),
            // new ListTile(
            //     leading: new Icon(Icons.person_add),
            //     title: new Text('Register'),
            //     onTap: () {
            //       //Navigator.pop(context);
            //       Navigator.of(context).pushNamed('/register');
            //     }),
            new ListTile(
                leading: new Icon(Icons.chat),
                title: new Text('My Profile'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushNamed('/profile');
                }),
              new ListTile(
                leading: new Icon(Icons.chat),
                title: new Text('Customer'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushNamed('/customerview');
                }),


            new ListTile(
                leading: new Icon(Icons.settings),
                title: new Text('Settings'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushNamed('/settings');
                }),
            new ListTile(
                leading: new Icon(Icons.info),
                title: new Text('About'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushNamed('/about');
                }),
            new Divider(),
            new ListTile(
                leading: new Icon(Icons.exit_to_app),
                title: new Text('Sign Out'),
                onTap: signOut),
          ],
        )),
        floatingActionButton: 
        // new Padding(
        //   padding: new EdgeInsets.only(right: 20.0),
        //   child: new Stack(
        //     alignment: FractionalOffset.center,
        //     overflow: Overflow.visible,
        //     children: <Widget>[
        //       getAnimButton(), 
        //     ],
        //   )
        // )
        new RawMaterialButton(
          child: Image.asset(
            'assets/common/support.png',
            fit: BoxFit.cover,
          ),
          onPressed: () {
            //Navigator.pop(context);
            Navigator.of(context).pushNamed('/support');
          },
          shape: CircleBorder(),
          elevation: 6.0,
          fillColor: Colors.amber[900],
          splashColor: Colors.amber,
        )
        ,
      );

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
        break;

      case 1:
        this._title_app = TabItems[1].title;
        break;

      case 2:
        this._title_app = TabItems[2].title;
        break;

      case 3:
        this._title_app = TabItems[3].title;
        break;
    }
  }
}

class TabItem {
  const TabItem({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Home', icon: Icons.home),
  const TabItem(title: 'Dashboard', icon: Icons.pie_chart),
  const TabItem(title: 'Reminders', icon: Icons.access_alarm),
  const TabItem(title: 'Tools', icon: Icons.favorite)

];
