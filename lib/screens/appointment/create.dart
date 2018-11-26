import 'package:flutter/material.dart';
import '../../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms/sms.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import '../../screens/user/auth.dart';
import '../../components/controls/Validator.dart';

class AppointmentCreate extends StatefulWidget {
  Validator validator;
  String uid;

  AppointmentCreate() {
    new Auth().currentUser().then((userId) {
      uid = userId;
    });
    validator = new Validator("appointments");
  }
  @override
  _AppointmentsState createState() => new _AppointmentsState(validator);
}

class _AppointmentsState extends State<AppointmentCreate> {
  final _formKey = GlobalKey<FormState>();

  Validator validator;

  _AppointmentsState(Validator validator){
    this.validator = validator;
    this.validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }

  int _radioCustomer = 0;
  int _radioGender = 0;
  int _radioCivilStatus = 0;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final dateTimeFormat = DateFormat("yyyy-MM-dd h:mm a");
  final timeFormat = DateFormat("h:mm a");

  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";

  TextEditingController txtName = TextEditingController();
  TextEditingController txtBday = TextEditingController();
  TextEditingController txtChildren = TextEditingController();
  TextEditingController txtOccupation = TextEditingController();
  TextEditingController txtIncome = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtTelephone = TextEditingController();
  TextEditingController txtWorktelephone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPrivate = TextEditingController();
  TextEditingController txtWork = TextEditingController();
  TextEditingController txtStart = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtTime = TextEditingController();
  TextEditingController txtEndtime = TextEditingController();
  TextEditingController txtPlace = TextEditingController();
  TextEditingController txtNote = TextEditingController();
  TextEditingController txtRemarks = TextEditingController();
  TextEditingController txtOthers = TextEditingController();
  TextEditingController txtOthersname = TextEditingController();
  TextEditingController txtOthersno = TextEditingController();
  TextEditingController txtOthersemail = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW APPOINTMENT",
          context: context,
        ),

        //Content of tabs
        body: new SingleChildScrollView(
            child:new Form(
          key: _formKey,
          child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  // new Image.asset('assets/common/logo.png',
                  //     fit: BoxFit.cover),
                  // new Icon(
                  //   Icons.account_circle,
                  //   size: 80.0,
                  //   color: Colors.orange[200],
                  // ),
                  // new Text('Hi, John. ' + msg),
                  // new SizedBox(height: 40.0),
                  new IMCard(
                      context: context,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[

                            (validator.getMap()["customer_type"]!=null && validator.getMap()["customer_type"]["show"])?
                            new Text("Type of Customer"):new SizedBox(),
                            (validator.getMap()["customer_type"]!=null && validator.getMap()["customer_type"]["show"])?
                            new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioCustomer,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioCustomer = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 75.0,
                                        child: new Text("Existing"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioCustomer,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioCustomer = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 75.0,
                                        child: new Text("Prospective"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),

                            (validator.getMap()["name"]!=null && validator.getMap()["name"]["show"])?
                            new IMTextField(
                                label: 'Customer Name'+((validator.getMap()["name"]["validation_rules"]!=null)?" *":""),
                                 controller: txtName,

                                validator: (text) => widget.validator
                                    .validate(text, "name", widget),
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
                            ):SizedBox(),

                            new SizedBox(
                              height: 20.0,
                            ),

                            (validator.getMap()["gender"]!=null && validator.getMap()["gender"]["show"])?
                            new Text("Gender"):SizedBox(),
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
                                        width: 75.0,
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
                                        width: 75.0,
                                        child: new Text("Female"),
                                      )
                                    ],)
                                    
                                  ]):SizedBox(),

                            (validator.getMap()["civil"]!=null && validator.getMap()["civil"]["show"])?
                            new Text("Civi Status"):SizedBox(),

                            (validator.getMap()["civil"]!=null && validator.getMap()["civil"]["show"])?
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
                                        width: 75.0,
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
                                        width: 75.0,
                                        child: new Text("Single"),
                                      )
                                    ],)
                                    
                                  ]):SizedBox(),

                            (validator.getMap()["children"]!=null && validator.getMap()["children"]["show"])?
                            new IMTextField(
                                label: 'No of Children'+((validator.getMap()["children"]["validation_rules"]!=null)?" *":""),
                                controller: txtChildren,

                                keyboardType: TextInputType.number,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "children", widget),

                                ):new SizedBox(),

                            (validator.getMap()["occupation"]!=null && validator.getMap()["occupation"]["show"])?
                            new IMTextField(
                                label: 'Occupation'+((validator.getMap()["occupation"]["validation_rules"]!=null)?" *":""),
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
                                label: 'Home Address'+((validator.getMap()["address"]["validation_rules"]!=null)?" *":""),
                                 controller: txtAddress,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "address", widget),

                                ):new SizedBox(),

                            (validator.getMap()["number"]!=null && validator.getMap()["number"]["show"])?
                            new IMTextField(
                                label: 'Contact Number'+((validator.getMap()["number"]["validation_rules"]!=null)?" *":""),
                                 controller: txtNumber,

                                keyboardType: TextInputType.phone,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "number", widget)

                                ):new SizedBox(),
                            
                            (validator.getMap()["mobile"]!=null && validator.getMap()["mobile"]["show"])?
                            new IMTextField(
                                label: 'Mobile'+((validator.getMap()["mobile"]["validation_rules"]!=null)?" *":""), controller: txtMobile,

                                keyboardType: TextInputType.phone,
                                
                                 validator: (text) => widget.validator
                                    .validate(text, "mobile", widget)

                                ):new SizedBox(),
                            
                            (validator.getMap()["telephone"]!=null && validator.getMap()["telephone"]["show"])?
                            new IMTextField(
                                label: 'Home'+((validator.getMap()["telephone"]["validation_rules"]!=null)?" *":""), controller: txtTelephone,

                                keyboardType: TextInputType.phone,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "telephone", widget)

                                ):new SizedBox(),

                            (validator.getMap()["worktelephone"]!=null && validator.getMap()["worktelephone"]["show"])?
                            new IMTextField(
                                label: 'Work'+((validator.getMap()["worktelephone"]["validation_rules"]!=null)?" *":""),
                                 controller: txtWorktelephone,

                                keyboardType: TextInputType.phone,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "worktelephone", widget)

                                ):new SizedBox(),

                            (validator.getMap()["email"]!=null && validator.getMap()["email"]["show"])?
                            new IMTextField(
                                label: 'Email Address'+((validator.getMap()["email"]["validation_rules"]!=null)?" *":""),
                                 controller: txtEmail,

                                keyboardType: TextInputType.emailAddress,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "email", widget)

                                ):new SizedBox(),

                            (validator.getMap()["private"]!=null && validator.getMap()["private"]["show"])?
                            new IMTextField(
                                label: 'Private'+((validator.getMap()["private"]["validation_rules"]!=null)?" *":""),
                                 controller: txtPrivate,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "private", widget)

                                ):new SizedBox(),

                            (validator.getMap()["work"]!=null && validator.getMap()["work"]["show"])?
                            new IMTextField(label: 'Work', controller: txtWork,
                            
                            validator: (text) => widget.validator
                                    .validate(text, "work", widget)

                            ):new SizedBox(),

                            new SizedBox(
                              height: 20.0,
                            ),

                            (validator.getMap()["start"]!=null && validator.getMap()["start"]["show"])?
                            new Text("Start Date & Time *"):SizedBox(),

                            (validator.getMap()["start"]!=null && validator.getMap()["start"]["show"])?
                            new DateTimePickerFormField(
                              dateOnly: false,
                              controller: txtStart,

                              keyboardType: TextInputType.datetime,

                              format: dateTimeFormat,
                              onChanged: (date) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('$date')));
                              },
                            ):SizedBox(),

                            new SizedBox(
                              height: 20.0,
                            ),

                            (validator.getMap()["end"]!=null && validator.getMap()["end"]["show"])?
                            new Text("End Time *"):SizedBox(),

                            (validator.getMap()["end"]!=null && validator.getMap()["end"]["show"])?
                            new TimePickerFormField(
                              controller: txtEndtime,

                              keyboardType: TextInputType.datetime,

                              validator: (text) => widget.validator
                                    .validateTime(text, "bday"),

                              format: timeFormat,
                              onChanged: (date) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('$date')));
                              },
                            ):SizedBox(),

                            (validator.getMap()["place"]!=null && validator.getMap()["place"]["show"])?
                            new IMTextField(
                                label: 'Place'+((validator.getMap()["place"]["validation_rules"]!=null)?" *":""),
                                 controller: txtPlace,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "place", widget)

                                ):SizedBox(),

                            (validator.getMap()["note"]!=null && validator.getMap()["note"]["show"])?
                            new IMTextField(
                              label: 'Note'+((validator.getMap()["note"]["validation_rules"]!=null)?" *":""),
                               controller: txtNote,
                            
                            validator: (text) => widget.validator
                                    .validate(text, "note", widget)

                            ):SizedBox(),

                            (validator.getMap()["remarks"]!=null && validator.getMap()["remarks"]["show"])?
                            new IMTextField(
                                label: 'Remarks'+((validator.getMap()["remarks"]["validation_rules"]!=null)?" *":""), 
                                controller: txtRemarks,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "remarks", widget)

                                ):SizedBox(),

                            new SizedBox(
                              height: 20.0,
                            ),

                            new Text(
                                'Other Person to Participate',
                                ),
                            
                            (validator.getMap()["othersname"]!=null && validator.getMap()["othersname"]["show"])?
                            new IMTextField(
                                label: 'Name'+((validator.getMap()["othersname"]["validation_rules"]!=null)?" *":""),
                                 controller: txtOthersname,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "othersname", widget)

                                ):SizedBox(),

                            (validator.getMap()["othersno"]!=null && validator.getMap()["othersno"]["show"])?
                            new IMTextField(
                                label: 'Contact No'+((validator.getMap()["othersno"]["validation_rules"]!=null)?" *":""),
                                 controller: txtOthersno,

                                keyboardType: TextInputType.phone,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "othersno", widget)

                                ):SizedBox(),

                            (validator.getMap()["othersemail"]!=null && validator.getMap()["othersemail"]["show"])?
                            new IMTextField(
                                label: 'Email'+((validator.getMap()["othersemail"]["validation_rules"]!=null)?" *":""),
                                 controller: txtOthersemail,

                                keyboardType: TextInputType.emailAddress,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "othersemail", widget)

                                ):SizedBox(),

                            new ButtonBar(
                              children: <Widget>[
                                new IMButton(
                                  title: "RESET",
                                  context: context,
                                  onPressed: () => {},
                                  type: ButtonTypes.general,
                                ),
                                new IMButton(
                                  title: "CREATE",
                                  context: context,
                                  onPressed: () {
                                    if (_formKey.currentState.validate() && widget.validator.validateRadio(_radioCustomer, "customer_type", context) && widget.validator.validateRadio(_radioGender, "gender", context) && widget.validator.validateRadio(_radioCivilStatus, "status", context) ) {
                                    Firestore.instance.runTransaction(
                                        (Transaction transaction) async {
                                      CollectionReference reference = Firestore
                                          .instance
                                          .collection('appointments');
                                      await reference.add({
                                        "customer_type": _radioCustomer,
                                        "name": txtName.text,
                                        "bday": txtBday.text,
                                        "gender": _radioGender,
                                        "civil": _radioCivilStatus,
                                        "children": txtChildren.text,
                                        "occupation": txtOccupation.text,
                                        "income": txtIncome.text,
                                        "address": txtAddress.text,
                                        "number": txtNumber.text,
                                        "mobile": txtMobile.text,
                                        "telephone": txtTelephone.text,
                                        "worktelephone": txtWorktelephone.text,
                                        "email": txtEmail.text,
                                        "private": txtPrivate.text,
                                        "work": txtWork.text,
                                        "start": txtStart.text,
                                        "end": txtEndtime.text,
                                        "place": txtPlace.text,
                                        "note": txtNote.text,
                                        "remarks": txtRemarks.text,
                                        "othersname": txtOthersname.text,
                                        "othersno": txtOthersno.text,
                                        "othersemail": txtOthersemail.text,
                                        "date":
                                            txtDate.text + " " + txtTime.text,
                                        "uid": widget.uid,
                                        "type":1
                                      });
                                    });

                                    SmsSender sender = new SmsSender();
                                    String address = txtMobile.text;

                                    sender.sendSms(new SmsMessage(
                                        address,
                                        'Appointment Sheduled. Date: ' +
                                            txtStart.text +
                                            " " +
                                            txtEndtime.text +
                                            " Place: " +
                                            txtPlace.text +
                                            " Participants: " +
                                            txtName.text +
                                            " Note: " +
                                            txtNote.text));
                                    String others = txtOthersno.text;
                                    if (others.isNotEmpty) {
                                      if (others.contains(",")) {
                                        List<String> all = others.split(",");
                                        all.map((one) {
                                          sender.sendSms(new SmsMessage(
                                              one,
                                              'Appointment Sheduled. Date: ' +
                                                  txtStart.text +
                                                  " " +
                                                  txtEndtime.text +
                                                  " Place: " +
                                                  txtPlace.text +
                                                  " Participants: " +
                                                  txtName.text +
                                                  " Note: " +
                                                  txtNote.text));
                                        }).toList();
                                      } else {
                                        sender.sendSms(new SmsMessage(
                                            others,
                                            'Appointment Sheduled. Date: ' +
                                                txtStart.text +
                                                " " +
                                                txtEndtime.text +
                                                " Place: " +
                                                txtPlace.text +
                                                " Participants: " +
                                                txtName.text +
                                                " Note: " +
                                                txtNote.text));
                                      }
                                    }
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
        ))),
      );
}
