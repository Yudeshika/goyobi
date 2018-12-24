import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/IM.dart';
 
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../../components/controls/Validator.dart';
import '../../../screens/user/auth.dart';

class DtaCreate extends StatefulWidget {
  Validator validator;
  String uid;

  DtaCreate(){
     new Auth().currentUser().then((userId) {
      uid = userId;
            
    });
    validator = new Validator("policies");
  }

  @override
  _DtasState createState() => new _DtasState(validator);

}


class _DtasState extends State<DtaCreate> {
final _formKey = GlobalKey<FormState>();

 Validator validator;

  _DtasState(Validator validator){
    this.validator = validator;
    this.validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }

  static DateTime now = DateTime.now();

  int _radioPeriod = 0;

  String selectedCustomer = null;

  final dateFormat = DateFormat("yyyy-MM-dd");
  


  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";
  TextEditingController txtName = TextEditingController();
  // TextEditingController txtId = TextEditingController();
  TextEditingController txtApplicantname = TextEditingController();
  TextEditingController txtApplicantaddress = TextEditingController();
  TextEditingController txtPolicyno = TextEditingController();
  TextEditingController txtProposalno = TextEditingController();
  TextEditingController txtLoanvalue = TextEditingController();
  TextEditingController txtStart = TextEditingController();
  TextEditingController txtEnd = TextEditingController();
  TextEditingController txtPremium = TextEditingController();
  TextEditingController txtPaid = TextEditingController();
  TextEditingController txtDue = TextEditingController();
  TextEditingController txtDuedate = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW DTA POLICY",
          context: context,
        ),
        //Content of tabs
        body:
        
         new SingleChildScrollView ( 
          child:  new Form(
          key: _formKey,
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

                          (validator.getMap()["applicantname"]!=null && validator.getMap()["applicantname"]["show"])?	
                          new IMTextField(
                            label: 'Applicant Name'+((validator.getMap()["applicantname"]["validation_rules"]!="")?" *":""),
                            controller:txtApplicantname,

                             validator: (text) => widget.validator
                                    .validate(text, "applicantname", widget),
                                    
                          ):new SizedBox(),

                          (validator.getMap()["applicantaddress"]!=null && validator.getMap()["applicantaddress"]["show"])?
                          new IMTextField(
                            label: 'Applicant Address'+((validator.getMap()["applicantaddress"]["validation_rules"]!="")?" *":""),
                            controller:txtApplicantaddress,

                             validator: (text) => widget.validator
                                    .validate(text, "applicantaddress", widget),

                          ):new SizedBox(),

                          (validator.getMap()["policyno"]!=null && validator.getMap()["policyno"]["show"])?
                          new IMTextField(
                            label: 'Policy No'+((validator.getMap()["policyno"]["validation_rules"]!="")?" *":""),
                            controller:txtPolicyno,

                             validator: (text) => widget.validator
                                    .validate(text, "policyno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["proposalno"]!=null && validator.getMap()["proposalno"]["show"])?
                          new IMTextField(
                            label: 'Proposal No'+((validator.getMap()["proposalno"]["validation_rules"]!="")?" *":""),
                            controller:txtProposalno,

                             validator: (text) => widget.validator
                                    .validate(text, "proposalno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["loanvalue"]!=null && validator.getMap()["loanvalue"]["show"])?
                          new IMTextField(
                            label: 'Loan Value'+((validator.getMap()["loanvalue"]["validation_rules"]!="")?" *":""),
                            controller:txtLoanvalue,

                            keyboardType: TextInputType.number,

                             validator: (text) => widget.validator
                                    .validate(text, "loanvalue", widget),

                          ):new SizedBox(),
                          
                          new SizedBox(height: 20.0,),

                          (validator.getMap()["startdate"]!=null && validator.getMap()["startdate"]["show"])?
			                    new Text("Start Date"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  

                          (validator.getMap()["startdate"]!=null && validator.getMap()["startdate"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtStart,

                             validator: (text) => widget.validator
                                    .validateDate(text, "startdate"),

                            format: dateFormat,
                            onChanged: (date) {
                              Scaffold
                                  .of(context)
                                  .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):new SizedBox(),

                          new SizedBox(height: 20.0,),

                          (validator.getMap()["period"]!=null && validator.getMap()["period"]["show"])?
                          new Text("Period of Policy"):new SizedBox(),

                          (validator.getMap()["period"]!=null && validator.getMap()["period"]["show"])?
                          new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioPeriod,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioPeriod = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 50.0,
                                        child: new Text("1 Week"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioPeriod,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioPeriod = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("1 Month"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),

                                      new SizedBox(height: 20.0,),

                                      (validator.getMap()["enddate"]!=null && validator.getMap()["enddate"]["show"])?
                                      new Text("End Date"):new SizedBox(),
                                    //   new IMButton(
                                    //         title: "Browse",
                                    //         context: context,
                                    //         onPressed: () => {},
                                    //         type: ButtonTypes.general,
                                    //  ), 

                                      (validator.getMap()["enddate"]!=null && validator.getMap()["enddate"]["show"])? 
                                      new DateTimePickerFormField(
                                        dateOnly: true,
                                        controller: txtEnd,

                                         validator: (text) => widget.validator
                                    .validateDate(text, "enddate"),

                                        format: dateFormat,
                                        onChanged: (date) {
                                          Scaffold
                                              .of(context)
                                              .showSnackBar(SnackBar(content: Text('$date')));
                                        },
                                      ):new SizedBox(),

                          (validator.getMap()["premium"]!=null && validator.getMap()["premium"]["show"])?
                          new IMTextField(
                            label: 'Premium'+((validator.getMap()["premium"]["validation_rules"]!="")?" *":""),
                            controller:txtPremium,

                            keyboardType: TextInputType.number,

                             validator: (text) => widget.validator
                                    .validate(text, "premium", widget),

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
                            label: 'Balance Amount'+((validator.getMap()["due"]["validation_rules"]!="")?" *":""),
                            controller:txtDue,

                            keyboardType: TextInputType.number,

                             validator: (text) => widget.validator
                                    .validate(text, "due", widget),

                          ):new SizedBox(),

                          new SizedBox(height: 20.0,),

			                    (validator.getMap()["duedate"]!=null && validator.getMap()["duedate"]["show"])?
                          new Text("Due Date"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  

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
                                  if (_formKey.currentState.validate() && widget.validator.validateRadio(_radioPeriod, "period", context)){
                                    Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('policies');
                                      await reference.add({
                                        "name":selectedCustomer.split(" - ")[1],
                                        "id":selectedCustomer.split(" - ")[0],
                                        "type":4,
                                        "applicantname":txtApplicantname.text,
                                        "applicantaddress":txtApplicantaddress .text,
                                        "period":_radioPeriod,
                                        "policyno":txtPolicyno.text,
                                        "proposalno":txtProposalno.text,
                                        "loanvalue":txtLoanvalue.text,
                                        "startdate":txtStart.text,
                                        "enddate":txtEnd.text,
                                        "premium":txtPremium.text,
                                        "paid":txtPaid.text,
                                        "due":txtDue.text,
                                        "duedate":txtDuedate.text,
                                        "uid":widget.uid
                                        });
                                      
                                    });

                                    // final DocumentReference postRef = Firestore.instance.document('customers/'+selectedCustomer.split(" - ")[0]);
                                    //     Firestore.instance.runTransaction((Transaction tx) async {
                                    //       DocumentSnapshot postSnapshot = await tx.get(postRef);
                                    //       if (postSnapshot.exists) {
                                    //         await tx.update(postRef, <String, dynamic>{'type': 2});
                                    //       }
                                    //     });

                                    //Scaffold.of(context).showSnackBar(new SnackBar(
                                    //    content: new Text("Saved!"),
                                    //  ));
                                      //Navigator.of(context).pushNamed("/customers");
                                      Navigator.pop(context);
                                  //Firestore.instance.collection('customers').add({"name":"Nuwan Wickrama"});

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
                      )
                    ),
                  ],
                ),
                 ),
              ],
            ))
          
        ),
        
      );



      


}
