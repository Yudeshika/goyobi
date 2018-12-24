import 'package:flutter/material.dart';
import '../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/user/auth.dart';
import '../components/controls/Validator.dart';

class Profile extends StatefulWidget {

  Validator validator;
  

  String uid;
  String companyName = "-";
  String countryName = "-";

  Profile() {
    new Auth().currentUser().then((userId) {
      uid = userId;
    });
    validator = new Validator("members");
  }
  @override
  _ProfileState createState() => new _ProfileState(validator);
}

class _ProfileState extends State<Profile> {

  bool edit = false;
  Validator validator;
  String selectedCompany = "NnWDUmxOgdVufdFZRkF2";
  String selectedCountry = "07N24di7RbK1g4tpMwNw";

  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtNic = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtHomePhone = TextEditingController(); 
  TextEditingController txtOfficePhone = TextEditingController();

  _ProfileState(Validator validator){
    this.validator = validator;
    validator.loadMap(mapUpdated);
  }

  mapUpdated(){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        //App Bar
        appBar: new IMAppBar(
          title: "MY PROFILE",
          context: context,
        ),

        //Content of tabs
        body:new SingleChildScrollView(
          child: 
          new Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
          child:new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                color: Colors.black.withOpacity(0.8),
              ),
              clipper: getClipper(),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height / 10,
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('members')
                      .where("uid", isEqualTo: widget.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');

                    return Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {


                      if (widget.companyName == "-") {
                        DocumentReference postRef = Firestore.instance
                            .collection('companies')
                            .document(document["company"]);
                        postRef.get().then((string) {
                          setState(() {
                            widget.companyName = string["name"];
                          });
                        });
                      }

                      if (widget.countryName == "-") {
                        DocumentReference postRef = Firestore.instance
                            .collection('countries')
                            .document(document["country"]);
                        postRef.get().then((string) {
                          setState(() {
                            widget.countryName = string["name"];
                          });
                        });
                      }

                      

                      return 
                      new Container(
                        padding: EdgeInsets.only(left:(edit)?10.0:0.0, right:(edit)?10.0:0.0),
                        child: new Column(

                        children: <Widget>[
                          Container( 
                            
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.goldenglobes.com/sites/default/files/styles/portrait_medium/public/gallery_images/17-tomcruiseag.jpg?itok=qNj0cQGV&c=c9a73b7bdf609d72214d226ab9ea015e'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 7.0, color: Colors.black)
                                ]),
                          ),
                          SizedBox(height: 35.0),
                          (edit)?
                          new Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              (validator.getMap()["first_name"]!=null && validator.getMap()["first_name"]["show"])?
                                new Container(
                                  width: (MediaQuery.of(context).size.width/2)-20,
                                  //height: 45.0,
                                  child: new IMTextField(
                                  
                                label: 'First Name'+((validator.getMap()["first_name"]["validation_rules"]!="")?" *":""),
                                controller: txtFirstName,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "first_name", widget),
                              ),
                                ):new SizedBox(),
                              (validator.getMap()["last_name"]!=null && validator.getMap()["last_name"]["show"])?
                                new Container(
                                  width: (MediaQuery.of(context).size.width/2)-10.0,
                                  //height: 45.0,
                                  child:new IMTextField(
                                label: 'Last Name'+((validator.getMap()["last_name"]["validation_rules"]!="")?" *":""),
                                controller: txtLastName,

                                validator: (text) => widget.validator
                                    .validate(text, "last_name", widget),
                              )
                                ):new SizedBox(),
                            ],
                          )
                          :
                          Text(
                            document["first_name"] +
                                " " +
                                document["last_name"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor:2.0
                          ),
                          SizedBox(height: 15.0),
                          (edit)?
                          new Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              (validator.getMap()["email"]!=null && validator.getMap()["email"]["show"])?
                                new Container(
                                  width: MediaQuery.of(context).size.width-20.0,
                                  //height: 50.0,
                                  child: new IMTextField(
                                  
                                label: 'Email'+((validator.getMap()["email"]["validation_rules"]!="")?" *":""),
                                controller: txtEmail,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "email", widget),
                              ),
                                ):new SizedBox(),
                              
                            ],
                          )
                          :
                          Text(
                            document["email"],
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textScaleFactor:1.5
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: (edit)?
                          
                              (validator.getMap()["nic"]!=null && validator.getMap()["nic"]["show"])?
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  //height: 30.0,
                                  child: new IMTextField(
                                  
                                label: 'NIC '+((validator.getMap()["nic"]["validation_rules"]!="")?" *":""),
                                controller: txtNic,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "nic", widget),
                              )
                                ):new SizedBox()
                          
                          :
                          Container(
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 15.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3.0, color: Colors.grey)
                                      ]),
                                      child:Text(
                            document["nic"],
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            textScaleFactor:1.1
                          )
                                  
                                ),
                              ),
                              Expanded(
                                  child: (edit)?
                          
                              (validator.getMap()["company"]!=null && validator.getMap()["company"]["show"])?
                                StreamBuilder(
                                stream: Firestore.instance
                                    .collection("companies")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('Loading...');
                                  return new Container(
                                  width: (MediaQuery.of(context).size.width/2)-40.0,
                                  margin:
                                      EdgeInsets.only(top: 35.0, left: 5.0),
                                  //height: 30.0,
                                  child: Container(
    width: 100.0,
    child: DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: false,
        child: 

        new Column(
          children: <Widget>[
            new Text("Company "+((validator.getMap()["company"]["validation_rules"]!="")?" *":"")),
            new DropdownButton(
                                      elevation: 0,
                                      
                                      value: selectedCompany,
                                      items: snapshot.data.documents
                                          .map((DocumentSnapshot document) {
                                        String name = document["name"];
                                        // if(name.toLowerCase().contains(filter.toLowerCase())){
                                        return DropdownMenuItem(
                                            value: document.documentID,
                                            child: Row(
                                              children: <Widget>[
                                                new Icon(Icons.business),
                                                new SizedBox(width: 5.0),
                                                new Text(name)
                                              ],
                                            ));
                                        // }
                                      }).toList(),
                                      onChanged: (value) {
                                        print(value);
                                        selectedCompany = value;
                                        setState(() {});
                                      })
          ],
        )
      )
    )
                                  )
                                      );
                                },
                              )
                                :new SizedBox()
                          
                          :Container( 
                                      margin: EdgeInsets.only(
                                          top: 15.0, left: 15.0, right: 15.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 3.0,
                                                color: Colors.grey)
                                          ]),
                                      child: Text(
                                        (widget.companyName.length>18)?widget.companyName.substring(0,17)+"..":widget.companyName,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        textScaleFactor: 1.1,
                                      ))),
                            ],
                          ),
                          Row(

                            children: <Widget>[
                              Expanded(
                                child:(edit)?
                          
                              (validator.getMap()["mobile_no"]!=null && validator.getMap()["mobile_no"]["show"])?
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  //height: 30.0,
                                  child: new IMTextField(
                                  
                                label: 'Mobile '+((validator.getMap()["mobile_no"]["validation_rules"]!="")?" *":""),
                                controller: txtMobile,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "mobile_no", widget),
                              )
                                ):new SizedBox()
                          
                          : Container(
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 15.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3.0, color: Colors.grey)
                                      ]),
                                  child: Text(
                                    document["mobile_no"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    textScaleFactor: 1.1,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child:(edit)?
                          
                              (validator.getMap()["home_tp"]!=null && validator.getMap()["home_tp"]["show"])?
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  //height: 30.0,
                                  child: new IMTextField(
                                  
                                label: 'Home '+((validator.getMap()["home_tp"]["validation_rules"]!="")?" *":""),
                                controller: txtHomePhone,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "home_tp", widget),
                              )
                                ):new SizedBox()
                          
                          :  Container(
                                margin: EdgeInsets.only(
                                    top: 15.0, left: 15.0, right: 15.0),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3.0, color: Colors.grey)
                                    ]),
                                child: Text(
                                  document["home_tp"],
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  textScaleFactor: 1.1,
                                ),
                              )),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: (edit)?
                          
                              (validator.getMap()["country"]!=null && validator.getMap()["country"]["show"])?
                                StreamBuilder(
                                stream: Firestore.instance
                                    .collection("countries")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return new Text('Loading...');
                                  return new Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      EdgeInsets.only(top: 30.0, left: 0.0),
                                  //height: 30.0,
                                  child:  new DropdownButton(
                                      elevation: 0,

                                      value: selectedCountry,
                                      items: snapshot.data.documents
                                          .map((DocumentSnapshot document) {
                                        String name = document["name"];
                                        // if(name.toLowerCase().contains(filter.toLowerCase())){
                                        return DropdownMenuItem(
                                            value: document.documentID,
                                            child: Row(
                                              children: <Widget>[
                                                new Icon(Icons.business),
                                                new SizedBox(width: 5.0),
                                                new Text(name)
                                              ],
                                            ));
                                        // }
                                      }).toList(),
                                      onChanged: (value) {
                                        print(value);
                                        selectedCountry = value;
                                        setState(() {});
                                      })
                                      );
                                },
                              )
                                :new SizedBox()
                          
                          : Container(
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 15.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3.0, color: Colors.grey)
                                      ]),
                                  child: Text(
                                    widget.countryName,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    textScaleFactor: 1.1,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: (edit)?
                          
                              (validator.getMap()["office_tp"]!=null && validator.getMap()["office_tp"]["show"])?
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  //height: 30.0,
                                  child: new IMTextField(
                                  
                                label: 'Office '+((validator.getMap()["office_tp"]["validation_rules"]!="")?" *":""),
                                controller: txtOfficePhone,
                                
                                validator: (text) => widget.validator
                                    .validate(text, "office_tp", widget),
                              )
                                ):new SizedBox()
                          
                          :  Container(
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 15.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3.0, color: Colors.grey)
                                      ]),
                                  child: Text(
                                    'Office - '+document["office_tp"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    textScaleFactor: 1.1,
                                  ),
                                ),
                              )
                            ],
                          ),
                          
                          SizedBox(height: 20.0),
                          Container(
                            //height: 35.0,
                            width: 105.0,
                            child: Material(
                              // borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {
                                  if(edit){
                                    Firestore.instance.runTransaction((transaction) async {
                                      await transaction.update( Firestore.instance.collection('members')
                                      .document(document.documentID),
                                       {
                                         "first_name":txtFirstName.text,
                                         "last_name":txtLastName.text,
                                         "email":txtEmail.text,
                                         "nic":txtNic.text,
                                         "mobile_no":txtMobile.text,
                                         "home_tp":txtHomePhone.text,
                                         "office_tp":txtOfficePhone.text,
                                         "company":selectedCompany,
                                         "country":selectedCountry,
                                       }
                                      );
                                      edit = false;
                                      setState(() {});
                                    });
                                  }else{
                                    setState(() {
                                    txtFirstName.value = new TextEditingValue(text:document["first_name"]);
                                    txtLastName.value = new TextEditingValue(text:document["last_name"]);
                                    txtEmail.value = new TextEditingValue(text:document["email"]);
                                    txtNic.value = new TextEditingValue(text:document["nic"]);
                                    txtMobile.value = new TextEditingValue(text:document["mobile_no"]);
                                    txtHomePhone.value = new TextEditingValue(text:document["home_tp"]);
                                    txtOfficePhone.value = new TextEditingValue(text:document["office_tp"]);
                                    selectedCompany = document["company"];
                                    selectedCountry = document["country"];
                                    edit = true;
                                    });
                                  }
                                  
                                },
                                child: Center(
                                  child: Text(
                                    (edit)?'UPDATE':'Edit Profile',
                                    style: TextStyle(
                                        color: Colors.white),
                                        textScaleFactor: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      );
                    }).toList());
                  }),
            )
          ],
        ),
          ),
        )
      );
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3);
    path.lineTo(size.width + 150, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
