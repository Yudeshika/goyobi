import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> login(String email, String password);
  Future<String> register(String email, String password);
  Future<String> currentUser();
  Future<FirebaseUser> currentUserObject();
  Future<void>  signOut();
}

class Auth implements BaseAuth{
  Future<String> login(String email, String password) async{
    FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword( email: email, password:password);
    return user.uid;
  }

   Future<String> register(String email, String password) async{
    FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword( email: email, password:password);
    return user.uid;
  }

  Future<String> currentUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return (user==null)?null:user.uid;
  }


  Future<FirebaseUser> currentUserObject() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return (user==null)?null:user;
  }

   Future<void> signOut() async{
    return  FirebaseAuth.instance.signOut(); 
  }
}