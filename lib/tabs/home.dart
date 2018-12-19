import 'package:flutter/material.dart';
import '../components/IM.dart';

class Home extends StatelessWidget {
 
 
  PageController _tabController;

  Home(PageController _tabController ){
    this._tabController = _tabController;
  }

  final VoidCallback onLayoutToggle = null;
  @override
  Widget build(BuildContext context) => new Container(
    child: CustomScrollView(
      slivers: <Widget>[
        
        SliverPersistentHeader(
            pinned: true,
            delegate: IMHeader(
              onLayoutToggle: onLayoutToggle,
              
              minExtent: 150.0,
              maxExtent: MediaQuery.of(context).size.width/2,
            ),
          ),
        
        
    
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width/2,
            
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
                      onPressed: () {
                        if(allMenus[index].url == "tab:tool"){
                          _tabController.jumpToPage(3);
                        }else{
                          Navigator.of(context).pushNamed(allMenus[index].url);
                        }
                        
                      },
                      type: ButtonTypes.action,
                      
                    ),)
              ;
            },
            childCount: 8,
          ),
        ),
      ],
    )
  );
}


List<Menu> allMenus = [
  Menu(name: 'CUSTOMER', url: '/customers', icon: new Icon(Icons.people)),
  Menu(name: 'POLICY', url: '/policies', icon: new Icon(Icons.assignment)),
  Menu(name: 'PAYMENT', url: '/payments', icon: new Icon(Icons.payment)),
  Menu(name: 'CLAIMS', url: '/claims', icon: new Icon(Icons.local_play)),
  Menu(name: 'APPOINTMENT', url: '/appointments', icon: new Icon(Icons.timer)),
  Menu(name: 'TO DO', url: '/todos', icon: new Icon(Icons.edit)),
  Menu(name: 'TOOLS', url: 'tab:tool', icon: new Icon(Icons.favorite)),
  Menu(name: 'SETTINGS', url: '/settings', icon: new Icon(Icons.settings)),
];

class Menu {
  Menu({this.name, this.url, this.icon});
  final String name;
  final String url;
  final Icon icon;
}