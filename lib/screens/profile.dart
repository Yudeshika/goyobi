import 'package:flutter/material.dart';
import '../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/user/auth.dart';

class Profile extends StatefulWidget {
  String uid;
  String companyName = "-";
  String countryName = "-";

  Profile() {
    new Auth().currentUser().then((userId) {
      uid = userId;
    });
  }
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              top: MediaQuery.of(context).size.height / 7,
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

                      

                      return new Column(
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
                          Text(
                            document["email"],
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textScaleFactor:1.0
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
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
                                    document["nic"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    textScaleFactor:1.1
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container( 
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
                                child: Container(
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
                                  child: Container(
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
                                child: Container(
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
                                  child: Container(
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
                                  'LKR',
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
                                child: Container(
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
                              ),
                              Expanded(
                                  child: Container(
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
                                  document["mobile_no"],
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  textScaleFactor: 1.1,
                                ),
                              )),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            height: 35.0,
                            width: 105.0,
                            child: Material(
                              // borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                        color: Colors.white),
                                        textScaleFactor: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

    path.lineTo(0.0, size.height / 2.2);
    path.lineTo(size.width + 160, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
