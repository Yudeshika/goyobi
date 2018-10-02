import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
  

class Dashboard extends StatefulWidget {

 Dashboard();
   @override
  _DashboardState createState() => new _DashboardState();

}
class _DashboardState extends State<Dashboard> {


final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

List<CircularStackEntry> data = <CircularStackEntry>[
  new CircularStackEntry(
    <CircularSegmentEntry>[
      new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'April'),
      new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'May'),
      new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'June'),
      new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'July'),
      new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'August'),
    ],
    rankKey: 'Monthly Progress',
  ),
];


  @override
  Widget build(BuildContext context) => new Container(
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        
        new AnimatedCircularChart(
    key: _chartKey,
    size: const Size(450.0, 450.0),
    initialChartData: data,
    chartType: CircularChartType.Radial,
    holeRadius: 10.0,
  holeLabel: '67%',
  labelStyle: new TextStyle(
    color: Colors.blueGrey[600],
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  ),
  ),
        new Text('Current Progress')
      ]
    ),
  );
}