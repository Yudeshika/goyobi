import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/IM.dart';
import 'auth.dart';

class Login extends StatefulWidget {
  final BaseAuth auth;

  Login({this.auth, this.onSignIn});

  final VoidCallback onSignIn;
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  final formKey2 = new GlobalKey<FormState>();

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

                        child:  new Column(
                  children: <Widget>[
                    new SizedBox(height: 40.0),
                    new Image.asset('assets/common/logo.png',
                        height: 200.0,
                        fit: BoxFit.fitHeight),
                    
                    new SizedBox(height: 40.0),
                    new IMCard(
                      context: context,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Form( 
                          key: formKey2,
                        child: new Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        
                        children: <Widget>[
                          new IMTextField(
                            label: 'User Name or Email',
                            validator: (value) => value.isEmpty?"Email Can't Be Empty":null,
                            controller: txtEmail,
                          ), 
                          new IMTextField(
                            label: 'Enter your Password',
                            obscureText: true,
                            validator: (value) =>  value.length < 6 ? 'Password Too Short.' : null,
                            controller: txtPassword,
                          ),
                          
                          new ButtonBar(
                            mainAxisSize: MainAxisSize.max,
                            alignment: MainAxisAlignment.spaceBetween,
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
                                onPressed: () async {
                                    final form = formKey2.currentState;
                                      if (form.validate()) {
                                        print("Valid Form");
                                        try{
                                          String userId = await widget.auth.login(txtEmail.text.trim(),txtPassword.text);
                                          print("Sign In as ${userId}");
                                          //Navigator.of(context).pushNamed("/");
                                          widget.onSignIn();
                                        }catch(e){
                                          print("Error "+e.toString());
                                        }
                                        
                                      } else {
                                        print("Invalid Form");
                                        
                                      }

                                    },
                              )
                            ],
                          ),

                          new Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: <Widget>[
                           new FlatButton(

                                child: new Text("CREATE AN ACCOUNT"), 
                                onPressed: (){
                                  Navigator.of(context).pushNamed("/register");
                                }, 
                              )
                         ], 

                          )
                        ],
                      ),
                      )
                      )
                    ),
                  ],
                  )
                 
                 ),
              ],
            )
          
        ),
        
      );
}
