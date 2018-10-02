import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/IM.dart';
import '../../components/entities/IMObject.dart';

class ToDos extends StatefulWidget {

  ToDos();
   @override
  _ToDosState createState() => new _ToDosState();


}
class _ToDosState extends State<ToDos> {

  var map = new Map<String, dynamic>();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: 'TO DOs',
          context: context,
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
              stream: Firestore.instance.collection('todos').snapshots(),
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
                      trailing: new Switch(
                          value: map[document.documentID],
                          onChanged: (bool newValue) {
                            //done = newValue;
                             setState(() {
                              map[document.documentID] = newValue;
                            });
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
