import 'package:flutter/material.dart';
import '../../components/IM.dart';
import 'calculator/calculator.dart';
class Calc extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    //App Bar
    appBar: new IMAppBar(
      title: "Calculator",
      context: context,
    ),

    //Content of tabs
    body: new Calculator(),
  );
}