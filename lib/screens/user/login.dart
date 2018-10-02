import 'package:flutter/material.dart';
import '../../components/IM.dart';

class Login extends StatelessWidget {
  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "LOGIN",
          context: context,
        ),

        //Content of tabs
        body: new SingleChildScrollView(
          child:
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: 
                new Column(
                  children: <Widget>[
                    new Image.asset('assets/common/logo.png',
                        fit: BoxFit.cover),
                    // new Icon(
                    //   Icons.account_circle,
                    //   size: 80.0,
                    //   color: Colors.orange[200],
                    // ),
                    new Text('Hi, John. ' + msg),
                    new SizedBox(height: 40.0),
                    new IMCard(
                      context: context,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        
                        children: <Widget>[
                          new IMTextField(
                            label: 'User Name or Email',
                          ),
                          new IMTextField(
                            label: 'Enter your Password',
                          ),
                          
                          new ButtonBar(
                            children: <Widget>[
                              new IMButton(
                                title: "RESET",
                                context: context,
                                onPressed: () => {},
                                type: ButtonTypes.general,
                              ),
                              new IMButton(
                                title: "LOGIN",
                                context: context,
                                onPressed: () => {},
                              )
                            ],
                          )
                        ],
                      ),
                      )
                    ),
                  ],
                ),
                 ),
              ],
            )
          
        ),
        
      );
}
