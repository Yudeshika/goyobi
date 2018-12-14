import 'package:flutter/material.dart';

class IMTextField extends TextFormField {
  

  IMTextField(
      {
      Key key,
      FormFieldValidator<String> validator,
      String label, 
      TextEditingController controller,
      dynamic keyboardType,
      obscureText,
      BuildContext context})
      : super(
          key: key,
          validator: validator,
          decoration: InputDecoration(labelText: label),
          controller: controller,
          obscureText: (obscureText==null)?false:obscureText,
          keyboardType: (keyboardType==null)?TextInputType.text: keyboardType
        );
 

}
