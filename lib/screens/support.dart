import 'package:flutter/material.dart';
import '../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:io';
import '../screens/user/auth.dart';


class Support extends StatefulWidget{

  String uid;
  String mid;

  Support() {
    new Auth().currentUser().then((userId) {
      uid = userId;
    });
  }

@override
  _SupportState createState() => new _SupportState();

}


class _SupportState extends State<Support> {

final formatter = new NumberFormat("00");

static const stream =
      const EventChannel('com.shynsoft.goyobi/stream');
static const stream2 =
      const EventChannel('com.shynsoft.goyobi/stream2');
static const stream3 =
      const EventChannel('com.shynsoft.goyobi/stream3');

  String _timer = "";
  String _CID = "";
  StreamSubscription _timerSubscription = null;
  StreamSubscription _timerSubscription2 = null;
  StreamSubscription _timerSubscription3 = null;

  void _enableTimer() {
    if (_timerSubscription == null) {
      _timerSubscription = stream.receiveBroadcastStream().listen(_updateTimer);
    }
  }

  void _enableTimer2() {
    if (_timerSubscription2 == null) {
      _timerSubscription2 = stream2.receiveBroadcastStream().listen(_updateTimer2);
      _disableTimer2();
      Firestore.instance.runTransaction((transaction) async {
                                await transaction.update( Firestore.instance.collection('members').document(widget.mid), {"call_supporter":"true"});
                              });

                            setState(() {

                            });
    }
  }

  void _enableTimer3() {
    if (_timerSubscription3 == null) {
      _timerSubscription3 = stream3.receiveBroadcastStream().listen(_updateTimer3);
      _disableTimer3();

      Firestore.instance.runTransaction((transaction) async {
                                await transaction.update( Firestore.instance.collection('members').document(widget.mid), {"call_supporter":"false"});
                              });

                            setState(() {

                            });
    }
  }

  void _disableTimer() {
    if (_timerSubscription != null) {
      _timerSubscription.cancel();
      _timerSubscription = null;
    }
  }

  void _disableTimer2() {
    if (_timerSubscription2 != null) {
      _timerSubscription2.cancel();
      _timerSubscription2 = null;
    }
  }

  void _disableTimer3() {
    if (_timerSubscription3 != null) {
      _timerSubscription3.cancel();
      _timerSubscription3 = null;
    }
  }

  void _updateTimer(timer) {
    debugPrint("Timer $timer");
    setState(() => _timer = timer);
  }

  void _updateTimer2(timer) {
    debugPrint("Timer $timer");
    //setState(() => _timer = timer);
  }

  
  void _updateTimer3(timer) {
    debugPrint("Timer $timer");
    //setState(() => _timer = timer);
  }

