import 'package:flutter/material.dart';
import '../../../components/IM.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../../components/controls/Validator.dart';
import '../../../screens/user/auth.dart';

class MedicalCreate extends StatefulWidget {
  Validator validator;
  String uid;

  MedicalCreate(){
     new Auth().currentUser().then((userId) {
      uid = userId;
            
    });
    validator = new Validator("policies");
  }

  @override
  _MedicalState createState() => new _MedicalState(validator);

}
class _MedicalState extends State<MedicalCreate> {
  final _formKey = GlobalKey<FormState>();

  int _radioPeriod = 0;
  int _radioLimit = 0;

  Validator validator;

  _MedicalState(Validator validator){
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
  TextEditingController txtRegno = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtContactperson = TextEditingController();
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtCatoneindoorlimit = TextEditingController();
  TextEditingController txtCatoneoutdoorlimit = TextEditingController();
  TextEditingController txtCatonename = TextEditingController();
  TextEditingController txtCatoneAddress = TextEditingController();
  TextEditingController txtCatoneno = TextEditingController();
  TextEditingController txtCatonemembers = TextEditingController();
  TextEditingController txtCatonebday = TextEditingController();
  TextEditingController txtCatonecontact = TextEditingController();
  TextEditingController txtCattwoindoorlimit = TextEditingController();
  TextEditingController txtCattwooutdoorlimit = TextEditingController();
  TextEditingController txtCattwoname = TextEditingController();
  TextEditingController txtCattwoAddress = TextEditingController();
  TextEditingController txtCattwono = TextEditingController();
  TextEditingController txtCattwomembers = TextEditingController();
  TextEditingController txtCattwobday = TextEditingController();
  TextEditingController txtCattwocontact = TextEditingController();
  TextEditingController txtCatthreeindoorlimit = TextEditingController();
  TextEditingController txtCatthreeoutdoorlimit = TextEditingController();
  TextEditingController txtCatthreename = TextEditingController();
  TextEditingController txtCatthreeAddress = TextEditingController();
  TextEditingController txtCatthreeno = TextEditingController();
  TextEditingController txtCatthreemembers = TextEditingController();
  TextEditingController txtCatthreebday = TextEditingController();
  TextEditingController txtCatthreecontact = TextEditingController();
  TextEditingController txtPremium = TextEditingController();
  TextEditingController txtStart = TextEditingController();
  TextEditingController txtRenewal = TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: "NEW MEDICAL POLICY",
          context: context,
        ),

