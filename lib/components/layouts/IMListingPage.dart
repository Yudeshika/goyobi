import 'package:flutter/material.dart';
import 'dart:async';
import '../entities/IMObject.dart'; 

class IMListingPage extends StatefulWidget {
  String table;
  IMListingPage(this.table);


   @override
  _IMListingPageState createState() => new _IMListingPageState(table);

}

class _IMListingPageState extends State<IMListingPage> {
  StreamSubscription _subscriptionObject;
  String table;
  String _pageName = " LIST";
  
  _IMListingPageState(this.table){
    _pageName = table+" LIST";
  }

  @override
  void initState() {
    //FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateObject);

    // IMDBObject.getObjectStream("todos","-KriJ8Sg4lWIoNswKWc4", _updateObject)
    //     .then((StreamSubscription s) => _subscriptionObject = s);
    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionObject != null) {
      _subscriptionObject.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemTile = new ListTile(
      title: new Text("$_pageName"),
    );

    return  new ListView(
        children: <Widget>[
          itemTile,
        ],
      );
  }


  _updateObject(IMObject value) {
    var name = value.title;
    setState((){
      _pageName = name;
    });
  }
}




