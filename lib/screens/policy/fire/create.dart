import 'package:flutter/material.dart';
import '../../../components/IM.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms/sms.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../../screens/user/auth.dart';
import '../../../components/controls/Validator.dart';

class FireCreate extends StatefulWidget {
  Validator validator;
  String uid;

  FireCreate(){
     new Auth().currentUser().then((userId) {
      uid = userId;
            
    });
    validator = new Validator("policies");
  }

  @override
  _FireState createState() => new _FireState(validator);

}
class _FireState extends State<FireCreate> {
  final _formKey = GlobalKey<FormState>();

  int _radioPeriod = 0;
  int _radioPolicytype = 0;
  int _radioBusiness = 0;

   Validator validator;

  _FireState(Validator validator){
    this.validator = validator;
    this.validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }


  String selectedCustomer = null;

  final dateFormat = DateFormat("yyyy-MM-dd");

  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";

   //TextEditingController txtName = TextEditingController();
  //TextEditingController txtId = TextEditingController();
  TextEditingController txtPolicyno = TextEditingController();
  TextEditingController txtProposalno = TextEditingController();
  TextEditingController txtSum = TextEditingController();
  TextEditingController txtPolicytype = TextEditingController();
  TextEditingController txtBusiness = TextEditingController();
  TextEditingController txtStart = TextEditingController();
  TextEditingController txtPeriod = TextEditingController();
  TextEditingController txtRenewal = TextEditingController();
  TextEditingController txtPremium = TextEditingController();
  TextEditingController txtPaid = TextEditingController();
  TextEditingController txtDue = TextEditingController();
  TextEditingController txtDuedate = TextEditingController();
  TextEditingController txtLocation = TextEditingController();
  TextEditingController txtInventorylist = TextEditingController();
  TextEditingController txtItemname = TextEditingController();
  TextEditingController txtSerialno = TextEditingController();
  TextEditingController txtModel = TextEditingController();
  TextEditingController txtYearofmake = TextEditingController();
  TextEditingController txtValue = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW FIRE POLICY",
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
                            label: 'SUM'+((validator.getMap()["sum"]["validation_rules"]!="")?" *":""),
                            controller:txtSum,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "sum", widget),

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
                                        width: 80.0,
                                        child: new Text("Third Party"),
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
                                        width: 80.0,
                                        child: new Text("Renewal"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),


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

                          (validator.getMap()["location"]!=null && validator.getMap()["location"]["show"])?      
			                    new IMTextField(
                            label: 'Policy Location Address'+((validator.getMap()["location"]["validation_rules"]!=null)?" *":""),
                            controller:txtLocation,

                            validator: (text) => widget.validator
                                    .validate(text, "location", widget),

                          ):new SizedBox(),

			                    SizedBox(height: 25.0),
                          new Text(
                            "INVENTORY LIST:",
                            style: TextStyle(
                                      color: Colors.deepOrange[300],
                                      fontSize: 20.0,
                                    ),
                                    

                          ),

                          (validator.getMap()["itemname"]!=null && validator.getMap()["itemname"]["show"])?
			                    new IMTextField(
                            label: 'Item Name'+((validator.getMap()["itemname"]["validation_rules"]!="")?" *":""),
                            controller:txtItemname,

                            validator: (text) => widget.validator
                                    .validate(text, "itemname", widget),

                          ):new SizedBox(),

                          (validator.getMap()["serialno"]!=null && validator.getMap()["serialno"]["show"])?
                          new IMTextField(
                            label: 'Serial No'+((validator.getMap()["serialno"]["validation_rules"]!="")?" *":""),
                            controller:txtSerialno,

                            validator: (text) => widget.validator
                                    .validate(text, "serialno", widget),

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
                            label: 'Year of Manufacture'+((validator.getMap()["yearofmake"]["validation_rules"]!=null)?" *":""),
                            controller:txtYearofmake,

                            validator: (text) => widget.validator
                                    .validate(text, "yearofmake", widget),

                          ):new SizedBox(),

                          (validator.getMap()["value"]!=null && validator.getMap()["value"]["show"])?
                          new IMTextField(
                            label: 'Value'+((validator.getMap()["value"]["validation_rules"]!="")?" *":""),
                            controller:txtValue,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "value", widget),

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
                                        if (_formKey.currentState.validate() && widget.validator.validateRadio(_radioPeriod, "period", context) && widget.validator.validateRadio(_radioPolicytype, "policytype", context) && widget.validator.validateRadio(_radioBusiness, "business", context)){
                                        Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('policies');
                                      await reference.add({
                                         "name":selectedCustomer.split(" - ")[1],
                                        "id":selectedCustomer.split(" - ")[0],
                                        "type":3,
                                        "policyno":txtPolicyno .text,
                                        "proposalno":txtProposalno .text,
                                        "sum":txtSum.text,
                                        "policytype":_radioPolicytype,
                                        "business":_radioBusiness,
                                        "start":txtStart.text,
                                        "renewal":txtRenewal.text,
                                        "period":_radioPeriod,
                                        "premium":txtPremium.text,
                                        "paid":txtPaid.text,
                                        "due":txtDue.text,
                                        "duedate":txtDuedate.text,
                                        "location":txtLocation .text,
                                        "itemname":txtItemname  .text,
                                        "serialno":txtSerialno   .text,
                                        "model":txtModel.text,
                                        "yearofmake":txtYearofmake.text,
                                        "value":txtValue.text,
                                        "uid":widget.uid
                                        });
                                      
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
