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

   Validator validator;

  _FireState(Validator validator){
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
  TextEditingController txtPolicyno = TextEditingController();
  TextEditingController txtProposalno = TextEditingController();
  TextEditingController txtSum = TextEditingController();
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
                          
                          
                          (validator.getMap()["name"]!=null && validator.getMap()["name"]["show"])?			
                          new IMTextField(
                            label: 'Customer Name'+((validator.getMap()["name"]["validation_rules"]!=null)?" *":""),
                            controller:txtName,

                            validator: (text) => widget.validator
                                    .validate(text, "name", widget),

                          ):new SizedBox(),

                          (validator.getMap()["id"]!=null && validator.getMap()["id"]["show"])?
                          new IMTextField(
                            label: 'Customer ID'+((validator.getMap()["id"]["validation_rules"]!=null)?" *":""),
                            controller:txtId,

                            validator: (text) => widget.validator
                                    .validate(text, "id", widget),

                          ):new SizedBox(),

                          (validator.getMap()["policyno"]!=null && validator.getMap()["policyno"]["show"])?
                          new IMTextField(
                            label: 'Policy Number'+((validator.getMap()["policyno"]["validation_rules"]!=null)?" *":""),
                            controller:txtPolicyno,

                            validator: (text) => widget.validator
                                    .validate(text, "policyno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["proposalno"]!=null && validator.getMap()["proposalno"]["show"])?
			                    new IMTextField(
                            label: 'Proposal Number'+((validator.getMap()["proposalno"]["validation_rules"]!=null)?" *":""),
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

                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMDropdownButton(
                            items:<DropdownMenuItem>[
                              DropdownMenuItem(child: Text("Type of Policy"),)
                            ]
                          ):new SizedBox(),


			                    new IMDropdownButton(
                            items:<DropdownMenuItem>[
                              DropdownMenuItem(child: Text("Type of Business"),)
                            ]
                          ),

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
                                        child: new Text("2 Weeks"),
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

			                    (validator.getMap()["premium"]!=null && validator.getMap()["premium"]["show"])?
			                    new IMTextField(
                            label: 'Premium'+((validator.getMap()["premium"]["validation_rules"]!=null)?" *":""),
                            controller:txtPremium,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "premium", widget),

                          ):new SizedBox(),

                          (validator.getMap()["paid"]!=null && validator.getMap()["paid"]["show"])?
                          new IMTextField(
                            label: 'Paid Amount'+((validator.getMap()["paid"]["validation_rules"]!=null)?" *":""),
                            controller:txtPaid,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "paid", widget),

                          ):new SizedBox(),

			                    (validator.getMap()["due"]!=null && validator.getMap()["due"]["show"])?
			                    new IMTextField(
                            label: 'Balance Amount'+((validator.getMap()["due"]["validation_rules"]!=null)?" *":""),
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

			                    new IMTextField(
                            label: 'INVENTORY LIST',

                          ),

                          (validator.getMap()["itemname"]!=null && validator.getMap()["itemname"]["show"])?
			                    new IMTextField(
                            label: 'Item Name'+((validator.getMap()["itemname"]["validation_rules"]!=null)?" *":""),
                            controller:txtItemname,

                            validator: (text) => widget.validator
                                    .validate(text, "itemname", widget),

                          ):new SizedBox(),

                          (validator.getMap()["serialno"]!=null && validator.getMap()["serialno"]["show"])?
                          new IMTextField(
                            label: 'Serial No'+((validator.getMap()["serialno"]["validation_rules"]!=null)?" *":""),
                            controller:txtSerialno,

                            validator: (text) => widget.validator
                                    .validate(text, "serialno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["model"]!=null && validator.getMap()["model"]["show"])?
                          new IMTextField(
                            label: 'Model'+((validator.getMap()["model"]["validation_rules"]!=null)?" *":""),
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
                            label: 'Value'+((validator.getMap()["value"]["validation_rules"]!=null)?" *":""),
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
                                        if (_formKey.currentState.validate() && widget.validator.validateRadio(_radioPeriod, "period", context)){
                                        Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('policies');
                                      await reference.add({
                                        "name":txtName.text,
                                        "id":txtId.text,
                                        "type":3,
                                        "policyno":txtPolicyno .text,
                                        "proposalno":txtProposalno .text,
                                        "sum":txtSum.text,
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
                                        "value":txtValue.text
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