  @override
    void initState() { 
      super.initState();
      _timerSubscription = stream.receiveBroadcastStream().listen(_updateTimer);
      //_timerSubscription2 = stream2.receiveBroadcastStream().listen(_updateTimer2);

    }
  @override
  Widget build (BuildContext context) { 

    var timerCard = new Card(
        child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: const Icon(Icons.supervised_user_circle, color: Colors.deepOrange, size: 50.0,),
        title: const Text('Do you want an Analyze Report?'),
        subtitle: Container(
          child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('members')
                      .where("uid", isEqualTo: widget.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');

                    return Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {

                              widget.mid = document.documentID;
                              //setState(() { });

                              if(document["call_supporter"]=="true"){
                                return Text(
            "Don't worry if you are not happy with this feature You can Disable and Enable any Time.");
                              }else{
                                return Text(
            "You have not enabled this feature You can Enable any Time.");
                              }
                              
                            }).take(1).toList());
                  }),
        ),
         
      ),
      new Center(
        child: new Text(
          (_timer!=null)?'$_timer':" ",
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      new ButtonTheme.bar(
          child: new ButtonBar(children: <Widget>[
            StreamBuilder(
                  stream: Firestore.instance
                      .collection('members')
                      .where("uid", isEqualTo: widget.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');

                    return Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                              if(document["call_supporter"]=="true"){
                                return new FlatButton(
          child: const Text('Disable'),
          onPressed: _enableTimer3,
        );
                              }else{
                                return new FlatButton(
          child: const Text('Enable'),
          onPressed: _enableTimer2,
        );
                              }
                              
                            }).take(1).toList());
                  })
        ,
        
      ]))
    ]));
    
     

    return new Scaffold(

    //App Bar
    appBar: new IMAppBar(
      title: 'Call Supportor',
      context: context,
    ),

    //Content of tabs
    body: new PageView(
      children: <Widget>[
        new Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Column(
              
              mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    height: 100.0,
                    child: new ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("MINIMIZE APP"),
                          onPressed: (){
                            SystemNavigator.pop();
                          },
                        ),
                        RaisedButton(
                          child: Text("CLOSE APP"),
                          onPressed: (){
                             exit(0);
                          },
                        )
                      ],
                    ),
                  ),
                  timerCard,
                  (_timer!=null)?
                  //Tabbed Pane Start
                new Container(
                  height: 330.0,
                  child: DefaultTabController(
        length: 4,
        child: Scaffold(
          
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.assignment)),
                Tab(icon: Icon(Icons.timer)),
                Tab(icon: Icon(Icons.access_alarm)),
                Tab(icon: Icon(Icons.edit)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              new SingleChildScrollView(
                child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection("customers")
                                    .where("mobile", isEqualTo: _timer)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('...');
                                  if (snapshot.hasData)
                                    return  
                                    new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      
                                      children: 

                                      snapshot.data.documents.map((DocumentSnapshot document) {
                                        print("CID = "+_CID);
                                     _CID = document.documentID;
                                  return 
                                  new 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max, 
                                    
                                  children: <Widget>[
                                    Card(
                                      
                                      child: 
                                        new Container(
                                          width: MediaQuery.of(context).size.width-10.0,
                                          child: new Column(
                                        
                                      children: <Widget>[
                                        new SizedBox(height: 14.0,),
                                        new Text("("+document["name"]+")", style: TextStyle(fontSize: 16.0)),
                                        new Text(" "+document["address"]+" ", style: TextStyle(fontSize: 11.0)),
                                        new Text(" "+document["nic"]+" ", style: TextStyle(fontSize: 12.0)),
                                        new Text(" "+document["email"]+" ", style: TextStyle(fontSize: 12.0)),
                                        new Text(" "+document["home"]+" ", style: TextStyle(fontSize: 12.0)),
                                        
                                        new SingleChildScrollView(
                                          child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection("policies")
                                    .where("id", isEqualTo: document.documentID)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('...');
                                    return  
                                    new Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      
                                      children: 

                                      snapshot.data.documents.map((DocumentSnapshot document) {
                                  return 
                                  new 
                                  Row(
                                    
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min, 
                                    
                                  children: <Widget>[
                                    Card(
                                      
                                      child: 
                                        new Container(
                                          width: MediaQuery.of(context).size.width-20.0,
                                          height: 140.0,
                                          child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                        
                                      children: <Widget>[
                                        ListTile(
        leading: Icon((document["type"]==1)?Icons.assignment_ind:(document["type"]==2)?Icons.directions_car:Icons.device_hub, size: 60.0,),
        title: Text(document["name"]),
        subtitle: Text("Premium : "+document["premium"]),
      ),

                                        
                                        (document["type"]==1)?new Text("Policy No: "+document["policyno"], style: TextStyle(fontSize: 14.0)):new Container(width: 0.0,),
                                        (document["type"]==2)?new Text("Vehicle No: "+document["vehicleno"], style: TextStyle(fontSize: 14.0)):new Container(width: 0.0,),
                                        (document["type"]>=3)?new Text("Policy No: "+document["policyno"], style: TextStyle(fontSize: 14.0)):new Container(width: 0.0,),
                                        (document["type"]==1)?new Text("Policy Name: "+document["policyname"], style: TextStyle(fontSize: 14.0)):new Container(width: 0.0,),
                                        (document["type"]==2)?new Text("Sum: "+document["sum"], style: TextStyle(fontSize: 14.0)):new Container(width: 0.0,),
                                        (document["type"]==1)?new Text("Next Payment: "+document["nextpayment"], style: TextStyle(fontSize: 14.0)):new Container(width: 0.0,),
                                        new Container(height: 20.0,)
                                      ],
                                      ),

                                        )
                                        ,)
                                  ],);
                                  
                                  
                                    }).toList()
                                    ,);
                                    
                                },
                              ),
                                        )

                                      ],
                                      ),

                                        )
                                        ,)
                                  ],);
                                  
                                  
                                    }).toList()
                                    ,);

                                    return new Container(width:0.0);
                                    
                                },
                              )
              ),

              new SingleChildScrollView(
                child: 
                new SingleChildScrollView(
                                          child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection("appointments")
                                    .where("mobile", isEqualTo: _timer)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text(' No Data Found ');
                                    return  
                                    new Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      
                                      children: 

                                      snapshot.data.documents.map((DocumentSnapshot document) {
                                  return 
                                  new 
                                  Row(
                                    
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min, 
                                    
                                  children: <Widget>[
                                    Card(
                                      
                                      child: 
                                        new Container(
                                          width: MediaQuery.of(context).size.width-20.0,
                                          height: 150.0,
                                          child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                        
                                      children: <Widget>[
                                        new SizedBox(height: 10.0,),
                                        ListTile(
        leading: Icon(Icons.timer, size: 60.0,),
        title: Text(document["name"]),
        subtitle: Text("Place : "+document["place"]),
      ),

                                        
                                       new Text("Start: "+document["start"], style: TextStyle(fontSize: 14.0)),
                                       new Text("End: "+document["end"], style: TextStyle(fontSize: 14.0)),
                                       new Text("Remarks: "+document["remarks"], style: TextStyle(fontSize: 14.0)),
                                       new Container(height: 20.0,)
                                      ],
                                      ),

                                        )
                                        ,)
                                  ],);
                                  
                                  
                                    }).toList()
                                    ,);
                                    
                                },
                              ),
                                        )
              ),
              new SingleChildScrollView(
                child: 
                new SingleChildScrollView(
                                          child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection("reminders")
                                    .where("customer_id", isEqualTo: _CID)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text(' No Data Found ');
                                    return  
                                    new Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      
                                      children: 

                                      snapshot.data.documents.map((DocumentSnapshot document) {
                                  return 
                                  new 
                                  Row(
                                    
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min, 
                                    
                                  children: <Widget>[
                                    Card(
                                      
                                      child: 
                                        new Container(
                                          width: MediaQuery.of(context).size.width-20.0,
                                          height: 150.0,
                                          child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                        
                                      children: <Widget>[
                                        new SizedBox(height: 10.0,),
                                        ListTile(
        leading: Icon(document["level"]=="1"?Icons.question_answer:document["level"]=="2"?Icons.check:document["level"]=="3"?Icons.cake:Icons.timer, size: 60.0,),
        title: Text(document["text"]),
        subtitle: Text("Remind : "+formatter
                                            .format(document['remind_on'].day) +
                                        "/" +
                                        formatter.format(
                                            document['remind_on'].month) +
                                        "/" +
                                        formatter.format(
                                            document['remind_on'].year) ),
      ),

                                        
                                       new Container(height: 20.0,)
                                      ],
                                      ),

                                        )
                                        ,)
                                  ],);
                                  
                                  
                                    }).toList()
                                    ,);
                                    
                                },
                              ),
                                        )
              ),
              new SingleChildScrollView(
                child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection("todos")
                                    .where("customer_id", isEqualTo: _CID)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text(' No Data Found ');
                                    return  
                                    new Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      
                                      children: 

                                      snapshot.data.documents.map((DocumentSnapshot document) {
                                  return 
                                  new 
                                  Row(
                                    
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min, 
                                    
                                  children: <Widget>[
                                    Card(
                                      
                                      child: 
                                        new Container(
                                          width: MediaQuery.of(context).size.width-20.0,
                                          height: 140.0,
                                          child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                        
                                      children: <Widget>[
                                        new SizedBox(height: 10.0,),
                                        ListTile(
        leading: Icon((document["done"])?Icons.check:Icons.edit, size: 60.0,),
        title: Text(document["name"]),
        subtitle: Text("Due : "+formatter
                                            .format(document['do_on'].day) +
                                        "/" +
                                        formatter.format(
                                            document['do_on'].month) +
                                        "/" +
                                        formatter.format(
                                            document['do_on'].year)),
      ),

                                        
                                       new Text("Creates: "+formatter
                                            .format(document['created_on'].day) +
                                        "/" +
                                        formatter.format(
                                            document['created_on'].month) +
                                        "/" +
                                        formatter.format(
                                            document['created_on'].year), style: TextStyle(fontSize: 14.0)),
                                       
                                       new Container(height: 20.0,)
                                      ],
                                      ),

                                        )
                                        ,)
                                  ],);
                                  
                                  
                                    }).toList()
                                    ,);
                                    
                                },
                              )
              )
              
            ],
          ),
        )
                  )
            )
                  //Tabbed Pane End
                  
                              :
                              new Container(
                                child: new Text("No Calls Found Recently."),
                              )
                  
                ],
              ) ,
            
          ],
        )
      ],
    ),
  );

  }
}