import 'package:flutter/material.dart';
import '../../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms/sms.dart';

class AppointmentCreate extends StatefulWidget {
  @override
  _AppointmentsState createState() => new _AppointmentsState();

}
class _AppointmentsState extends State<AppointmentCreate> {

  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";

   TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtNote = TextEditingController();
  TextEditingController txtPlace = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtTime = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW APPOINTMENT",
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
                                new IMDropdownButton(items: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Text("Type of Customer"),
                                  )
                                ]),
                                new IMTextField(
                                  label: 'Customer Name',
                                  controller:txtName
                                ),
                                new IMTextField(
                                  label: 'Birthday',
                                ),
                                new IMDropdownButton(items: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Text("Gender"),
                                  )
                                ]),
                                new IMDropdownButton(items: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Text("Civil Status"),
                                  )
                                ]),
                                new IMTextField(
                                  label: 'No of Children',
                                ),
                                new IMTextField(
                                  label: 'Occupation',
                                ),
                                new IMDropdownButton(items: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Text("Income"),
                                  )
                                ]),
                                new IMTextField(
                                  label: 'Home Address',
                                ),
                                new Text(
                                  'Contact Number',
                                ),
                                new IMTextField(
                                  label: 'Mobile',
                                  controller:txtMobile
                                ),
                                new IMTextField(
                                  label: 'Home',
                                ),
                                new IMTextField(
                                  label: 'Work',
                                ),
                                new Text(
                                  'Email Address',
                                ),
                                new IMTextField(
                                  label: 'Private',
                                ),
                                new IMTextField(
                                  label: 'Work',
                                ),
                                new IMTextField(
                                  label:'Start Date',
                                  controller:txtDate
                                ), 
                                new IMTextField(
                                  label:'Start Time',
                                  controller:txtTime
                                ),  
                                new IMTextField(
                                  label: '',
                                ),
                                new Text(
                                  'End Time',
                                ),
                                new IMTextField(
                                  label: '',
                                ),
                                new IMTextField(
                                  label:'Place',
                                  controller:txtPlace
                                ), 
                                new IMTextField(
                                  label: 'Note',
                                  controller:txtNote
                                ),
                                new IMTextField(
                                  label: 'Remarks',
                                ),
                                new Text(
                                  'Other Person to Participate',
                                ),
                                new IMTextField(
                                  label: 'Name',
                                ),
                                new IMTextField(
                                  label: 'Contact No',
                                ),
                                new IMTextField(
                                  label: 'Email',
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
                                      title: "CREATE",
                                      context: context,
                                      onPressed: () {

                                        Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('appointments');
                                      await reference.add({"customer":txtName.text,"mobile":txtMobile.text,"date":txtDate.text+" "+txtTime.text,"place":txtPlace.text,"note":txtNote.text});
                                      
                                    });

                                        SmsSender sender = new SmsSender();
                                        String address = txtMobile.text;
   
                                        sender.sendSms(new SmsMessage(address, 'Appointment Sheduled. Date: '+txtDate.text+" "+txtTime.text+" Place: "+txtPlace.text+" Participants: "+txtName.text+" Note: "+txtNote.text));

                                        Navigator.pop(context);
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
            )
          
        ),
      );
}
