import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/IM.dart';
import 'auth.dart';

class Register extends StatefulWidget {
  final BaseAuth auth;

  Register({this.auth});
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  static DateTime now = DateTime.now();
  String filter = "";
  String selectedCompany = "NnWDUmxOgdVufdFZRkF2";
  String selectedCountry = "07N24di7RbK1g4tpMwNw";
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";
  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtNic = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtHomePhone = TextEditingController();
  TextEditingController txtOfficePhone = TextEditingController();

  final formKey = new GlobalKey<FormState>();
 
  @override
  Widget build(BuildContext context) => new Scaffold(

      //App Bar
      appBar: new IMAppBar(
        title: "REGISTER",
        context: context,
      ),

      //Content of tabs
      body: new SingleChildScrollView(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                new IMCard(
                    context: context,
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Form(
                          key: formKey,
                          child: new Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              StreamBuilder(
                                stream: Firestore.instance
                                    .collection("companies")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('Loading...');
                                  return new DropdownButton(
                                      elevation: 0,
                                      value: selectedCompany,
                                      items: snapshot.data.documents
                                          .map((DocumentSnapshot document) {
                                        String name = document["name"];
                                        // if(name.toLowerCase().contains(filter.toLowerCase())){
                                        return DropdownMenuItem(
                                            value: document.documentID,
                                            child: Row(
                                              children: <Widget>[
                                                new Icon(Icons.business),
                                                new SizedBox(width: 5.0),
                                                new Text(name)
                                              ],
                                            ));
                                        // }
                                      }).toList(),
                                      onChanged: (value) {
                                        print(value);
                                        selectedCompany = value;
                                        setState(() {});
                                      });
                                },
                              ),

                              new IMTextField(
                                label: 'First Name',
                                controller: txtFirstName,
                              ),
                              new IMTextField(
                                label: 'Last Name',
                                controller: txtLastName,
                              ),

                              new IMTextField(
                                validator: (value) => value.isEmpty?"Email Can't Be Empty":null,
                                label: 'User Name or Email',
                                controller: txtEmail,
                              ),
                              new IMTextField(
                                label: 'Enter Passowrd',
                                validator: (value) => value.isEmpty?"Password Can't Be Empty":null,
                                controller: txtPassword,
                              ),
                              new IMTextField(
                                label: 'Social Securty No/ NIC/ Passport',
                                controller: txtNic,
                              ),
                              new Row(
                                children: <Widget>[
                                  new Text("Your Photo"),
                                  new IMButton(
                                    title: "Browse",
                                    context: context,
                                    onPressed: () => {},
                                    type: ButtonTypes.action,
                                  ),
                                ],
                              ),

                              new StreamBuilder(
                                stream: Firestore.instance
                                    .collection("countries")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('Loading...');
                                  return new DropdownButton(
                                      elevation: 0,
                                      value: selectedCountry,
                                      items: snapshot.data.documents
                                          .map((DocumentSnapshot document) {
                                        String name = document["name"];
                                        // if(name.toLowerCase().contains(filter.toLowerCase())){
                                        return DropdownMenuItem(
                                            value: document.documentID,
                                            child: Row(
                                              children: <Widget>[
                                                new Icon(Icons.assistant_photo),
                                                new SizedBox(width: 5.0),
                                                new Text(name)
                                              ],
                                            ));
                                        // }
                                      }).toList(),
                                      onChanged: (value) {
                                        print(value);
                                        selectedCountry = value;
                                        setState(() {});
                                      });
                                },
                              ),
                              // new IMTextField(
                              //   label: 'Your Currency',
                              // ),

                              new IMTextField(
                                label: 'Mobile No',
                                controller: txtMobile,
                                keyboardType: TextInputType.phone,
                              ),
                              new IMTextField(
                                label: 'Home Phone No',
                                controller: txtHomePhone,
                                keyboardType: TextInputType.phone,
                              ),
                              new IMTextField(
                                label: 'Office Phone No',
                                controller: txtOfficePhone,
                                keyboardType: TextInputType.phone,
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
                                    title: "SIGNING",
                                    context: context,
                                    onPressed: () {
                                      final form = formKey.currentState;
                                      if (form.validate()) {
                                        print("Valid Form");

                                        FirebaseAuth.instance.createUserWithEmailAndPassword( email: txtEmail.text, password:txtPassword.text);

                                        // Firestore.instance.runTransaction((Transaction transaction) async{
                                        // CollectionReference reference = Firestore.instance.collection('members');
                                        // await reference.add({"first_name":txtFirstName.text,"last_name":txtLastName.text,"email":txtEmail.text,"password":txtPassword.text,"nic":txtNic.text, "mobile_no": txtMobile.text, "home_tp": txtHomePhone.text, "office_tp":txtOfficePhone.text, "company":selectedCompany,"country":selectedCountry});
                                        // });
                                        Navigator.of(context).pushNamed("/");
                                      } else {
                                        print("Invalid Form");
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          )),
                    )),
              ],
            ),
          ),
        ],
      )));
}
