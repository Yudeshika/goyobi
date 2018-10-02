import 'package:flutter/material.dart';
import '../../components/IM.dart';
import './bmi/input_page.dart';
class BMI extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    //App Bar
    appBar: new IMAppBar(
      title: "BMI Calculator",
      context: context,
    ),

    //Content of tabs
    body:new InputPage(),
  );
}