import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/IM.dart';
import '../../components/entities/IMObject.dart';
import '../../screens/user/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class ListingState<T extends StatefulWidget> extends State<T>  with TickerProviderStateMixin {
  static DateTime now = DateTime.now();
  
  String title;
  String table;
  List columns;

  String uid;

  //FAB Multi
  AnimationController _controller;
  
  

  ListingState() {
    this.title = "ENTITIES";
    this.table = "tables";
    this.columns = new List();
  }

  ListingState.more(String title, String table, List columns) {
    this.title = title;
    this.table = table;
    this.columns = columns;
    new Auth().currentUser().then((userId) {
      setState(() {
        uid = userId;
      });
    });
  }

  TextEditingController controller = new TextEditingController();
  String filter = "";
  int sort = 0;
  String selectedId = '';
  bool _hide = true;

  TabController _tabController;

  int selectedIndex = 0;
   

  void _handleTabSelection() {
    setState(() {
      selectedIndex = _tabController.index;
    });
  }

  @override
  initState() {

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _tabController = new TabController(vsync: this, initialIndex: 0, length: 8);
    _tabController.addListener(_handleTabSelection);
  

    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSortChanged() {
    setState(() {
      filter = controller.text;
      sort++;
      if (sort > 2) {
        sort = 0;
      }
    });
  }

  var map = new Map<String, dynamic>();

  @override
  Widget build(BuildContext context) {

    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

    double w = 24.0;
    double h = 24.0;
    List<String> texts = ["Life","Motor","Fire","DTA","Title","Medical","Retire"];
    List<Widget> icons = [ 
    Icon(Icons.assignment_ind, color: foregroundColor), 
    Icon(Icons.directions_car, color: foregroundColor),
    Icon(Icons.whatshot, color: foregroundColor),   
    Text("DTA", style: new TextStyle(color: foregroundColor, fontSize: 13.0),), 
    Icon(Icons.business, color: foregroundColor),  
    Icon(Icons.healing, color: foregroundColor),  
    Icon(Icons.nature_people, color: foregroundColor) 
    ];

     return new Scaffold(
      //App Bar
      appBar: new IMAppBar(
        title: this.title,
        context: context,
        bottom: (this.table == "policies")?
         TabBar(
              tabs: [
                Tab(icon: Icon(Icons.all_inclusive),),
                Tab(icon: Icon(Icons.assignment_ind),),
                Tab(icon: Icon(Icons.directions_car),),
                Tab(icon: Icon(Icons.whatshot),),
                Tab(text: "DTA",),
                Tab(icon: Icon(Icons.business),),
                Tab(icon: Icon(Icons.healing),),
                Tab(icon: Icon(Icons.nature_people),),
              ],
              labelColor: Colors.white,
              controller: _tabController,
              isScrollable: true,
            ):
            (this.table == "customers")?
         TabBar(
              tabs: [
                Tab(icon: Icon(Icons.all_inclusive),text: "ALL",),
                Tab(icon: Icon(Icons.new_releases),text: "PROSPECTIVE",),
                Tab(icon: Icon(Icons.assignment),text: "EXISTING",),
              ],
              labelColor: Colors.white,
              controller: _tabController,
            )
            :
            (this.table == "appointments")?
         TabBar(
              tabs: [
                Tab(icon: Icon(Icons.all_inclusive),text: "ALL",),
                Tab(icon: Icon(Icons.filter_vintage ),text: "UPCOMMING",),
                Tab(icon: Icon(Icons.forum ),text: "MET",),
              ],
              labelColor: Colors.white,
              controller: _tabController,
            )
            :null,
      ),
      floatingActionButton: (this.table!="policies")? IMButton(
        title: "",
        icon: new Icon(Icons.add),
        context: context,
        onPressed: () {
          Navigator
              .of(context)
              .pushNamed('/' + table.substring(0, table.length - 1) + 'create');
        },
        type: ButtonTypes.danger,
      ):
      new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 65.0,
            width: 116.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(
                  0.0,
                  1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut
                ),
              ),
              child: 
              new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(4.0),
                    
                    decoration: BoxDecoration(borderRadius: new BorderRadius.circular(5.0),
    color: Colors.cyan,),
                    
                    width: 70.0,
                   child: new Text(texts[index], style: TextStyle(color: Colors.white),)
                  ),
                  new SizedBox(width: 5.0,)
                  ,
                  new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true, 
                
                child: 
                icons[index]
                // new Column(
                //   children: <Widget>[
                //     new Padding(
                //       padding: EdgeInsets.all(3.0),
                //       child: ,
                //     ),
                    
                //     //new Text(texts[index], style: new TextStyle(fontSize: 7.0),)
                //   ],
                // )
                ,
                onPressed: () {
                  if(table=="policies"){
                    switch(index){
                      case 0: //Life
                      Navigator.of(context).pushNamed('/policylifecreate');
                      break;
                      case 1: //Motor
                      Navigator.of(context).pushNamed('/policymotorcreate');
                      break;

                      case 2: //Fire
                      Navigator.of(context).pushNamed('/policyfirecreate');
                      break;

                      case 3: //DTA
                      Navigator.of(context).pushNamed('/policydtacreate');
                      break;

                      case 4: //Title
                      Navigator.of(context).pushNamed('/policytitlecreate');
                      break;

                      case 5: //Medical
                      Navigator.of(context).pushNamed('/policymedicalcreate');
                      break;

                      case 6: //Retirement
                      Navigator.of(context).pushNamed('/policyretirementcreate');
                      break;


                    }
                  }

                },
              )
                ],
              )
              ,
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.PI),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed ? Icons.add : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
      )
      ,

      //Content of tabs
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.search),
            title: new TextField(
              controller: controller,
              decoration: new InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              //onChanged: onSearchTextChanged,
            ),
            trailing: new Container(
                width: 100.0,
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        controller.clear();
                      },
                    ),
                    new IconButton(
                      icon: new Icon(
                          (sort == 0) ? Icons.sort : Icons.sort_by_alpha),
                      onPressed: () {
                        onSortChanged();
                      },
                    ),
                  ],
                )),
          ),
          new Expanded(
            //alignment: Alignment.topCenter,
            child: StreamBuilder(
              stream: (sort == 1)? 
                  ( (table=="policies" || table=="customers"|| table=="appointments") && selectedIndex>0)?
                  Firestore.instance
                      .collection(this.table)
                      .where("uid", isEqualTo: uid)
                      .where("type", isEqualTo: selectedIndex)
                      .orderBy(this.columns[0])
                      .snapshots()
                  :Firestore.instance
                      .collection(this.table)
                      .where("uid", isEqualTo: uid)
                      .orderBy(this.columns[0])
                      .snapshots()
                  : (sort == 2)?
                    ((table=="policies" || table=="customers"|| table=="appointments")  && selectedIndex>0)?
                      Firestore.instance
                          .collection(this.table)
                          .where("uid", isEqualTo: uid)
                          .where("type", isEqualTo: selectedIndex)
                          .orderBy(this.columns[0], descending: true)
                          .snapshots()
                      :Firestore.instance
                      .collection(this.table)
                      .where("uid", isEqualTo: uid)
                      .orderBy(this.columns[0])
                      .snapshots()
                      : 
                      ((table=="policies" || table=="customers"|| table=="appointments")  && selectedIndex>0)?
                      Firestore.instance
                          .collection(this.table)
                          .where("uid", isEqualTo: uid)
                          .where("type", isEqualTo: selectedIndex)
                          .snapshots()
                      :Firestore.instance
                        .collection(this.table)
                        .where("uid", isEqualTo: uid)
                        .orderBy(this.columns[0])
                        .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text('...');
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    //bool done = document["done"];
                    //map[document.documentID] = document["done"];
                    String name = document[this.columns[0]].toString();
                    if (name.toLowerCase().contains(filter.toLowerCase())) {
                      return Dismissible(
                        key: new Key(document.documentID),
                        background: new Container(
                          decoration:
                              new BoxDecoration(color: Colors.pinkAccent),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                "    Delete?",
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                        )
                            // new Column(

                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[

                            //     new Text("    Delete?"),

                            //   ],
                            // )
                            ,
                        onDismissed: (direction) {

                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: new Text("Confirm"),
                                content: new SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text("Are you sure you want to Delete?")
                                    ],
                                  ),
                                  
                                ),
                                actions: <Widget>[
                                  RaisedButton(
                                    onPressed: (){
                                      Firestore.instance
                                      .document(this.table + '/${document.documentID}')
                                      .delete();
                                      snapshot.data.documents.remove(document);
                                      Scaffold.of(context).showSnackBar(new SnackBar(
                                        content: new Text("Removed!"),
                                      ));
                                    },
                                    splashColor: Colors.amber,
                                    highlightColor: Colors.amber,
                                    color: Colors.deepOrange,
                                    child: Text("YES Delete!", style: TextStyle(color: Colors.white),),
                                  ),
                                  FlatButton(
                                    onPressed: (){

                                      Navigator.pop(context); 
                                      Navigator.of(context).popAndPushNamed('/'+this.table);
                                    } ,
                                    child: Text("CANCEL"),
                                  )
                                ],
                              );
                            }
                          );
                          
                        },
                        child: 
                        (this.table=="customers")?
                          new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });



                                  },
                                title: new Text(document['name']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (
                                      mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['mobile']!='')?new Icon(Icons.call, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['mobile']!='')?
                                    new Container(              
                                      width: 80.0,
                                      child: new Text(document['mobile'], style: TextStyle(fontSize: 10.0))
                                    )
                                    :new SizedBox( width: 80.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['bday']!='' && now.month.toString() == document['bday'].split("-")[1])?new Icon(Icons.cake, size: 14.0, color: Colors.pinkAccent):new SizedBox(width: 14.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['bday']!='' && now.month.toString() ==  document['bday'].split("-")[1])?
                                     new Container(              
                                      width:50.0,
                                      child: new Text(document['bday'].split("-")[1]+"/"+document['bday'].split("-")[2] + "("+(now.year - int.tryParse(document['bday'].split("-")[0])).toString()+")", style: TextStyle(fontSize: 10.0)),
                                    ):new SizedBox( width: 50.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    //-----------------------------------------------------------------------------------
                                    StreamBuilder(
                                stream: Firestore.instance
                                    .collection("policies")
                                    .where("uid", isEqualTo: uid)
                                    .where("id", isEqualTo: document.documentID)
                                    .where("type", isEqualTo: 1)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('...');
                                  return (snapshot.data.documents.length>0)?new Column(
                                      children: <Widget>[
                                        new Icon(Icons.assignment_ind, size: 18.0, color: Colors.green,),
                                        new Text("("+snapshot.data.documents.length.toString()+")", style: TextStyle(fontSize: 11.0))
                                        , 
                                        new SizedBox(
                                          width: 25.0,
                                        )
                                      ],
                                      ):new Container();
                                },
                              ),
                              StreamBuilder(
                                stream: Firestore.instance
                                    .collection("policies")
                                    .where("uid", isEqualTo: uid)
                                    .where("id", isEqualTo: document.documentID)
                                    .where("type", isEqualTo: 2)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('...');
                                  return (snapshot.data.documents.length>0)?new Column(
                                      children: <Widget>[
                                        new Icon(Icons.directions_car, size: 18.0,color: Colors.purple,),
                                        new Text("("+snapshot.data.documents.length.toString()+")", style: TextStyle(fontSize: 11.0))
                                      ],
                                      ):new Container();
                                },
                              ),
                              StreamBuilder(
                                stream: Firestore.instance
                                    .collection("policies")
                                    .where("uid", isEqualTo: uid)
                                    .where("id", isEqualTo: document.documentID)
                                    .where("type", isGreaterThanOrEqualTo: 3)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('');
                                  return (snapshot.data.documents.length>0)?new Column(
                                      children: <Widget>[
                                        new Icon(Icons.assignment_ind, size: 18.0,),
                                        new Text("("+snapshot.data.documents.length.toString()+")", style: TextStyle(fontSize: 11.0))
                                      ],
                                      ):new Container();
                                },
                              )


                                    //-----------------------------------------------------------------------------------


                                  ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['mobile']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['email']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['mobile']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        
                                    child: Text(document['name'][0]),
                                    )
                                    ],
                                      
                                  )
                                  
                              ),
                              ):
                              (this.table=="appointments")?
                              new Card(

                                child: ListTile(
                                  onLongPress: (){



                                    showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: new Text("Confirm"),
                                content: new SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text("Did You Meet?")
                                    ],
                                  ),
                                  
                                ),
                                actions: <Widget>[
                                  RaisedButton(
                                    onPressed: (){
                                      
                                      final DocumentReference postRef = Firestore.instance.document(this.table + '/${document.documentID}');
                                      Firestore.instance.runTransaction((Transaction tx) async {
                                          DocumentSnapshot postSnapshot = await tx.get(postRef);
                                          if (postSnapshot.exists) {
                                            await tx.update(postRef, <String, dynamic>{'type': 2});
                                          }
                                      });
                                      Navigator.pop(context);
                                      
                                    },
                                    splashColor: Colors.amber,
                                    highlightColor: Colors.amber,
                                    color: (document['type']==1)?Colors.cyan:Colors.amber,
                                    child: Text((document['type']==1)?"YES, I Met!":"Nope, We Didn't Met", style: TextStyle(color: Colors.white),),
                                  ),
                                  FlatButton(
                                    onPressed: (){

                                      Navigator.pop(context);
                                    } ,
                                    child: Text("Cancel"),
                                  )
                                ],
                              );
                            }
                          );
                                  },
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });

                                    
                                  },
                                title: new Text(document['name']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    (document['mobile']!='')?new Icon(Icons.call, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['mobile']!='')?
                                    new Container(              
                                      width: 100.0,
                                      child: new Text(document['mobile'])
                                    )
                                    :new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['place']!='')?new Icon(Icons.map, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['place']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['place'])
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['start']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['start']!='')?
                                     new Container( 
                                      child: new Text(document['start']+"  " +document['end'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                 new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['mobile']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['email']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['mobile']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: (document['type']==2)?Colors.green:null,
                                        child: Text((document['name']!="")?document['name'][0]:"A"),
                                      )
                                    ],
                                      
                                  )
                                  
                              ),
                              )
                              :
                              (this.table=="policies")?

                              policy(document)

                              :
                              IMListTile(
                            obj: IMObject(
                          key: document[this.columns[0]].toString(),
                          title: document[this.columns[0]].toString(),
                          subtitle: document[this.columns[1]].toString() +
                              ((this.columns.length > 2)
                                  ? " - " + document[this.columns[2]].toString()
                                  : ""),
                        ))
                        

                        
                      );
                    } else {
                      return new Container();
                    }
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ));
  }

  Widget policy(DocumentSnapshot document){
      if(document['type']==1){
        return policy1(document);
      }else if(document['type']==2){
        return policy2(document);
      }else if(document['type']==3){
        return policy3(document);
      }else if(document['type']==4){
        return policy4(document);
      }else if(document['type']==5){
        return policy5(document);
      }else if(document['type']==6){
        return policy6(document);
      }else if(document['type']==7){
        return policy7(document);
      }else if(document['type']==8){
        return policy8(document);
      } else{
        return Container(width:0.0);
      }
      
    }
    

    Widget policy1(DocumentSnapshot document){
      return new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });
                                  },
                                title: new Text(document['policyno']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    
                                    (document['name']!='')?new Icon(Icons.person, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['name']!='')?
                                    new Container(              
                                      width: 220.0,
                                      child: new Text(document['name'])
                                    )
                                    :new SizedBox( width: 220.0),
                                    
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row(
                                    children: <Widget>[
                                     (document['premium']!='')?new Icon(Icons.monetization_on , size: 16.0, color: Colors.blue):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['premium']!='')?
                                    new Container(              
                                      width: 60.0,
                                      child: new Text(document['premium'])
                                    )
                                    :new SizedBox( width: 60.0),
                                    
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['policyperiod']!='')?new Icon(Icons.calendar_view_day, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0)
                                    ,
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['policyperiod']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['policyperiod'])
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['commenceddate']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['commenceddate']!='')?
                                     new Container( 
                                      child: new Text(document['commenceddate'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['name']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['name']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['name']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                    child: new Icon(Icons.assignment_ind, size: 22.0, color: Colors.green),
                                      )
                                    ],
                                      
                                  )
                                  
                              ),
                              );
    }

     Widget policy2(DocumentSnapshot document){
      return new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });
                                  },
                                title: new Text(document['vehicleno']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    
                                    (document['name']!='')?new Icon(Icons.person, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['name']!='')?
                                    new Container(              
                                      width: 220.0,
                                      child: new Text(document['name'])
                                    )
                                    :new SizedBox( width: 220.0),
                                    
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row(
                                    children: <Widget>[
                                    
                                    (document['premium']!='')?new Icon(Icons.monetization_on, size: 16.0, color: Colors.blue):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['premium']!='')?
                                    new Container(              
                                      width: 100.0,
                                      child: new Text(document['premium'].toString())
                                    )
                                    :new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['period']!='')?new Icon(Icons.calendar_view_day, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0)
                                    ,
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['period']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['period'].toString())
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['start']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['start']!='')?
                                     new Container( 
                                      child: new Text(document['start'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['name']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['name']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['name']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        child: new Icon(Icons.directions_car, size: 22.0, color: Colors.purple),
                                      )
                                    ],
                                      
                                  )
                                  
                              ),
                              );
    }

      Widget policy3(DocumentSnapshot document){
      return new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });
                                  },
                                title: new Text(document['policyno']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    
                                    (document['name']!='')?new Icon(Icons.people, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['duedate']!='')?
                                    new Container(              
                                      width: 100.0,
                                      child: new Text(document['duedate'].toString())
                                    )
                                    :new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['premium']!='')?new Icon(Icons.calendar_view_day, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0)
                                    ,
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['premium']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['premium'].toString())
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['due']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['due']!='')?
                                     new Container( 
                                      child: new Text(document['due'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['name']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['name']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['name']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        
                                    child: Text((document['name']!="")?document['name'][0]:"A"),
                                    )
                                    ],
                                      
                                  )
                                  
                              ),
                              );
    }

    Widget policy4(DocumentSnapshot document){
      return new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });
                                  },
                                title: new Text(document['policyno']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    
                                    (document['name']!='')?new Icon(Icons.people, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['loanvalue']!='')?
                                    new Container(              
                                      width: 100.0,
                                      child: new Text(document['loanvalue'].toString())
                                    )
                                    :new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['premium']!='')?new Icon(Icons.calendar_view_day, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0)
                                    ,
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['premium']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['premium'].toString())
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['due']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['due']!='')?
                                     new Container( 
                                      child: new Text(document['due'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['name']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['name']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['name']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        
                                    child: Text((document['name']!="")?document['name'][0]:"A"),
                                    )
                                    ],
                                      
                                  )
                                  
                              ),
                              );
    }

    Widget policy5(DocumentSnapshot document){
      return new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });
                                  },
                                title: new Text(document['policyno']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    
                                    (document['name']!='')?new Icon(Icons.people, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['loanvalue']!='')?
                                    new Container(              
                                      width: 100.0,
                                      child: new Text(document['loanvalue'].toString())
                                    )
                                    :new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['premium']!='')?new Icon(Icons.calendar_view_day, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0)
                                    ,
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['premium']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['premium'].toString())
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['due']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['due']!='')?
                                     new Container( 
                                      child: new Text(document['due'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['name']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['name']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['name']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        
                                    child: Text((document['name']!="")?document['name'][0]:"A"),
                                    )
                                    ],
                                      
                                  )
                                  
                              ),
                              );
    }
    Widget policy6(DocumentSnapshot document){
      return new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });
                                  },
                                title: new Text(document['name']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    
                                    (document['contactperson']!='')?new Icon(Icons.people, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['number']!='')?
                                    new Container(              
                                      width: 100.0,
                                      child: new Text(document['number'].toString())
                                    )
                                    :new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['renewal']!='')?new Icon(Icons.calendar_view_day, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0)
                                    ,
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['renewal']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['renewal'].toString())
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['premium']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['premium']!='')?
                                     new Container( 
                                      child: new Text(document['premium'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['name']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['name']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['name']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        
                                    child: Text((document['name']!="")?document['name'][0]:"A"),
                                    )
                                    ],
                                      
                                  )
                                  
                              ),
                              );
    }

    Widget policy7(DocumentSnapshot document){
      return new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });
                                  },
                                title: new Text(document['name']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    
                                    (document['mobile']!='')?new Icon(Icons.people, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['address']!='')?
                                    new Container(              
                                      width: 100.0,
                                      child: new Text(document['address'].toString())
                                    )
                                    :new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['start']!='')?new Icon(Icons.calendar_view_day, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0)
                                    ,
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['start']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['start'].toString())
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['end']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['end']!='')?
                                     new Container( 
                                      child: new Text(document['end'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['name']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['name']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['name']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        
                                    child: Text((document['name']!="")?document['name'][0]:"A"),
                                    )
                                    ],
                                      
                                  )
                                  
                              ),
                              );
    }

    Widget policy8(DocumentSnapshot document){
      return new Card(

                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      selectedId = document.documentID;
                                    });
                                  },
                                title: new Text(document['name']),
                                subtitle: 
                                new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                    ),
                                    new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    
                                    (document['mobile']!='')?new Icon(Icons.people, size: 16.0, color: Colors.amber):new SizedBox(width: 16.0),
                                    
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    (document['address']!='')?
                                    new Container(              
                                      width: 100.0,
                                      child: new Text(document['address'].toString())
                                    )
                                    :new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    (document['start']!='')?new Icon(Icons.calendar_view_day, size: 16.0, color: Colors.pinkAccent):new SizedBox(width: 16.0)
                                    ,
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['start']!='')?
                                     new Container(              
                                      width: 100.0,
                                      child: new Text(document['start'].toString())
                                    ):new SizedBox( width: 100.0),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                  ]),
                                  new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 7.0,)
                                      ],
                                    ),
                                  new Row /*or Column*/ (

                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    (document['end']!='')?new Icon(Icons.calendar_today, size: 16.0, color: Colors.green):new SizedBox(width: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                     (document['end']!='')?
                                     new Container( 
                                      child: new Text(document['end'])
                                    ):new SizedBox( width: 60.0),
                                  ],
                                ),
                                new Row(
                                      children: <Widget>[
                                        new SizedBox(height: 5.0,)
                                      ],
                                ),
                                (selectedId==document.documentID)?
                                new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
                                    new ButtonBar(
                                      children: <Widget>[
                                        new MaterialButton(onPressed: (){ launch("tel://"+document['name']); }, child: new Icon(Icons.phone), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("mailto:"+document['name']); },child: new Icon(Icons.email), elevation: 4.0, minWidth: 30.0,),
                                        new MaterialButton(onPressed: (){ launch("sms:"+document['name']); },child: new Icon(Icons.sms),  elevation: 4.0, minWidth: 30.0,)
                                      ],
                                    )

                                ],):new Container()
                                  ],
                                )
                                ,
                                leading: 
                                  new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        
                                    child: Text((document['name']!="")?document['name'][0]:"A"),
                                    )
                                    ],
                                      
                                  )
                                  
                              ),
                              );
    }
}