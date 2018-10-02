import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/IM.dart';

class CustomerCreate extends StatefulWidget {

  @override
  _CustomersState createState() => new _CustomersState();

}


class _CustomersState extends State<CustomerCreate> {
  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNic = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW CUSTOMER",
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        
                        children: <Widget>[
                
                          new IMTextField(
                            label: 'Customer / Company Name',
                            controller:txtName
                          ),
                          new IMTextField(
                            label: 'Social Securty No/ NIC/ Passport',
                            controller:txtNic
                            
                          ),
			                    new Text("Image"),
                          new IMButton(
                                title: "Browse",
                                context: context,
                                onPressed: () => {},
                                type: ButtonTypes.general,
                         ),
                          new IMTextField(
                            label: 'Birthday / Start Date',
                            
                          ),
                          new IMTextField(
                            label: 'Gender',
                            
                          ),
                          new IMTextField(
                            label: 'Civil Status',
                            
                          ),
                          new IMTextField(
                            label: 'No of Children',
                            
                          ),
                          new IMTextField(
                            label: 'Height',
                            
                          ),
                          new IMTextField(
                            label: 'Weight',
                            
                          ),
                          new IMTextField(
                            label: 'Civil StatusSuffering from any Diseases or Disabilities',
                            
                          ),
                          new IMTextField(
                            label: 'Occupation / Type of Business',
                            
                          ),
                          new IMTextField(
                            label: 'Income',
                            
                          ),
                          new IMTextField(
                            label: 'Civil StatusHome Address / Register Address',
                            
                          ),
                          new IMTextField(
                            label: 'Work Address',
                            
                          ),
                          new Text(
                            'Contact Number',
                            
                          ),
                          new IMTextField(
                            label: 'Mobile',
                            
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
                            label: 'Private'
                            
                          ),
                          new IMTextField(
                            label: 'Work',
                            
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
                                      CollectionReference reference = Firestore.instance.collection('customers');
                                      await reference.add({"name":txtName.text,"nic":txtNic.text});
                                      
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
