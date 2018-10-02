import 'package:flutter/material.dart';

class IMDropdownButton extends DropdownButton {
  

  IMDropdownButton(
      {
      Key key,
      String label,
      List<DropdownMenuItem<dynamic>> items,
      ValueChanged onChanged,
      BuildContext context,
      int elevation,
      String value
      })
      :
       super(
          items: items,
          onChanged: onChanged
        );
 

}
