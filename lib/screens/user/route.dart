import 'package:flutter/material.dart';
import '../../components/IM.dart';
import 'auth.dart';
import 'login.dart';
import '../../dashboard.dart';

class RoutePage extends StatefulWidget {
  final BaseAuth auth;

  RoutePage({this.auth});
  @override
  _RoutePageState createState() => new _RoutePageState();
}

enum AuthStatus { signedIn, notSignedIn }

class _RoutePageState extends State<RoutePage> {
  AuthStatus authStaus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStaus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void signInChange() {
      print("Signed In...");
    setState(() {
      authStaus = AuthStatus.signedIn;
    });
  }

  void signOutChange() {
    
      print("Signed Out...");
    setState(() {
      authStaus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStaus) {
      case AuthStatus.notSignedIn:
        return new Login(
          auth: widget.auth,
          onSignIn: signInChange,
        );
      case AuthStatus.signedIn:
        return new Tabs(auth: widget.auth,
          onSignOut: signOutChange);
    }
  }
}