        //Content of tabs
        body: new SingleChildScrollView(
          child:   new Form(
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
                          
                          
                          new IMDropdownButton(
                            items:<DropdownMenuItem>[
                              DropdownMenuItem(child: Text("Type of Customer"),)
                            ]
                          ),

			                   
                          new IMDropdownButton(
                            items:<DropdownMenuItem>[
                              DropdownMenuItem(child: Text("No of Category"),)
                            ]
                          ),	

                          (validator.getMap()["name"]!=null && validator.getMap()["name"]["show"])?		
                          new IMTextField(
                            label: 'Customer Name',
                            controller:txtName,
                            
                            validator: (text) => widget.validator
                                    .validate(text, "name", widget),

                          ):new SizedBox(),

                          (validator.getMap()["regno"]!=null && validator.getMap()["regno"]["show"])?
                          new IMTextField(
                            label: 'Social Security No / BR. No.',
                            controller:txtRegno,

                            validator: (text) => widget.validator
                                    .validate(text, "regno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["address"]!=null && validator.getMap()["address"]["show"])?
                          new IMTextField(
                            label: 'Address',
                            controller:txtAddress,

                            validator: (text) => widget.validator
                                    .validate(text, "address", widget),

                          ):new SizedBox(),

                          (validator.getMap()["contactperson"]!=null && validator.getMap()["contactperson"]["show"])?
			                    new IMTextField(
                            label: 'Contact Person',
                            controller:txtContactperson,

                            validator: (text) => widget.validator
                                    .validate(text, "contactperson", widget),

                          ):new SizedBox(),

                          (validator.getMap()["number"]!=null && validator.getMap()["number"]["show"])?
			                    new IMTextField(
                            label: 'Contact No',
                            controller:txtNumber,

                            validator: (text) => widget.validator
                                    .validate(text, "number", widget),

                          ):new SizedBox(),

                          (validator.getMap()["catonemembers"]!=null && validator.getMap()["catonemembers"]["show"])?
			                    new IMTextField(
                            label: 'Category 01 - No of Members',
                            controller:txtCatoneno,

                            validator: (text) => widget.validator
                                    .validate(text, "catonemembers", widget),

                          ):new SizedBox(),

                         new SizedBox(height: 20.0,),

                                (validator.getMap()["catonelimit"]!=null && validator.getMap()["catonelimit"]["show"])?
                                new Text("Limit"):new SizedBox(),

                                (validator.getMap()["catonelimit"]!=null && validator.getMap()["catonelimit"]["show"])?
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioLimit,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioLimit = val;
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
                                      groupValue: _radioLimit,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioLimit = val;
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


                          (validator.getMap()["catoneindoorlimit"]!=null && validator.getMap()["catoneindoorlimit"]["show"])?
                          new IMTextField(
                            label: 'Indoor Limit',
                            controller:txtCatoneindoorlimit,

                            validator: (text) => widget.validator
                                    .validate(text, "catoneindoorlimit", widget),

                          ):new SizedBox(),

                          (validator.getMap()["catoneoutdoorlimit"]!=null && validator.getMap()["catoneoutdoorlimit"]["show"])?
                          new IMTextField(
                            label: 'Outdoor Limit',
                            controller:txtCatoneoutdoorlimit,

                            validator: (text) => widget.validator
                                    .validate(text, "catoneoutdoorlimit", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Member Details',
                            controller:txtCatonemembers,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Name',
                            controller:txtCatonename,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Address',
                            controller:txtCatoneAddress,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Social Security No',
                            controller:txtCatoneno,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                           new SizedBox(height: 20.0,),

                           (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
			                    new Text("Date of Birth"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  

                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtCatonebday,

                            validator: (text) => widget.validator
                                    .validateDate(text, "vehicleno"),

                          format: dateFormat,
                          onChanged: (date) {
                            Scaffold
                                .of(context)
                                .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Contact No',
                            controller:txtCatonecontact,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Category 02 - No of Members',
                            controller:txtCattwono,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]!=null && validator.getMap()["vehicleno"]["show"])?
                          new IMDropdownButton(
                            items:<DropdownMenuItem>[
                              DropdownMenuItem(child: Text("Limit"),)
                            ]
                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Indoor Limit',
                            controller:txtCattwoindoorlimit,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Outdoor Limit',
                            controller:txtCattwooutdoorlimit,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Member Details',
                            controller:txtCattwomembers,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Name',
                            controller:txtCattwoname,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Address',
                            controller:txtCattwoAddress,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Social Security No',
                            controller:txtCattwono,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                           new SizedBox(height: 20.0,),

                           (validator.getMap()["vehicleno"]["show"])?
			                    new Text("Date of Birth"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  

                        (validator.getMap()["vehicleno"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtCattwobday,

                            validator: (text) => widget.validator
                                    .validateDate(text, "vehicleno"),

                          format: dateFormat,
                          onChanged: (date) {
                            Scaffold
                                .of(context)
                                .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Contact No',
                            controller:txtCattwocontact,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Category 03 - No of Members',
                            controller:txtCatthreeno,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMDropdownButton(
                            items:<DropdownMenuItem>[
                              DropdownMenuItem(child: Text("Limit"),)
                            ]
                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Indoor Limit',
                            controller:txtCatthreeindoorlimit,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Outdoor Limit',
                            controller:txtCatthreeoutdoorlimit,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Member Details',
                            controller:txtCatthreemembers,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Name',
                            controller:txtCatthreename,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Address',
                            controller:txtCatthreeAddress,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Social Security No',
                            controller:txtCatthreeno,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                           new SizedBox(height: 20.0,),

                           (validator.getMap()["vehicleno"]["show"])?
			                    new Text("Date of Birth"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  
                        (validator.getMap()["vehicleno"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtCatthreebday,

                            validator: (text) => widget.validator
                                    .validateDate(text, "vehicleno"),

                          format: dateFormat,
                          onChanged: (date) {
                            Scaffold
                                .of(context)
                                .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Contact No',
                            controller:txtCatthreecontact,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

                          (validator.getMap()["vehicleno"]["show"])?
                          new IMTextField(
                            label: 'Premium',
                            controller:txtPremium,

                            validator: (text) => widget.validator
                                    .validate(text, "vehicleno", widget),

                          ):new SizedBox(),

			                    new SizedBox(height: 20.0,),

                          (validator.getMap()["vehicleno"]["show"])?
                                new Text("Start Date"):new SizedBox(),

                                
                          (validator.getMap()["vehicleno"]["show"])?
                                 new DateTimePickerFormField(
                                dateOnly: true,
                                controller: txtStart,

                                validator: (text) => widget.validator
                                    .validateDate(text, "vehicleno"),

                                format: dateFormat,
                                onChanged: (date) {
                                  Scaffold
                                      .of(context)
                                      .showSnackBar(SnackBar(content: Text('$date')));
                                },
                                ):new SizedBox(),

                          new SizedBox(height: 20.0,),

                          (validator.getMap()["vehicleno"]["show"])?
                                new Text("Period of Policy"):new SizedBox(),

                                (validator.getMap()["vehicleno"]["show"])?
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

                                (validator.getMap()["vehicleno"]["show"])?
                                new Text("Renewal Date"):new SizedBox(),

                                (validator.getMap()["vehicleno"]["show"])?
                                 new DateTimePickerFormField(
                                dateOnly: true,
                                controller: txtRenewal,

                                validator: (text) => widget.validator
                                    .validateDate(text, "vehicleno"),

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
                                        if (_formKey.currentState.validate()
                                         && widget.validator.validateRadio(_radioLimit, "catonelimit", context)
                                         && widget.validator.validateRadio(_radioPeriod, "period", context)
                                         ){
                                        Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('motor');
                                      await reference.add({
                                        "type":6,
                                        "name":txtName.text,
                                        "regno":txtRegno.text,
                                        "address":txtAddress.text,
                                        "contactperson":txtContactperson.text,
                                        "number":txtNumber.text,
                                        "catonemembers":txtCatonemembers.text,
                                        "catonelimit":_radioLimit,
                                        "catoneindoorlimit":txtCatoneindoorlimit.text,
                                        "catoneoutdoorlimit":txtCatoneoutdoorlimit.text,
                                        "catonename":txtCatonename.text,
                                        "catoneaddress":txtCatoneAddress.text,
                                        "catonesocialno":txtCatoneno.text,
                                        "catonebday":txtCatonebday.text,
                                        "catonecontact":txtCatonecontact.text,
                                        "cattwoindoorlimit":txtCattwoindoorlimit.text,
                                        "cattwooutdoorlimit":txtCattwooutdoorlimit.text,
                                        "cattwoname":txtCattwoname.text,
                                        "cattwoaddress":txtCattwoAddress.text,
                                        "cattwosocialno":txtCattwono.text,
                                        "cattwobday":txtCattwobday.text,
                                        "cattwocontact":txtCattwocontact.text,
                                        "catthreeindoorlimit":txtCatthreeindoorlimit.text,
                                        "catthreeoutdoorlimit":txtCatthreeoutdoorlimit.text,
                                        "catthreename":txtCatthreename.text,
                                        "catthreeaddress":txtCatthreeAddress.text,
                                        "catthreesocialno":txtCatthreeno.text,
                                        "catthreebday":txtCatthreebday.text,
                                        "catthreecontact":txtCatthreecontact.text,
                                        "premium":txtPremium.text,
                                        "start":txtStart.text,
                                        "period":_radioPeriod,
                                        "renewal":txtRenewal.text
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
