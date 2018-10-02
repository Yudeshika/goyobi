import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './tabs/home.dart' as _firstTab;
import './tabs/dashboard.dart' as _secondTab;
import './tabs/reminders.dart' as _thirdTab;
import './tabs/tools.dart' as _fourthTab;
import './screens/about.dart' as _aboutPage;
import './screens/support.dart' as _supportPage;
import './screens/settings.dart' as _settingsPage;

import './screens/user/login.dart' as _loginPage;
import './screens/user/register.dart' as _registerPage;
import './screens/todo/index.dart' as _todosPage;
import './screens/todo/create.dart' as _todosCreatePage;
import './screens/customer/create.dart' as _customerCreatePage;
import './screens/customer/index.dart' as _customerListPage;
import './screens/appointment/create.dart' as _appointmentCreatePage;
import './screens/appointment/index.dart' as _appointmentListPage;


import './screens/tools/calc.dart' as _calcPage;
import './screens/tools/bmi.dart' as _bmiPage;
import './components/IM.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Goyobi',
  theme: new ThemeData(
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.cyan, backgroundColor: Colors.white
  ),
  home: new Tabs(),
  onGenerateRoute: (RouteSettings settings) {
    switch (settings.name) {
      case '/login': return new FromRightToLeft(
        builder: (_) => new _loginPage.Login(),
        settings: settings,
      );
      case '/register': return new FromRightToLeft(
        builder: (_) => new _registerPage.Register(),
        settings: settings,
      );
      case '/about': return new FromRightToLeft(
        builder: (_) => new _aboutPage.About(),
        settings: settings,
      );
      case '/support': return new FromRightToLeft(
        builder: (_) => new _supportPage.Support(),
        settings: settings,
      );
      case '/settings': return new FromRightToLeft(
        builder: (_) => new _settingsPage.Settings(),
        settings: settings,
      );
      case '/todos': return new FromRightToLeft(
        builder: (_) => new _todosPage.ToDos(),
        settings: settings,
      );

      
      
      case '/customers': return new FromRightToLeft(
        builder: (_) => new _customerListPage.Customers(),
        settings: settings,
      );
      case '/customercreate': return new FromRightToLeft(
        builder: (_) => new _customerCreatePage.CustomerCreate(),
        settings: settings,
      );
      
      case '/appointments': return new FromRightToLeft(
        builder: (_) => new _appointmentListPage.Appointments(),
        settings: settings,
      );
      case '/appointmentcreate': return new FromRightToLeft(
        builder: (_) => new _appointmentCreatePage.AppointmentCreate(),
        settings: settings,
      );

      //Tools
      case '/calc': return new FromRightToLeft(
        builder: (_) => new _calcPage.Calc(),
        settings: settings,
      );
      case '/bmi': return new FromRightToLeft(
        builder: (_) => new _bmiPage.BMI(),
        settings: settings,
      );
    }
  },
  // routes: <String, WidgetBuilder> {
  //   '/about': (BuildContext context) => new _aboutPage.About(),
  // }
));

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {

    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0,
            )
          ]
        ),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      )
      .animate(
        new CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )
      ),
    );
  }
  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  
  PageController _tabController;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    appBar: (_tab==0)?null:new IMAppBar(
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
    bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS ?
      new CupertinoTabBar(
        activeColor: Colors.blueGrey,
        backgroundColor: Colors.amberAccent,
        iconSize:50.0,
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
      ):
      new BottomNavigationBar(
        currentIndex: _tab,
        fixedColor: Colors.blueGrey,
        onTap: onTap,
        iconSize:25.0,
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
          new ListTile(
            leading: new Icon(Icons.security),
            title: new Text('Login'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.of(context).pushNamed('/login');
            }
          ),
          new ListTile(
            leading: new Icon(Icons.person_add),
            title: new Text('Register'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.of(context).pushNamed('/register');
            }
          ),
          new ListTile(
            leading: new Icon(Icons.chat),
            title: new Text('Support'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.of(context).pushNamed('/support');
            }
          ),
          new ListTile(
            leading: new Icon(Icons.settings),
            title: new Text('Settings'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.of(context).pushNamed('/settings');
            }
          ),new ListTile(
            leading: new Icon(Icons.info),
            title: new Text('About'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.of(context).pushNamed('/about');
            }
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
            }
          ),
        ],
      )
    ),
    floatingActionButton: new RawMaterialButton(
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
        ),

  );

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
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
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Home', icon: Icons.home),
  const TabItem(title: 'Dashboard', icon: Icons.pie_chart),
  const TabItem(title: 'Reminders', icon: Icons.access_alarm),
  const TabItem(title: 'Tools', icon: Icons.favorite)
];