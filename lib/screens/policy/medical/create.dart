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
  int _radioCattwolimit = 0;
  int _radioCatthreelimit = 0;
  int _radioCustomertype = 0;
  
  String selectedCategoryCount ="1";

  Validator validator;

  _MedicalState(Validator validator){
    this.validator = validator;
    this.validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }

  String selectedCustomer = null;
  String value;

  final dateFormat = DateFormat("yyyy-MM-dd");

  static DateTime now = DateTime.now();
  String msg = (now.hour < 12) ? "Good Morning!" : "Good Afternoon";

  //  TextEditingController txtName = TextEditingController();
  // TextEditingController txtRegno = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtContactperson = TextEditingController();
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtCatoneindoorlimit = TextEditingController();
  TextEditingController txtCatoneoutdoorlimit = TextEditingController();
  TextEditingController txtCatonename = TextEditingController();
  TextEditingController txtCatoneAddress = TextEditingController();
  TextEditingController txtCatonesocialno = TextEditingController();
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
                          
                          new SizedBox(height: 20.0,),

                          (validator.getMap()["customertype"]["show"])?
                                new Text("Type of Customer"):new SizedBox(),

                                (validator.getMap()["customertype"]["show"])?
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioCustomertype,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioCustomertype = val;
                                          });
                                        },
                                        activeColor: Colors.red,
                                        value: 1,
                                      ),
                                      new Container(
                                        width: 50.0,
                                        child: new Text("Group"),
                                      )
                                    ],)
                                    ,
                                    new Row(children: <Widget>[
                                      new Radio(
                                      groupValue: _radioCustomertype,
                                      onChanged: (val) {
                                        setState(() {
                                          _radioCustomertype = val;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      value: 2,
                                    ),
                                    new Container(
                                        width: 50.0,
                                        child: new Text("Individual"),
                                      )
                                    ],)
                                    
                                  ]):new SizedBox(),

                          new Text("No of Category"),
                          new DropdownButton<String>(
                          items: <String>['1','2', '3', '4']
                          .map((String value) {
                          return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                            );
                          }
                            ).toList(),
                        onChanged: (value){
                          setState(() {
                                        selectedCategoryCount = value;
                                                    });
                        },
                          ),
			                   
                         
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
                            label: 'Contact Number'+((validator.getMap()["number"]["validation_rules"]!="")?" *":""),
                            controller:txtNumber,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "number", widget),

                          ):new SizedBox(),

                          SizedBox(height: 25.0),
                          new Text(
                            "Category 01 - No of Members:",
                            style: TextStyle(
                                      color: Colors.deepOrange[300],
                                      fontSize: 20.0,
                                    ),
                                    

                          ),

                          (validator.getMap()["catonemembers"]!=null && validator.getMap()["catonemembers"]["show"])?
                          new IMTextField(
                            label: 'No of Members',
                            controller:txtCatoneindoorlimit,

                            keyboardType: TextInputType.number,

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

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "catoneindoorlimit", widget),

                          ):new SizedBox(),

                          (validator.getMap()["catoneoutdoorlimit"]!=null && validator.getMap()["catoneoutdoorlimit"]["show"])?
                          new IMTextField(
                            label: 'Outdoor Limit',
                            controller:txtCatoneoutdoorlimit,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "catoneoutdoorlimit", widget),

                          ):new SizedBox(),


                          SizedBox(height: 25.0),
                          new Text(
                            "Member Details",
                            style: TextStyle(
                                      color: Colors.blueGrey[300],
                                      fontSize: 20.0,
                                    ),
                                    

                          ),

                          (validator.getMap()["catonename"]["show"])?
                          new IMTextField(
                            label: 'Name',
                            controller:txtCatonename,

                            validator: (text) => widget.validator
                                    .validate(text, "catonename", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["catoneaddress"]["show"])?
                          new IMTextField(
                            label: 'Address',
                            controller:txtCatoneAddress,

                            validator: (text) => widget.validator
                                    .validate(text, "catoneaddress", widget),

                          ):new SizedBox(),

                          (validator.getMap()["catonesocialno"]["show"])?
                          new IMTextField(
                            label: 'Social Security No',
                            controller:txtCatonesocialno,

                            validator: (text) => widget.validator
                                    .validate(text, "catonesocialno", widget),

                          ):new SizedBox(),

                           new SizedBox(height: 20.0,),

                           (validator.getMap()["catonebday"]["show"])?
			                    new Text("Date of Birth"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  

                        (validator.getMap()["catonebday"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtCatonebday,

                            validator: (text) => widget.validator
                                    .validateDate(text, "catonebday"),

                          format: dateFormat,
                          onChanged: (date) {
                            Scaffold
                                .of(context)
                                .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):new SizedBox(),

                          (validator.getMap()["catonecontact"]["show"])?
                          new IMTextField(
                            label: 'Contact No',
                            controller:txtCatonecontact,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "catonecontact", widget),

                          ):new SizedBox(),


                          SizedBox(height: 25.0),
                          new Text(
                            "Category 02",
                            style: TextStyle(
                                      color: Colors.deepOrange[300],
                                      fontSize: 20.0,
                                    ),
                                    

                          ),

                          (validator.getMap()["cattwomembers"]!=null && validator.getMap()["cattwomembers"]["show"])?
                          new IMTextField(
                            label: 'No of Members',
                            controller:txtCatoneindoorlimit,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "cattwomembers", widget),

                          ):new SizedBox(),

                           new SizedBox(height: 20.0,),

                                (validator.getMap()["cattwolimit"]!=null && validator.getMap()["cattwolimit"]["show"])?
                                new Text("Limit"):new SizedBox(),

                                (validator.getMap()["cattwolimit"]!=null && validator.getMap()["cattwolimit"]["show"])?
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Radio(
                                        groupValue: _radioCattwolimit,
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

                          (validator.getMap()["cattwoindoorlimit"]["show"])?
                          new IMTextField(
                            label: 'Indoor Limit',
                            controller:txtCattwoindoorlimit,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "cattwoindoorlimit", widget),

                          ):new SizedBox(),

                          (validator.getMap()["cattwooutdoorlimit"]["show"])?
                          new IMTextField(
                            label: 'Outdoor Limit',
                            controller:txtCattwooutdoorlimit,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "cattwooutdoorlimit", widget),

                          ):new SizedBox(),

                          SizedBox(height: 25.0),
                          new Text(
                            "Member Details",
                            style: TextStyle(
                                      color: Colors.blueGrey[300],
                                      fontSize: 20.0,
                                    ),
                                    

                          ),
                          
                          (validator.getMap()["cattwomembers"]["show"])?
                          new IMTextField(
                            label: 'No of Members',
                            controller:txtCattwomembers,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "cattwomembers", widget),

                          ):new SizedBox(),

                          (validator.getMap()["cattwoname"]["show"])?
                          new IMTextField(
                            label: 'Name',
                            controller:txtCattwoname,

                            validator: (text) => widget.validator
                                    .validate(text, "cattwoname", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["cattwoaddress"]["show"])?
                          new IMTextField(
                            label: 'Address',
                            controller:txtCattwoAddress,

                            validator: (text) => widget.validator
                                    .validate(text, "cattwoaddress", widget),

                          ):new SizedBox(),

                          (validator.getMap()["cattwosocialno"]["show"])?
                          new IMTextField(
                            label: 'Social Security No',
                            controller:txtCattwono,

                            validator: (text) => widget.validator
                                    .validate(text, "cattwosocialno", widget),

                          ):new SizedBox(),

                           new SizedBox(height: 20.0,),

                           (validator.getMap()["cattwobday"]["show"])?
			                    new Text("Date of Birth"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  

                        (validator.getMap()["cattwobday"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtCattwobday,

                            validator: (text) => widget.validator
                                    .validateDate(text, "cattwobday"),

                          format: dateFormat,
                          onChanged: (date) {
                            Scaffold
                                .of(context)
                                .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):new SizedBox(),

                          (validator.getMap()["cattwocontact"]["show"])?
                          new IMTextField(
                            label: 'Contact No',
                            controller:txtCattwocontact,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "cattwocontact", widget),

                          ):new SizedBox(),

                          SizedBox(height: 25.0),
                          new Text(
                            "Category 03",
                            style: TextStyle(
                                      color: Colors.deepOrange[300],
                                      fontSize: 20.0,
                                    ),
             
                          ),

                          (validator.getMap()["catthreemembers"]!=null && validator.getMap()["catthreemembers"]["show"])?
                          new IMTextField(
                            label: 'No of Members',
                            controller:txtCatthreeindoorlimit,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "catthreemembers", widget),

                          ):new SizedBox(),


                          (validator.getMap()["catthreeindoorlimit"]["show"])?
                          new IMTextField(
                            label: 'Indoor Limit',
                            controller:txtCatthreeindoorlimit,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "catthreeindoorlimit", widget),

                          ):new SizedBox(),

                          (validator.getMap()["catthreeoutdoorlimit"]["show"])?
                          new IMTextField(
                            label: 'Outdoor Limit',
                            controller:txtCatthreeoutdoorlimit,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "catthreeoutdoorlimit", widget),

                          ):new SizedBox(),

                          SizedBox(height: 25.0),
                          new Text(
                            "Member Details",
                            style: TextStyle(
                                      color: Colors.blueGrey[300],
                                      fontSize: 20.0,
                                    ),
                                    

                          ),

                          (validator.getMap()["catthreename"]["show"])?
                          new IMTextField(
                            label: 'Name',
                            controller:txtCatthreename,

                            validator: (text) => widget.validator
                                    .validate(text, "catthreename", widget),

                          ):new SizedBox(),
                          
                          (validator.getMap()["catthreeaddress"]["show"])?
                          new IMTextField(
                            label: 'Address',
                            controller:txtCatthreeAddress,

                            validator: (text) => widget.validator
                                    .validate(text, "catthreeaddress", widget),

                          ):new SizedBox(),

                          (validator.getMap()["catthreesocialno"]["show"])?
                          new IMTextField(
                            label: 'Social Security No',
                            controller:txtCatthreeno,

                            validator: (text) => widget.validator
                                    .validate(text, "catthreesocialno", widget),

                          ):new SizedBox(),

                           new SizedBox(height: 20.0,),

                           (validator.getMap()["catthreebday"]["show"])?
			                    new Text("Date of Birth"):new SizedBox(),
                        //   new IMButton(
                        //         title: "Browse",
                        //         context: context,
                        //         onPressed: () => {},
                        //         type: ButtonTypes.general,
                        //  ),  
                        (validator.getMap()["catthreebday"]["show"])?
                          new DateTimePickerFormField(
                            dateOnly: true,
                            controller: txtCatthreebday,

                            validator: (text) => widget.validator
                                    .validateDate(text, "catthreebday"),

                          format: dateFormat,
                          onChanged: (date) {
                            Scaffold
                                .of(context)
                                .showSnackBar(SnackBar(content: Text('$date')));
                            },
                          ):new SizedBox(),

                          (validator.getMap()["catthreecontact"]["show"])?
                          new IMTextField(
                            label: 'Contact No',
                            controller:txtCatthreecontact,

                            keyboardType: TextInputType.number,

                            validator: (text) => widget.validator
                                    .validate(text, "catthreecontact", widget),

                          ):new SizedBox(),

                          (validator.getMap()["premium"]["show"])?
                          new IMTextField(
                            label: 'Premium',
                            controller:txtPremium,

                            validator: (text) => widget.validator
                                    .validate(text, "premium", widget),

                          ):new SizedBox(),

			                    new SizedBox(height: 20.0,),

                          (validator.getMap()["start"]["show"])?
                                new Text("Start Date"):new SizedBox(),

                                
                          (validator.getMap()["start"]["show"])?
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

                          (validator.getMap()["period"]["show"])?
                                new Text("Period of Policy"):new SizedBox(),

                                (validator.getMap()["period"]["show"])?
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

                                (validator.getMap()["renewal"]["show"])?
                                new Text("Renewal Date"):new SizedBox(),

                                (validator.getMap()["renewal"]["show"])?
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
                                         && widget.validator.validateRadio(_radioCattwolimit, "cattwolimit", context)
                                         && widget.validator.validateRadio(_radioCatthreelimit, "catthreelimit", context)
                                         && widget.validator.validateRadio(_radioPeriod, "period", context)
                                         && widget.validator.validateRadio(_radioCustomertype, "customertype", context)
                                         ){
                                        Firestore.instance.runTransaction((Transaction transaction) async{
                                      CollectionReference reference = Firestore.instance.collection('motor');
                                      await reference.add({
                                        "type":6,
                                        "customertype":_radioCustomertype,
                                        "name":selectedCustomer.split(" - ")[1],
                                        "id":selectedCustomer.split(" - ")[0],
                                        "address":txtAddress.text,
                                        "contactperson":txtContactperson.text,
                                        "number":txtNumber.text,
                                        "catonemembers":txtCatonemembers.text,
                                        "catonelimit":_radioLimit,
                                        "catoneindoorlimit":txtCatoneindoorlimit.text,
                                        "catoneoutdoorlimit":txtCatoneoutdoorlimit.text,
                                        "catonename":txtCatonename.text,
                                        "catoneaddress":txtCatoneAddress.text,
                                        "catonesocialno":txtCatonesocialno.text,
                                        "catonebday":txtCatonebday.text,
                                        "catonecontact":txtCatonecontact.text,
                                        "cattwomembers":txtCatonemembers.text,
                                        "cattwolimit":_radioCattwolimit,
                                        "cattwoindoorlimit":txtCattwoindoorlimit.text,
                                        "cattwooutdoorlimit":txtCattwooutdoorlimit.text,
                                        "cattwoname":txtCattwoname.text,
                                        "cattwoaddress":txtCattwoAddress.text,
                                        "cattwosocialno":txtCattwono.text,
                                        "cattwobday":txtCattwobday.text,
                                        "cattwocontact":txtCattwocontact.text,
                                        "catthreemembers":txtCatthreemembers.text,
                                        "catthreelimit":_radioCatthreelimit,
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
                                        "renewal":txtRenewal.text,
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
