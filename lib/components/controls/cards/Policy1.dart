import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Policy1 extends Card {
  DocumentSnapshot document;

  Policy1(
      {
      Key key,
      DocumentSnapshot doc,
      Widget child,
      BuildContext context})
      : super(
          key: key,
          child: child,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ) {
          document = doc;
        }
 
    
}
