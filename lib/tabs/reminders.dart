import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/IM.dart';
import '../components/entities/IMObject.dart';
import 'package:intl/intl.dart';

class Reminders extends StatelessWidget {
  final formatter = new NumberFormat("00");
  @override
  Widget build(BuildContext context) => new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            // color: Colors.amber.shade100,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new SizedBox(
                  height: 10.0,
                ),
                new Text(
                  "OVERDUE",
                  style: TextStyle(
                    color: Colors.pink.shade500,
                  ),
                ),
                new Container(
                  //margin: const EdgeInsets.symmetric(vertical: 10.0),
                  height: 250.0,
                  child: new Align(
                      alignment: Alignment.topCenter,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('reminders')
                            .where("remind_on", isLessThan: new DateTime.now())
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return new Text('Loading...');
                          return new ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                                  

                              return new Card(
                               child: SingleChildScrollView(
                    
                                child: ListTile(
                                title: new Text(document['text']),
                                subtitle: new Row /*or Column*/ (
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Icon(Icons.timer, size: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    new Text(formatter.format(
                                            document['remind_on'].hour) +
                                        ":" +
                                        formatter.format(
                                            document['remind_on'].minute)),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    new Icon(Icons.calendar_today, size: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    new Text(formatter
                                            .format(document['remind_on'].day) +
                                        "/" +
                                        formatter.format(
                                            document['remind_on'].month) +
                                        "/" +
                                        formatter.format(
                                            document['remind_on'].year)),
                                    new SizedBox(
                                      width: 10.0,
                                    ),

                                    new Icon((document['type']==1)?Icons.people:((document['type']==2))?Icons.assignment_late:((document['type']==3))?Icons.cake:Icons.devices_other, size: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    new Text((document['type']==1)?"Meeting":((document['type']==2))?"Task":((document['type']==3))?"Birthday":"Other"),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                                leading: CircleAvatar(
                                    child: Text(document['text'][0]),
                                    backgroundColor: Colors.red.shade500,
                                    ),
                              ),
                                )
                                
                              );
                            }).toList(),
                          );
                        },
                      )
                      ),
                  
                )
              ],
            ),
          ),
          new Container(
            // color: Colors.green.shade100,
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new SizedBox(
                  height: 10.0,
                ),
                new Text(
                  "PENDING",
                  style: TextStyle(
                    color: Colors.green.shade500,
                  ),
                ),
                new Container(
                  height: 250.0,
                  child: new Align(
                      alignment: Alignment.topCenter,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('reminders')
                            .where("remind_on",
                                isGreaterThanOrEqualTo: new DateTime.now())
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return new Text('Loading...');
                          return new ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new Card(
                                child: SingleChildScrollView(
                    
                                child: 
                                ListTile(
                                title: new Text(document['text']),
                                subtitle: new Row /*or Column*/ (
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Icon(Icons.timer, size: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    new Text(formatter.format(
                                            document['remind_on'].hour) +
                                        ":" +
                                        formatter.format(
                                            document['remind_on'].minute)),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    new Icon(Icons.calendar_today, size: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    new Text(formatter
                                            .format(document['remind_on'].day) +
                                        "/" +
                                        formatter.format(
                                            document['remind_on'].month) +
                                        "/" +
                                        formatter.format(
                                            document['remind_on'].year)),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    new Icon((document['type']==1)?Icons.people:((document['type']==2))?Icons.assignment_late:((document['type']==3))?Icons.cake:Icons.devices_other, size: 16.0),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                    new Text((document['type']==1)?"Meeting":((document['type']==2))?"Task":((document['type']==3))?"Birthday":"Other"),
                                    new SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                                leading: CircleAvatar(
                                    child: Text(document['text'][0]),
                                    
                                    backgroundColor: Colors.green.shade200,
                                    ),
                              ),
                                )
                              );
                            }).toList(),
                          );
                        },
                      )),
                )
              ],
            ),
          ),
        ],
      );
}
