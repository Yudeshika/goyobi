import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/user/auth.dart';

class Dashboard extends StatefulWidget {
  
  String uid;
  
  Dashboard() {
    new Auth().currentUser().then((userId) {
      uid = userId;
    }); 
  }
  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        
      ],
      rankKey: 'Monthly Progress',
    ),
  ];
  double complete = 0.0;
  double target = 200000.0;
    double p1 = 0.0, p2 = 0.0, p3 = 0.0;

  @override
  void initState() {
    super.initState();
    //CircularStackEntry stack = data.elementAt(0);
    
    Firestore.instance
        .collection('policies')
        .where("uid", isEqualTo: widget.uid)
        .snapshots()
        .listen((mydata) {
          mydata.documents.forEach((doc) { 
            if(doc["type"]==1){
              p1+=(doc["premium"]=="")? 0:double.parse(doc["premium"]);
            }else if(doc["type"]==2){
              p2+=(doc["premium"]=="")? 0:double.parse(doc["premium"]);
            }else if(doc["type"]==3){
              p3+=(doc["premium"]=="")? 0:double.parse(doc["premium"]);
            }
          });
          List<CircularStackEntry> nextData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(p1, Colors.red[200], rankKey: 'Life'),
        new CircularSegmentEntry(p2, Colors.green[200], rankKey: 'Motor'),
        new CircularSegmentEntry(p3, Colors.blue[200], rankKey: 'Fire'),
        new CircularSegmentEntry(target-(p1+p2+p3), Colors.grey[200], rankKey: 'Left'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];
          complete = ((p1+p2+p3) / target) * 100;
          setState(() {
                  _chartKey.currentState.updateData(nextData);
                });
           
        });
        
        

        
  }

  @override
  Widget build(BuildContext context) {  
    return new Container(
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new AnimatedCircularChart(
                key: _chartKey,
                size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width),
                initialChartData: data,
                
                chartType: CircularChartType.Radial,
                holeRadius: 20.0,
                holeLabel: complete.toStringAsFixed(2)+'%',
                labelStyle: new TextStyle(
                  color: Colors.blueGrey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              new Column(
                children: <Widget>[
                  Text('Current Progress', style: new TextStyle(fontSize: 20.0),),
                  Text('Target : '+ target.toStringAsFixed(2) ),
                  Text('Life : '+ p1.toStringAsFixed(2) ),
                  Text('Motor : '+ p2.toStringAsFixed(2) ),
                  new SizedBox(height: 30.0,)
                ],
              )
            ]),
      );
  }
}
