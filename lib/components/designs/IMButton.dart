import 'package:flutter/material.dart';

 enum ButtonTypes { 
   general, 
   action, 
   warning, 
   danger 
  }

class IMButton extends RaisedButton {
  final GestureTapCallback onPressed;
  String title;
  Icon icon = new Icon(Icons.menu);
  ButtonTypes type = ButtonTypes.action;

 
  IMButton(
      {@required this.onPressed,
      Key key,
      this.title,
      this.icon,
      this.type,
      BuildContext context})
      : super(
          key: key,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
              onPressed:onPressed
        );

  colorFill() {
    switch (type) {
      case ButtonTypes.general:
        return Colors.grey[500];
        break;
      case ButtonTypes.action:
        return Colors.white;
        break;
      case ButtonTypes.danger:
        return Colors.amber[900];
        break;
      default:
        return Colors.amber;
    }
  }

  colorSplash() {
    switch (type) {
      case ButtonTypes.general:
        return Colors.amber;
        break;
      case ButtonTypes.action:
        return Colors.cyan[300];
        break;
      case ButtonTypes.danger:
        return Colors.amber;
        break;
      default:
        return Colors.amber[900];
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: (title == '')? EdgeInsets.only(top: 15.0):EdgeInsets.only(top: 2.0),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          (icon== null)?new SizedBox(width:0.0):icon,
          // (icon== null)?new Text(''): new SizedBox(width:0.0),
          new Text(title,
          style: new TextStyle(
            color: Colors.cyan[400],
            fontSize:
                Theme.of(context).platform == TargetPlatform.iOS ? 12.0 : 14.0,
                
                
          ))
        ],
      ),
      fillColor: colorFill(),
      splashColor:colorSplash(),
      textStyle: new TextStyle(
        color: Colors.amberAccent,
        
      ),
      onPressed: onPressed,
      shape: (title == '')?CircleBorder():BeveledRectangleBorder(),
      elevation: 4.0,
      
      //padding:  EdgeInsets.all(15.0),
      

    );
  }
}
