import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/IM.dart';


import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../screens/user/auth.dart';
import '../../components/controls/Validator.dart';
import 'dart:async';

class CustomerCreate extends StatefulWidget {
  Validator validator; 
  String uid;
  CustomerCreate() {
    new Auth().currentUser().then((userId) {
      uid = userId;
    });
    validator = new Validator("customers");
  }

  @override
  _CustomersState createState()=> _CustomersState(validator); 
  
  
}

class _CustomersState extends State<CustomerCreate> {
  final _formKey = GlobalKey<FormState>();

  // Map map ;

  Validator validator;

  _CustomersState(Validator validator){
    this.validator = validator;
    validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }

  static DateTime now = DateTime.now();

  int _radioGender = 0;
  int _radioCivilStatus = 0;

  final dateFormat = DateFormat("yyyy-MM-dd");

  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNic = TextEditingController();
  TextEditingController txtBday = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  TextEditingController txtStatus = TextEditingController();
  TextEditingController txtChildren = TextEditingController();
  TextEditingController txtHeight = TextEditingController();
  TextEditingController txtWeight = TextEditingController();
  TextEditingController txtDiseases = TextEditingController();
  TextEditingController txtOccupation = TextEditingController();
  TextEditingController txtIncome = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtWorkaddress = TextEditingController();
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtHome = TextEditingController();
  TextEditingController txtWorktelephone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPrivate = TextEditingController();
  TextEditingController txtWork = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW CUSTOMER",
          context: context,
        ),
        //Content of tabs
        body: new SingleChildScrollView(
            child: new Form(
          key: _formKey,
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
                          child: new Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[ 

                              (validator.getMap()["name"]!=null && validator.getMap()["name"]["show"])?
                                new IMTextField(
                                label: 'Customer / Company Name'+((validator.getMap()["name"]["validation_rules"]!=null)?" *":""),
                                controller: txtName,

                                validator: (text) => widget.validator
                                    .validate(text, "name", widget),
                              ):new SizedBox(),
                               
                              (validator.getMap()["nic"]!=null && validator.getMap()["nic"]["show"])?
                              new IMTextField(
                                  label: 'Social Securty No/ NIC/ Passport'+((validator.getMap()["nic"]["validation_rules"]!=null)?" *":""),
                                  controller: txtNic,

                                   validator: (text) => widget.validator
                                    .validate(text, "nic", widget),
                                  ):new SizedBox(),

                              new SizedBox(
                                height: 20.0,
                              ),
                              
                              (validator.getMap()["bday"]!=null && validator.getMap()["bday"]["show"])?
                              new Text("Date of Birth"):SizedBox(),
                              
                              (validator.getMap()["bday"]!=null && validator.getMap()["bday"]["show"])?
                              
                              new DateTimePickerFormField(
                                dateOnly: true,
                                controller: txtBday,

                                keyboardType: TextInputType.datetime,

                                 validator: (text) => widget.validator
                                    .validateDate(text, "bday"),

                                format: dateFormat,
                                onChanged: (date) {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('$date')));
                                },
                              )

                              :new SizedBox(),
                              new SizedBox(
                                height: 20.0,
                              ),

                              (validator.getMap()["gender"]!=null && validator.getMap()["gender"]["show"])?
                              new Text("Gender"):new SizedBox(),
                              (validator.getMap()["gender"]!=null && validator.getMap()["gender"]["show"])?
                              new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioGender,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioGender = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 50.0,
                                        child: new Text("Male"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioGender,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioGender = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("Female"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),

                              (validator.getMap()["status"]!=null && validator.getMap()["status"]["show"])?
                              new Text("Civi Status"):new SizedBox(),
                              (validator.getMap()["status"]!=null && validator.getMap()["status"]["show"])?
                              new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioCivilStatus,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioCivilStatus = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 50.0,
                                        child: new Text("Married"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioCivilStatus,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioCivilStatus = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("Single"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),

                              (validator.getMap()["children"]!=null && validator.getMap()["children"]["show"])?    
                              new IMTextField(
                                  label: 'No of Children'+((validator.getMap()["children"]["validation_rules"]!=null)?" *":""),
                                  controller: txtChildren,

                                  keyboardType: TextInputType.number,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "children", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["height"]!=null && validator.getMap()["height"]["show"])?
                              new IMTextField(
                                  label: 'Height'+((validator.getMap()["height"]["validation_rules"]!=null)?" *":""),
                                   controller: txtHeight,

                                  keyboardType: TextInputType.number,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "height", widget),
                                    ):new SizedBox(),

                              (validator.getMap()["weight"]!=null && validator.getMap()["weight"]["show"])?
                              new IMTextField(
                                  label: 'Weight'+((validator.getMap()["weight"]["validation_rules"]!=null)?" *":""),
                                   controller: txtWeight,

                                  keyboardType: TextInputType.number,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "weight", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["diseases"]!=null && validator.getMap()["diseases"]["show"])?
                              new IMTextField(
                                  label:
                                      'Civil Status Suffering from any Diseases or Disabilities'+((validator.getMap()["diseases"]["validation_rules"]!=null)?" *":""),
                                  controller: txtDiseases,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "diseases", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["occupation"]!=null && validator.getMap()["occupation"]["show"])?
                              new IMTextField(
                                  label: 'Occupation / Type of Business'+((validator.getMap()["occupation"]["validation_rules"]!=null)?" *":""),
                                  controller: txtOccupation,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "occupation", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["income"]!=null && validator.getMap()["income"]["show"])?
                              new IMTextField(
                                  label: 'Income'+((validator.getMap()["income"]["validation_rules"]!=null)?" *":""),
                                   controller: txtIncome,

                                  keyboardType: TextInputType.number,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "income", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["address"]!=null && validator.getMap()["address"]["show"])?
                              new IMTextField(
                                  label:
                                      'Civil StatusHome Address / Register Address'+((validator.getMap()["address"]["validation_rules"]!=null)?" *":""),
                                  controller: txtAddress,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "address", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["workaddress"]!=null && validator.getMap()["workaddress"]["show"])?
                              new IMTextField(
                                  label: 'Work Address'+((validator.getMap()["workaddress"]["validation_rules"]!=null)?" *":""),
                                  controller: txtWorkaddress,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "workaddress", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["number"]!=null && validator.getMap()["number"]["show"])?
                              new IMTextField(
                                  label: 'Contact Number'+((validator.getMap()["number"]["validation_rules"]!=null)?" *":""),
                                  controller: txtNumber,

                                  keyboardType: TextInputType.phone,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "number", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["mobile"]!=null && validator.getMap()["mobile"]["show"])?
                              new IMTextField(
                                  label: 'Mobile'+((validator.getMap()["mobile"]["validation_rules"]!=null)?" *":""),
                                   controller: txtMobile,

                                  keyboardType: TextInputType.phone,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "mobile", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["home"]!=null && validator.getMap()["home"]["show"])?
                              new IMTextField(
                                  label: 'Home'+((validator.getMap()["home"]["validation_rules"]!=null)?" *":""),
                                   controller: txtHome,

                                  keyboardType: TextInputType.phone,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "home", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["worktelephone"]!=null && validator.getMap()["worktelephone"]["show"])?
                              new IMTextField(
                                  label: 'Work'+((validator.getMap()["worktelephone"]["validation_rules"]!=null)?" *":""),
                                   controller: txtWorktelephone,

                                  keyboardType: TextInputType.phone,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "worktelephone", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["email"]!=null && validator.getMap()["email"]["show"])?
                              new IMTextField(
                                  label: 'Email Address'+((validator.getMap()["email"]["validation_rules"]!=null)?" *":""),
                                   controller: txtEmail,

                                  keyboardType: TextInputType.emailAddress,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "email", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["private"]!=null && validator.getMap()["private"]["show"])?
                              new IMTextField(
                                  label: 'Private'+((validator.getMap()["private"]["validation_rules"]!=null)?" *":""),
                                   controller: txtPrivate,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "private", widget),
                                  ):new SizedBox(),

                              (validator.getMap()["work"]!=null && validator.getMap()["work"]["show"])?
                              new IMTextField(
                                  label: 'Work'+((validator.getMap()["work"]["validation_rules"]!=null)?" *":""),
                                   controller: txtWork,
                                  
                                   validator: (text) => widget.validator
                                    .validate(text, "work", widget),
                                  ):new SizedBox(),

                              new ButtonBar(
                                children: <Widget>[
                                  new IMButton(
                                    title: "RESET",
                                    context: context,
                                    onPressed: () {
                                      Scaffold
                                          .of(context)
                                          .showSnackBar(new SnackBar(
                                            content: new Text(
                                                "Text=" + txtName.text),
                                          ));
                                    },
                                    type: ButtonTypes.general,
                                  ),
                                  new IMButton(
                                    title: "SAVE",
                                    context: context,
                                    onPressed: () {
                                      if (_formKey.currentState.validate() && widget.validator.validateRadio(_radioGender, "gender", context) && widget.validator.validateRadio(_radioCivilStatus, "status", context) ) {
                                        Firestore.instance.runTransaction(
                                            (Transaction transaction) async {
                                          CollectionReference reference =
                                              Firestore.instance
                                                  .collection('customers');
                                          await reference.add({
                                            "name": txtName.text,
                                            "nic": txtNic.text,
                                            "bday": txtBday.text,
                                            "gender": _radioGender,
                                            "status": _radioCivilStatus,
                                            "children": txtChildren.text,
                                            "height": txtHeight.text,
                                            "weight": txtWeight.text,
                                            "diseases": txtDiseases.text,
                                            "occupation": txtOccupation.text,
                                            "income": txtIncome.text,
                                            "address": txtAddress.text,
                                            "workaddress": txtWorkaddress.text,
                                            "number": txtNumber.text,
                                            "mobile": txtMobile.text,
                                            "home": txtHome.text,
                                            "worktelephone":
                                                txtWorktelephone.text,
                                            "email": txtEmail.text,
                                            "private": txtPrivate.text,
                                            "work": txtWork.text,
                                            "uid": widget.uid,
                                            "type": 1
                                          });
                                        });

                                        //Scaffold.of(context).showSnackBar(new SnackBar(
                                        //    content: new Text("Saved!"),
                                        //  ));
                                        //Navigator.of(context).pushNamed("/customers");
                                        Navigator.pop(context);
                                      } else {
                                        Scaffold
                                            .of(context)
                                            .showSnackBar(new SnackBar(
                                              content: new Text("Validation Failed!"),
                                            ));
                                      }
                                    },
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
          ),
        )),
      );

  }
}
