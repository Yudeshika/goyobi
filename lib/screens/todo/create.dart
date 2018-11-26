import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/IM.dart';
 
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../screens/user/auth.dart';

class TodoCreate extends StatefulWidget {

  String uid;
  TodoCreate(){
     new Auth().currentUser().then((userId) {
      uid = userId;
            
    });
  }

  @override
  _TodoState createState() => new _TodoState();

}


class _TodoState extends State<TodoCreate> {
  static DateTime now = DateTime.now();

  

  final dateFormat = DateFormat("yyyy-MM-dd h:mm a");
  


  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDate = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW TO-DO",
          context: context,
        ),
        //Content of tabs
        body:
        
         new SingleChildScrollView ( 
          child: 
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: 
                new Column(
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
                
                          new IMTextField(
                            label: 'Task Name',
                            controller:txtName,
                            keyboardType: TextInputType.text,
                          ),
                          new SizedBox(height: 20.0,),
			                    new Text("Date"),  
                          new DateTimePickerFormField(
                            dateOnly: false,
                            controller: txtDate,
                            format: dateFormat,
                            onChanged: (date) {
                            Scaffold
                            .of(context)
                            .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ),

                          new ButtonBar(
                            children: <Widget>[
                              new IMButton(
                                title: "RESET",
                                context: context,
                                onPressed: () {
                                  Scaffold.of(context).showSnackBar(new SnackBar(
                                    content: new Text("Text="+txtName.text),
                                  ));
                                },
                                type: ButtonTypes.general,
                              ),
                              new IMButton(
                                title: "SAVE",
                                context: context,
                                onPressed: () {
                                    Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('todos');
                                      await reference.add({
                                        "name":txtName.text,
                                        "do_on":dateFormat.parse(txtDate.text),
                                        "created_on": DateTime.now(),
                                        "done":false,
                                        "uid": widget.uid

                                        });
                                      
                                    });

                                    //Scaffold.of(context).showSnackBar(new SnackBar(
                                    //    content: new Text("Saved!"),
                                    //  ));
                                      //Navigator.of(context).pushNamed("/customers");
                                      Navigator.pop(context);
                                  //Firestore.instance.collection('customers').add({"name":"Nuwan Wickrama"});

                                },
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
