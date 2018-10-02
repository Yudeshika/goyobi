import 'package:flutter/material.dart';

class IMObject {
  IMObject({this.key, this.title, this.subtitle, this.icon, this.image});
  String key;
  String title;
  String subtitle;
  Icon icon;
  Image image;

  IMObject.fromJson(this.key, Map data) {
    title = data['name'];
    if (title == null) {
      title = '';
    }
  }
}
