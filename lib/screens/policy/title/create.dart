import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/IM.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../../components/controls/Validator.dart';
import '../../../screens/user/auth.dart';

class TitleCreate extends StatefulWidget {
  Validator validator;
  String uid;

  TitleCreate(){
     new Auth().currentUser().then((userId) {
      uid = userId;
            
    });
    validator = new Validator("policies");
  }

  @override
  _TitlesState createState() => new _TitlesState(validator);

}


class _TitlesState extends State<TitleCreate> {
  final _formKey = GlobalKey<FormState>();

  Validator validator;

  _TitlesState(Validator validator){
    this.validator = validator;
    this.validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }
  
  static DateTime now = DateTime.now();

  int _radioPeriod = 0;

  final dateFormat = DateFormat("yyyy-MM-dd");
  


  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";
  TextEditingController txtName = TextEditingController();
  TextEditingController txtId = TextEditingController();
  TextEditingController txtInstitution = TextEditingController();
  TextEditingController txtInstitutionaddress = TextEditingController();
  TextEditingController txtLoanno = TextEditingController();
  TextEditingController txtLoanvalue = TextEditingController();
  TextEditingController txtEpfno = TextEditingController();
  TextEditingController txtProposalno = TextEditingController();
  TextEditingController txtPolicyno = TextEditingController();
  TextEditingController txtPremium = TextEditingController();
  TextEditingController txtStart = TextEditingController();
  TextEditingController txtEnd = TextEditingController();
  TextEditingController txtLandname = TextEditingController();
  TextEditingController txtLocation = TextEditingController();
  TextEditingController txtExtent = TextEditingController();
  TextEditingController txtLotno = TextEditingController();
  TextEditingController txtPlanno = TextEditingController();
  TextEditingController txtDate = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW TITLE INSURANCE POLICY",
          context: context,
        ),
        //Content of tabs
        body:
        
         new SingleChildScrollView ( 
          child:   new Form(
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

                          (validator.getMap()["institution"]!=null && validator.getMap()["institution"]["show"])?
                          new IMTextField(
                            label: 'Name of the Lending Institution'+((validator.getMap()["institution"]["validation_rules"]!=null)?" *":""),
                            controller:txtInstitution,

                            validator: (text) => widget.validator
                                    .validate(text, "institution", widget),

                          ):new SizedBox(),

                          (validator.getMap()["institutionaddress"]!=null && validator.getMap()["institutionaddress"]["show"])?
                          new IMTextField(
                            label: 'Address of the Lending Institution'+((validator.getMap()["institutionaddress"]["validation_rules"]!=null)?" *":""),
                            controller:txtInstitutionaddress,

                            validator: (text) => widget.validator
                                    .validate(text, "institutionaddress", widget),

                            
                          ):new SizedBox(),

                          (validator.getMap()["loanno"]!=null && validator.getMap()["loanno"]["show"])?
                          new IMTextField(
                            label: 'Loan Number'+((validator.getMap()["loanno"]["validation_rules"]!=null)?" *":""),
                            controller:txtLoanno,

                            validator: (text) => widget.validator
                                    .validate(text, "loanno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["loanvalue"]!=null && validator.getMap()["loanvalue"]["show"])?
                          new IMTextField(
                            label: 'Loan Value - Sum Insured'+((validator.getMap()["loanvalue"]["validation_rules"]!=null)?" *":""),
                            controller:txtLoanvalue,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "loanvalue", widget),
                            
                          ):new SizedBox(),

                          (validator.getMap()["epfno"]!=null && validator.getMap()["epfno"]["show"])?
                          new IMTextField(
                            label: 'EPF No'+((validator.getMap()["epfno"]["validation_rules"]!=null)?" *":""),
                            controller:txtEpfno,

                            validator: (text) => widget.validator
                                    .validate(text, "epfno", widget),
                            
                          ):new SizedBox(),

                          (validator.getMap()["proposalno"]!=null && validator.getMap()["proposalno"]["show"])?
                          new IMTextField(
                            label: 'Proposal No'+((validator.getMap()["proposalno"]["validation_rules"]!=null)?" *":""),
                            controller:txtProposalno,

                            validator: (text) => widget.validator
                                    .validate(text, "proposalno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["policyno"]!=null && validator.getMap()["policyno"]["show"])?
                          new IMTextField(
                            label: 'Policy No'+((validator.getMap()["policyno"]["validation_rules"]!=null)?" *":""),
                            controller:txtPolicyno,

                            validator: (text) => widget.validator
                                    .validate(text, "policyno", widget),
                            
                          ):new SizedBox(),

                          (validator.getMap()["premium"]!=null && validator.getMap()["premium"]["show"])?
                          new IMTextField(
                            label: 'Premium'+((validator.getMap()["premium"]["validation_rules"]!=null)?" *":""),
                            controller:txtPremium,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "premium", widget),
                            
                          ):new SizedBox(),

                          new SizedBox(height: 20.0,),

			                    (validator.getMap()["start"]!=null && validator.getMap()["start"]["show"])?
                          new Text("Start Date"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ), 

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
                                    
                                  ]):new SizedBox(),

			                    new SizedBox(height: 20.0,),

                          (validator.getMap()["end"]!=null && validator.getMap()["end"]["show"])?
			                    new Text("End Date"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  

                          (validator.getMap()["end"]!=null && validator.getMap()["end"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtEnd,

                            validator: (text) => widget.validator
                                    .validateDate(text, "end"),

                            format: dateFormat,
                            onChanged: (date) {
                              Scaffold
                                  .of(context)
                                  .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):new SizedBox(),

                          (validator.getMap()["landname"]!=null && validator.getMap()["landname"]["show"])?
                          new IMTextField(
                            label: 'Name of the Land'+((validator.getMap()["landname"]["validation_rules"]!=null)?" *":""),
                            controller:txtLandname,

                            validator: (text) => widget.validator
                                    .validate(text, "landname", widget),
                            
                          ):new SizedBox(),

                           (validator.getMap()["location"]!=null && validator.getMap()["location"]["show"])?
                          new IMTextField(
                            label: 'Location'+((validator.getMap()["location"]["validation_rules"]!=null)?" *":""),
                            controller:txtLocation,

                            validator: (text) => widget.validator
                                    .validate(text, "location", widget),
                            
                          ):new SizedBox(),

                          (validator.getMap()["extent"]!=null && validator.getMap()["extent"]["show"])?
                          new IMTextField(
                            label: 'Extent'+((validator.getMap()["extent"]["validation_rules"]!=null)?" *":""),
                            controller:txtExtent,

                            validator: (text) => widget.validator
                                    .validate(text, "extent", widget),
                            
                          ):new SizedBox(),

                          (validator.getMap()["lotno"]!=null && validator.getMap()["lotno"]["show"])?
                          new IMTextField(
                            label: 'Lot No'+((validator.getMap()["lotno"]["validation_rules"]!=null)?" *":""),
                            controller:txtLotno,

                            validator: (text) => widget.validator
                                    .validate(text, "lotno", widget),
                            
                          ):new SizedBox(),

                          (validator.getMap()["planno"]!=null && validator.getMap()["planno"]["show"])?
                          new IMTextField(
                            label: 'Plan No'+((validator.getMap()["planno"]["validation_rules"]!=null)?" *":""),
                            controller:txtPlanno,

                            validator: (text) => widget.validator
                                    .validate(text, "planno", widget),
                            
                          ):new SizedBox(),

                          new SizedBox(height: 20.0,),

			                    (validator.getMap()["date"]!=null && validator.getMap()["date"]["show"])?
                          new Text("Date"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ), 

                        (validator.getMap()["date"]!=null && validator.getMap()["date"]["show"])? 
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtDate,

                            validator: (text) => widget.validator
                                    .validateDate(text, "date"),

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
                                      CollectionReference reference = Firestore.instance.collection('customers');
                                      await reference.add({
                                        "name":txtName.text,
                                        "id":txtId.text,
                                        "type":5,
                                        "institution":txtInstitution.text,
                                        "institutionaddress":txtInstitutionaddress,
                                        "loanno":txtLoanno.text,
                                        "loanvalue":txtLoanvalue.text,
                                        "epfno":txtEpfno.text,
                                        "proposalno":txtProposalno.text,
                                        "policyno":txtPolicyno.text,
                                        "premium":txtPremium.text,
                                        "start":txtStart.text,
                                        "period":_radioPeriod,
                                        "end":txtEnd.text,
                                        "landname":txtLandname .text,
                                        "location":txtLocation .text,
                                        "extent":txtExtent.text,
                                        "lotno":txtLotno.text,
                                        "planno":txtPlanno.text,
                                        "date":txtDate.text
                                        });
                                      
                                    });

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
        
      ) ;



      


}
