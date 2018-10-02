import 'package:flutter/material.dart';

class IMTextField extends TextField {
  

  IMTextField(
      {
      Key key,
      String label, 
      TextEditingController controller,
      BuildContext context})
      : super(
          key: key,
         decoration: InputDecoration(
                                labelText: label),
                                controller: controller
        );
 

}
