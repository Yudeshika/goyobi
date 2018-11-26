import './gender/gender_card.dart';
import './height/height_card.dart';
import './weight/weight_card.dart';
import 'package:flutter/material.dart';

import 'widget_utils.dart' show screenAwareSize;

class InputPage extends StatefulWidget {
  
  GenderCard gc = GenderCard();
  WeightCard wc = WeightCard();
  HeightCard hc  = HeightCard();
 
  
  @override
  _InputPageState createState() => _InputPageState();

}

  

  class _InputPageState extends State<InputPage> {

    String resultText = "000";

    Widget build(BuildContext context) {

    



    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            Expanded(child: _buildCards(context)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    
    return Padding(
      
      padding: EdgeInsets.only(
        left: 144.0,
        top: screenAwareSize(36.0, context),
      ),
      child: Text(
        resultText,
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 38.0,color: Colors.cyan, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: screenAwareSize(32.0, context),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: widget.gc),
                Expanded(child: widget.wc),
              ],
            ),
          ),
          Expanded(child: widget.hc)
        ],
      ),
    );
  }

  Widget _tempCard(String label) {
    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(label),
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(108.0, context),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.lightBlueAccent, 
        padding: const EdgeInsets.fromLTRB(50.0,12.0,50.0,12.0),

        textColor: Colors.white70,
        child: new Text("GENERATE"), 
        onPressed:() {
        print("Gender = "+widget.gc.getGender().toString());
        print("Height = "+widget.hc.selectHeight.toString());
        print("Weight = "+widget.wc.selectWeight.toString());
        double h = widget.hc.selectHeight/100;
        double bmi = widget.wc.selectWeight / (h * h);
        resultText = bmi.toStringAsFixed(2);
        setState(() {
                  resultText = bmi.toStringAsFixed(2);
                });
        print("BMI = "+resultText);
      }),
    );
  }
}
