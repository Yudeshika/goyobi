import 'package:flutter/material.dart';
import '../../../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms/sms.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../../screens/user/auth.dart';
import '../../../components/controls/Validator.dart';

class LifeCreate extends StatefulWidget {
  Validator validator;
  String uid;

  LifeCreate(){
     new Auth().currentUser().then((userId) {
      uid = userId;
            
    });
     validator = new Validator("policies");
  }
  @override
  _LifeState createState() => new _LifeState(validator);

}
class _LifeState extends State<LifeCreate> {
  final _formKey = GlobalKey<FormState>();

  Validator validator;

  _LifeState(Validator validator){
    this.validator = validator;
    this.validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }

  int _radioPaymentdate = 0;
  String selectedCustomer = null;

  final dateFormat = DateFormat("yyyy-MM-dd");

  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";

  TextEditingController txtPolicyno = TextEditingController();
  TextEditingController txtProposalno = TextEditingController();
  TextEditingController txtSum = TextEditingController();
  TextEditingController txtPolicyname = TextEditingController();
  TextEditingController txtCommenceddate = TextEditingController();
  TextEditingController txtPolicyperiod = TextEditingController();
  TextEditingController txtEnddate = TextEditingController();
  TextEditingController txtPremium = TextEditingController();
  TextEditingController txtNextpayment = TextEditingController();
  TextEditingController txtPolicyfees = TextEditingController();
  TextEditingController txtPaid = TextEditingController();
  TextEditingController txtDue = TextEditingController();
  TextEditingController txtDuedate = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW LIFE POLICY",
          context: context,
        ),

        //Content of tabs
        body: new SingleChildScrollView(
          child: new Form(
          key: _formKey,
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
                          
                          new Text("Select Customer"),
                          StreamBuilder(
                                stream: Firestore.instance
                                    .collection("customers")
                                    .where("uid", isEqualTo: widget.uid)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('Loading...');
                                  return new DropdownButton(
                                      elevation: 0,
                                      value: selectedCustomer,
                                      items: snapshot.data.documents
                                          .map((DocumentSnapshot document) {
                                        String name = document["name"];
                                        // if(name.toLowerCase().contains(filter.toLowerCase())){
                                        return DropdownMenuItem(
                                            value: document.documentID+" - "+name,
                                            child: Row(
                                              children: <Widget>[
                                                new Icon(Icons.person),
                                                new SizedBox(width: 5.0),
                                                new Text(name)
                                              ],
                                            ));
                                        // }
                                      }).toList(),
                                      onChanged: (value) {
                                        print(value);
                                        selectedCustomer = value;
                                        setState(() {});
                                      });
                                },
                              ),
                          			
                          // new IMTextField(
                          //   label: 'Customer Name',
                          //   controller:txtName
                          // ),
                          // new IMTextField(
                          //   label: 'Customer ID',
                          //   controller:txtId
                          // ),

                          (validator.getMap()["policyno"]!=null && validator.getMap()["policyno"]["show"])?
                          new IMTextField(
                            label: 'Policy Number'+((validator.getMap()["policyno"]["validation_rules"]!="")?" *":""),
                            controller:txtPolicyno,

                            validator: (text) => widget.validator
                                    .validate(text, "policyno", widget),

                          ):new SizedBox(),
			                    
                          (validator.getMap()["proposalno"]!=null && validator.getMap()["proposalno"]["show"])?
                          new IMTextField(
                            label: 'Proposal Number'+((validator.getMap()["proposalno"]["validation_rules"]!="")?" *":""),
                            controller:txtProposalno,
                            
                            validator: (text) => widget.validator
                                    .validate(text, "proposalno", widget),

                          ):new SizedBox(),
			                    
                          (validator.getMap()["sum"]!=null && validator.getMap()["sum"]["show"])?
                          new IMTextField(
                            label: 'SUM'+((validator.getMap()["sum"]["validation_rules"]!=null)?" *":""),
                            controller:txtSum,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "sum", widget),

                          ):new SizedBox(),
			                    
                          (validator.getMap()["policyname"]!=null && validator.getMap()["policyname"]["show"])?
                          new IMTextField(
                            label: 'Name of Policy'+((validator.getMap()["policyname"]["validation_rules"]!="")?" *":""),
                            controller:txtPolicyname,

                            validator: (text) => widget.validator
                                    .validate(text, "policyname", widget),

                          ):new SizedBox(),
                         
                          new SizedBox(height: 20.0,),

                          (validator.getMap()["commenceddate"]!=null && validator.getMap()["commenceddate"]["show"])?
			                    new Text("Commence Date"):SizedBox(),

                          (validator.getMap()["commenceddate"]!=null && validator.getMap()["commenceddate"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtCommenceddate,

                            validator: (text) => widget.validator
                                    .validateDate(text, "commenceddate"),

                            format: dateFormat,
                            onChanged: (date) {
                              Scaffold
                              .of(context)
                              .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):SizedBox(),
			                    
                          (validator.getMap()["policyperiod"]!=null && validator.getMap()["policyperiod"]["show"])?
                          new IMTextField(
                            label: 'Period of Policy',
                            controller:txtPolicyperiod,

                            validator: (text) => widget.validator
                                    .validate(text, "policyperiod", widget),

                          ):new SizedBox(),
			                    
                          (validator.getMap()["enddate"]!=null && validator.getMap()["enddate"]["show"])?
                          new IMTextField(
                            label: 'End Date'+((validator.getMap()["enddate"]["validation_rules"]!="")?" *":""),
                            controller:txtEnddate,

                            validator: (text) => widget.validator
                                    .validate(text, "enddate", widget),

                          ):new SizedBox(),
			                    
                          (validator.getMap()["premium"]!=null && validator.getMap()["premium"]["show"])?
                          new IMTextField(
                            label: 'Premium'+((validator.getMap()["premium"]["validation_rules"]!="")?" *":""),
                            controller:txtPremium,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "premium", widget),

                          ):new SizedBox(),

                          new SizedBox(height: 20.0,),
                                
                                (validator.getMap()["paymentmode"]!=null && validator.getMap()["paymentmode"]["show"])?
                                new Text("Payment Mode"):new SizedBox(),

                                (validator.getMap()["paymentmode"]!=null && validator.getMap()["paymentmode"]["show"])?
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioPaymentdate,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioPaymentdate = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 50.0,
                                        child: new Text("Monthly"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioPaymentdate,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioPaymentdate = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("Annualy"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),
 
			                    (validator.getMap()["nextpayment"]!=null && validator.getMap()["nextpayment"]["show"])?
                          new IMTextField(
                            label: 'Next Payment Date'+((validator.getMap()["nextpayment"]["validation_rules"]!="")?" *":""),
                            controller:txtNextpayment,

                            validator: (text) => widget.validator
                                    .validate(text, "nextpayment", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["policyfees"]!=null && validator.getMap()["policyfees"]["show"])?
                          new IMTextField(
                            label: 'Policy Fees'+((validator.getMap()["policyfees"]["validation_rules"]!="")?" *":""),
                            controller:txtPolicyfees,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "policyfees", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["paid"]!=null && validator.getMap()["paid"]["show"])?
                          new IMTextField(
                            label: 'Paid Amount'+((validator.getMap()["paid"]["validation_rules"]!="")?" *":""),
                            controller:txtPaid,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "paid", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["due"]!=null && validator.getMap()["due"]["show"])?
                          new IMTextField(
                            label: 'Due Amount'+((validator.getMap()["due"]["validation_rules"]!="")?" *":""),
                            controller:txtDue,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "due", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["duedate"]!=null && validator.getMap()["duedate"]["show"])?
                          new Text("Due Date"):new SizedBox(),

                          (validator.getMap()["duedate"]!=null && validator.getMap()["duedate"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtDuedate,

                            validator: (text) => widget.validator
                                    .validateDate(text, "duedate"),
                                    
            format: dateFormat,
            onChanged: (date) {
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('$date')));
            },
          ):new SizedBox(),

			                   
			                  //   new Text("Vehicle Image"),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),
			                  //   new Text("Proposal Image"),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),
                          
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
                                      if (_formKey.currentState.validate() && widget.validator.validateRadio(_radioPaymentdate, "paymentdate", context) ) {
                                        Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('policies');
                                      await reference.add({
                                        "name":selectedCustomer.split(" - ")[1],
                                        "id":selectedCustomer.split(" - ")[0],
                                        "type":1,
                                        "policyno":txtPolicyno.text,
                                        "proposalno":txtProposalno.text,
                                        "sum":txtSum.text,
                                        "policyname":txtPolicyname.text,
                                        "commenceddate":txtCommenceddate.text,
                                        "policyperiod":txtPolicyperiod.text,
                                        "enddate":txtEnddate.text,
                                        "premium":txtPremium.text,
                                        "paymentmode":_radioPaymentdate,
                                        "nextpayment":txtNextpayment.text,
                                        "policyfees":txtPolicyfees.text,
                                        "paid":txtPaid.text,
                                        "due":txtDue.text,
                                        "duedate":txtDuedate.text,
                                        "uid":widget.uid
                                        });


                                      
                                    });

                                        final DocumentReference postRef = Firestore.instance.document('customers/'+selectedCustomer.split(" - ")[0]);
                                        Firestore.instance.runTransaction((Transaction tx) async {
                                          DocumentSnapshot postSnapshot = await tx.get(postRef);
                                          if (postSnapshot.exists) {
                                            await tx.update(postRef, <String, dynamic>{'type': 2});
                                          }
                                        });
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
            ))
          
        ),
      );
}
