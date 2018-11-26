import 'package:flutter/material.dart';
import '../components/IM.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: 'Settings',
          context: context,
        ),

        //Content of tabs
        body: new PageView(
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new Column(
                    children: <Widget>[
                      new Icon(
                        Icons.settings,
                        size: 80.0,
                        color: Colors.orange[200],
                      ),
                      new SizedBox(height: 40.0),
                      new IMCard(
                          context: context,
                          child: new Padding(
                            padding: new EdgeInsets.all(10.0),
                            child: new Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  'Currency Format',
                                ),
                                new IMTextField(
                                  label: 'LKR',
                                ),
                                new Text(
                                  'Date Format',
                                ),
                                new IMTextField(
                                  label: 'yyyy-MM-dd',
                                  
                                ),
                                new SizedBox(height: 10.0),
                                 new Text(
                                  'Email Allowed',

                                ),
                                new Switch(
                                    value: true, onChanged: (bool newValue) {}),
                                
                                new Text(
                                  'SMS Allowed',
                                ),
                                new Switch(
                                    value: true, onChanged: (bool newValue) {}),
                                 new Text(
                                  'Location Access Allowed',

                                ),
                                new Switch(
                                    value: true, onChanged: (bool newValue) {}),

                                
                                new ButtonBar(
                                  children: <Widget>[
                                    new IMButton(
                                      title: "SAVE",
                                      context: context,
                                      onPressed: () => {},
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
