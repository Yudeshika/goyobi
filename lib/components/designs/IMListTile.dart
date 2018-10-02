import 'package:flutter/material.dart';
import '../entities/IMObject.dart';

class IMListTile extends ListTile {
  IMObject obj;
  IMListTile({IMObject obj})
      : super(
    title: Text(obj.title),
    subtitle: Text(obj.subtitle),
    leading: (obj.icon!=null)?obj.icon :CircleAvatar(child: Text(obj.title[0])),
  );
}
