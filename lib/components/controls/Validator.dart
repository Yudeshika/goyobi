import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/IM.dart';
import '../../components/entities/IMObject.dart';
import '../../screens/user/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'dart:async';

class Validator {
  String table = "";
   Map<String, DocumentSnapshot> map = new Map<String, DocumentSnapshot>();
  
  Map<String, DocumentSnapshot> getMap(){
    
    return map;

  } 
  
  Validator(String table) {
    this.table = table;  
    //loadMap();
    
  }

  bool done = false;

  loadMap(VoidCallback caller) async{
    
    
    Firestore.instance
        .collection("column_settings")
        .where("table_name", isEqualTo: this.table)
        .snapshots().listen((data){
          data.documents.forEach((doc){
              print("DOC="+doc.toString());
              map.putIfAbsent(doc["column_name"].toString(), ()=>doc);
          }); 
          print("DONE=true"); 
          done = true;
          caller();
        }); 

        while(!done){
          print("Wait.."); 
          await new Future.delayed(const Duration(seconds: 1), () => "1");
        }


  }

  String validate(String text, String col, Widget w) {
    print("MAP="+map.toString());
    DocumentSnapshot doc = map[col];
    print("DOC="+doc.toString());
    if(doc!=null){
      String vr = doc["validation_rules"];
      if(vr.contains("required")){
        if(text.isEmpty){
          return col+" Field Cannot be empty.";
        }
      }
    }else{
      print("No validation Rules Found.");
    }
    

  }
  
  String validateDate(DateTime dt, String col) {
    print("MAP="+map.toString());
    DocumentSnapshot doc = map[col];
    print("DOC="+doc.toString());
    if(doc!=null){
      String vr = doc["validation_rules"];
      if(vr.contains("required")){
        if(dt==null){
          return col+" Field Cannot be empty.";
        }
      }
    }else{
      print("No validation Rules Found.");
    } 
  }

  String validateTime(TimeOfDay dt, String col) {
    print("MAP="+map.toString());
    DocumentSnapshot doc = map[col];
    print("DOC="+doc.toString());
    if(doc!=null){
      String vr = doc["validation_rules"];
      if(vr.contains("required")){
        if(dt==null){
          return col+" Field Cannot be empty.";
        }
      }
    }else{
      print("No validation Rules Found.");
    } 
  }
  

  validateRadio(int selected, String col, BuildContext context) {
    DocumentSnapshot doc = map[col];
    if(doc!=null){
      String vr = doc["validation_rules"];
      if(vr.contains("required")){
        if(selected==0){
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text(col+" must Select."),
          ));
          return false;
        }
      }
    }else{
      print("No validation Rules Found.");
    } 
    return true;
  }
}
