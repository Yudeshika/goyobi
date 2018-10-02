import 'package:flutter/material.dart';

class IMCard extends Card {
  

  IMCard(
      {
      Key key,
      Widget child,
      BuildContext context})
      : super(
          key: key,
          child: child,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        );
 

}
