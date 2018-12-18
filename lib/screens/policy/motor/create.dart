import 'package:flutter/material.dart';
import '../../../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../../screens/user/auth.dart';
import '../../../components/controls/Validator.dart';

class MotorCreate extends StatefulWidget {
  Validator validator;
  String uid;

  MotorCreate(){
     new Auth().currentUser().then((userId) {
      uid = userId;
            
    });
    validator = new Validator("policies");
  }
  @override
  _MotorState createState() => new _MotorState(validator);

}
class _MotorState extends State<MotorCreate> {
  final _formKey = GlobalKey<FormState>();

  int _radioPeriod = 0;
  int _radioPolicytype = 0;
  int _radioPolicycategory = 0;
  int _radioBusiness = 0;
  int _radioLeasing = 0;
  
  String selectedCustomer = null;

  Validator validator;

  _MotorState(Validator validator){
    this.validator = validator;
    this.validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }


  final dateFormat = DateFormat("yyyy-MM-dd");

  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";

   TextEditingController txtName = TextEditingController();
  TextEditingController txtId = TextEditingController();
  TextEditingController txtVehicleno = TextEditingController();
  TextEditingController txtSum = TextEditingController();
  TextEditingController txtChasisno = TextEditingController();
  TextEditingController txtStart = TextEditingController();
  TextEditingController txtPeriod = TextEditingController();
  TextEditingController txtRenewal = TextEditingController();
  TextEditingController txtType = TextEditingController();
  TextEditingController txtPremium = TextEditingController();
  TextEditingController txtPaid = TextEditingController();
  TextEditingController txtDue = TextEditingController();
  TextEditingController txtDuedate = TextEditingController();
  TextEditingController txtEngine = TextEditingController();
  TextEditingController txtModel = TextEditingController();
  TextEditingController txtYearofmake = TextEditingController();
  TextEditingController txtInsurance = TextEditingController();
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
          title: "NEW MOTOR POLICY",
          context: context,
        ),

        //Content of tabs
        body: new SingleChildScrollView(
          child:  new Form(
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
                          
                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Vehicle Number'+((validator.getMap()["vehicleno"]["validation_rules"]!="")?" *":""),
                            controller:txtVehicleno,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

			                    (validator.getMap()["sum"]!=null && validator.getMap()["sum"]["show"])?
                          new IMTextField(
                            label: 'SUM'+((validator.getMap()["sum"]["validation_rules"]!="")?" *":""),
                            controller:txtSum,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "sum", widget),

                          ):new SizedBox(),

			                    (validator.getMap()["chasisno"]!=null && validator.getMap()["chasisno"]["show"])?
                          new IMTextField(
                            label: 'Chasis Number'+((validator.getMap()["chasisno"]["validation_rules"]!="")?" *":""),
                            controller:txtChasisno,

                            validator: (text) => widget.validator
                                    .validate(text, "chasisno", widget),

                          ):new SizedBox(),

			                    new SizedBox(height: 20.0,),

                                (validator.getMap()["start"]!=null && validator.getMap()["start"]["show"])?
                                new Text("Start Date"):new SizedBox(),

                                (validator.getMap()["start"]!=null && validator.getMap()["start"]["show"])?
                                 new DateTimePickerFormField(
                                dateOnly: true,
                                controller: txtStart,

                                validator: (text) => widget.validator
                                    .validateDate(text, "start"),

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
                                      value: 3,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("1 Year"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),
			                    
                          new SizedBox(height: 20.0,),

			                    (validator.getMap()["renewal"]!=null && validator.getMap()["renewal"]["show"])?
                          new Text("Renewal Date"):new SizedBox(),

                          (validator.getMap()["renewal"]!=null && validator.getMap()["renewal"]["show"])?
			                    new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtRenewal,

                            validator: (text) => widget.validator
                                    .validateDate(text, "renewal"),

            format: dateFormat,
            onChanged: (date) {
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('$date')));
            },
          ):new SizedBox(),
                          
                          new SizedBox(height: 20.0,),

                                (validator.getMap()["policytype"]!=null && validator.getMap()["policytype"]["show"])?
                                new Text("Type of Policy"):new SizedBox(),
                                
                                (validator.getMap()["policytype"]!=null && validator.getMap()["policytype"]["show"])?
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioPolicytype,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioPolicytype = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 80.0,
                                        child: new Text("Comprehensive"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioPolicytype,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioPolicytype = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("Tentative"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),
			                   
                         new SizedBox(height: 20.0,),

                               (validator.getMap()["policycategory"]!=null && validator.getMap()["policycategory"]["show"])?
                                new Text("Category of Policy"):new SizedBox(),

                                (validator.getMap()["policycategory"]!=null && validator.getMap()["policycategory"]["show"])?
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioPolicycategory,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioPolicycategory = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 80.0,
                                        child: new Text("Private"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioPolicycategory,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioPolicycategory = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("Hiring"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),
			   
                                new SizedBox(height: 20.0,),

                                (validator.getMap()["business"]!=null && validator.getMap()["business"]["show"])?
                                new Text("Type of Business"):new SizedBox(),
                                
                                (validator.getMap()["business"]!=null && validator.getMap()["business"]["show"])?
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioBusiness,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioBusiness = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 80.0,
                                        child: new Text("New"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioBusiness,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioBusiness = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("Renewal"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),
			   
                                new SizedBox(height: 20.0,),

                                (validator.getMap()["leasing"]!=null && validator.getMap()["leasing"]["show"])?
                                new Text("Leasing Facility"):new SizedBox(),
                                
                                (validator.getMap()["leasing"]!=null && validator.getMap()["leasing"]["show"])?
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioLeasing,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioLeasing = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 50.0,
                                        child: new Text("Yes"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioLeasing,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioLeasing = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("No"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),
			   
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
                            label: 'Due Amount'+((validator.getMap()["due"]["validation_rules"]!="")?" *":""),
                            controller:txtDue,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "due", widget),

                          ):new SizedBox(),

			                     new SizedBox(height: 20.0,),

                          (validator.getMap()["duedate"]!=null && validator.getMap()["duedate"]["show"])?
			                    new Text("Due Date"):SizedBox(),

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
                          ):SizedBox(),

			                    (validator.getMap()["engine"]!=null && validator.getMap()["engine"]["show"])?
                          new IMTextField(
                            label: 'Engine Number'+((validator.getMap()["engine"]["validation_rules"]!="")?" *":""),
                            controller:txtEngine,

                            validator: (text) => widget.validator
                                    .validate(text, "engine", widget),
                          ):new SizedBox(),

			                    (validator.getMap()["model"]!=null && validator.getMap()["model"]["show"])?
                          new IMTextField(
                            label: 'Model'+((validator.getMap()["model"]["validation_rules"]!="")?" *":""),
                            controller:txtModel,

                            validator: (text) => widget.validator
                                    .validate(text, "model", widget),
                          ):new SizedBox(),

			                    (validator.getMap()["yearofmake"]!=null && validator.getMap()["yearofmake"]["show"])?
                          new IMTextField(
                            label: 'Year of Make'+((validator.getMap()["yearofmake"]["validation_rules"]!="")?" *":""),
                            controller:txtYearofmake,

                            validator: (text) => widget.validator
                                    .validate(text, "yearofmake", widget),
                          ):new SizedBox(),

			                    (validator.getMap()["insurance"]!=null && validator.getMap()["insurance"]["show"])?
                          new IMTextField(
                            label: 'Insurance For'+((validator.getMap()["insurance"]["validation_rules"]!="")?" *":""),
                            controller:txtInsurance,

                            validator: (text) => widget.validator
                                    .validate(text, "insurance", widget),
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
                                      if (_formKey.currentState.validate() && widget.validator.validateRadio(_radioPeriod, "period", context)
                                       && widget.validator.validateRadio(_radioPolicytype, "policytype", context)
                                       && widget.validator.validateRadio(_radioPolicycategory, "policycategory", context)
                                       && widget.validator.validateRadio(_radioBusiness, "business", context) 
                                      && widget.validator.validateRadio(_radioLeasing, "leasing", context) ) {
                                        Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('policies');
                                      await reference.add({
                                        "name":selectedCustomer.split(" - ")[1],
                                        "id":selectedCustomer.split(" - ")[0],
                                        "type":2,
                                        "vehicleno":txtVehicleno.text,
                                        "sum":txtSum.text,
                                        "chasisno":txtChasisno.text,
                                        "start":txtStart.text,
                                        "period":_radioPeriod,
                                        "renewal":txtRenewal.text,
                                        "policytype":_radioPolicytype,
                                        "policycategory":_radioPolicycategory,
                                        "business":_radioBusiness,
                                        "leasing":_radioLeasing,
                                        "premium":txtPremium.text,
                                        "paid":txtPaid.text,
                                        "due":txtDue.text,
                                        "duedate":txtDuedate.text,
                                        "engine":txtEngine.text,
                                        "model":txtModel.text,
                                        "yearofmake":txtYearofmake.text,
                                        "insurance":txtInsurance.text,
                                        "uid":widget.uid
                                        });
                                      
                                    });

                                        // SmsSender sender = new SmsSender();
                                        // String address = txtMobile.text;
   
                                        // sender.sendSms(new SmsMessage(address, 'Appointment Sheduled. Date: '+txtDate.text+" "+txtTime.text+" Place: "+txtPlace.text+" Participants: "+txtName.text+" Note: "+txtNote.text));

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
