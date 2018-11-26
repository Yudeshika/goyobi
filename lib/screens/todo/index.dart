import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/IM.dart';
import '../../components/entities/IMObject.dart';

import '../../screens/user/auth.dart';
class ToDos extends StatefulWidget {

String uid;
  ToDos(){
     new Auth().currentUser().then((userId) {
      uid = userId;
            
    });
  } 
   @override
  _ToDosState createState() => new _ToDosState();


}
class _ToDosState extends State<ToDos> with SingleTickerProviderStateMixin{

  var map = new Map<String, bool>();
  TabController _tabController;

  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();

   //  ...
  _tabController = new TabController(vsync: this, initialIndex: 0, length: 3);
  _tabController.addListener(_handleTabSelection);
  
  }

void _handleTabSelection() {
    setState(() {
      selectedIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: 'TO DOs',
          context: context,
          bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.check_box_outline_blank), text: "TO DO",),
                Tab(icon: Icon(Icons.done), text: "DONE",),
                Tab(icon: Icon(Icons.all_inclusive), text: "ALL",),
              ],
              labelColor: Colors.white,
              controller: _tabController,

            ),
        ),

        floatingActionButton: new IMButton(
          title: "",
          icon:new Icon(Icons.add),
          context: context,
          onPressed: () {
            Navigator.of(context).pushNamed('/todocreate');
          },
          type: ButtonTypes.danger,
        ),


        //Content of tabs
        body: new Container(
          child: new Align(
            alignment: Alignment.topCenter,
            child: StreamBuilder(
              stream: 
              (selectedIndex==0)?
              Firestore.instance.collection('todos')
              .where("uid", isEqualTo: widget.uid)
              .where("done", isEqualTo: false).snapshots():
              (selectedIndex ==1)?
              Firestore.instance.collection('todos')
              .where("uid", isEqualTo: widget.uid)
              .where("done", isEqualTo: true).snapshots():
              Firestore.instance.collection('todos')
              .where("uid", isEqualTo: widget.uid).snapshots()
              ,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    //bool done = document["done"];
                    map[document.documentID] = document["done"];
                    return ListTile(
                      title: Text(document['name']),
                      subtitle: new Row(children: <Widget>[
                        Text(
                            "Created : " +
                                document['created_on'].year.toString() +
                                "-" +
                                document['created_on'].month.toString() +
                                "-" +
                                document['created_on'].day.toString(),
                            style: new TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12.0,
                            )),
                        new SizedBox(width: 15.0),
                        Text(
                            document['do_on']
                                    .difference(new DateTime.now())
                                    .inDays
                                    .toString() +
                                " Days "+((document['do_on']
                                    .difference(new DateTime.now())
                                    .inDays>0)?"":""),
                            style: new TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 12.0,
                                color: (document['do_on']
                                            .difference(new DateTime.now())
                                            .inDays >
                                        0)
                                    ? Colors.green[400]
                                    : Colors.amber[900])),
                      ]),
                      leading: new Container(
                          child: CircleAvatar(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text((document['do_on'].day).toString()),
                              Text(
                                  document['do_on'].year.toString() +
                                      "-" +
                                      document['do_on'].month.toString(),
                                  style: new TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 8.0,
                                  )),
                            ],
                          )),
                          width: 52.0,
                          height: 52.0,
                          padding: const EdgeInsets.all(2.0), // borde width
                          decoration: new BoxDecoration(
                            color: const Color(0xFFFFFFFF), // border color
                            shape: BoxShape.circle,
                          )),
                      trailing: 
                      
                      
                      new Checkbox(
                          value: map[document.documentID],
                          onChanged: (bool newValue) {
                            //done = newValue;
                            print("CHAN="+map.toString());

                            // Firestore.instance.runTransaction((Transaction transaction) async{
                            //           CollectionReference reference = Firestore.instance.collection('todos');
                            //           await reference.document(document.documentID).setData({"done":newValue});
                                      
                            //         });

                             Firestore.instance.runTransaction((transaction) async {
                                await transaction.update( Firestore.instance.collection('todos').document(document.documentID), {"done":newValue});
                              });

                            setState(() {

                            });
                            //  setState(() {
                            //   map[document.documentID] = newValue;
                            // });
                          }),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      );
}
