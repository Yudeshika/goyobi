import 'package:flutter/material.dart';

class IMTextField extends TextFormField {
  

  IMTextField(
      {
      Key key,
      FormFieldValidator<String> validator,
      String label, 
      TextEditingController controller,
      dynamic keyboardType,
      BuildContext context})
      : super(
          key: key,
          validator: validator,
          decoration: InputDecoration(labelText: label),
          controller: controller,
          keyboardType: (keyboardType==null)?TextInputType.text: keyboardType
        );
 

}
