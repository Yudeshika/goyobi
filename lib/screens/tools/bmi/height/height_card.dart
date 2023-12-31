import '../card_title.dart';
import './height_picker.dart';
import '../widget_utils.dart';
import 'package:flutter/material.dart';

class HeightCard extends StatefulWidget {
  final int height;

  int selectHeight;

  HeightCard({Key key, this.height}) : super(key: key);

  @override
  HeightCardState createState() => HeightCardState();
}

class HeightCardState extends State<HeightCard> {
  int height;

  @override
  void initState() {
    super.initState();
    height = widget.height ?? 170;
    widget.selectHeight = 170;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("HEIGHT", subtitle: "(cm)"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenAwareSize(8.0, context)),
                child: LayoutBuilder(builder: (context, constraints) {
                  return HeightPicker(
                    widgetHeight: constraints.maxHeight,
                    height: height,
                    onChange: (val){
                       setState(() => height = val);
                       if(val!=null){
                        setState(() => widget.selectHeight = val);
                       }
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
