import 'package:flutter/material.dart';
import '../../../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../screens/user/auth.dart';

class PolicyMotorView extends StatefulWidget {
  DocumentSnapshot document;
  String companyName = "-";
  String countryName = "-";

  PolicyMotorView(doc) {
    this.document = doc;
  }
  @override
  _PolicyMotorViewState createState() => new _PolicyMotorViewState();
}

class _PolicyMotorViewState extends State<PolicyMotorView> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (widget.companyName == "-") {
    //                     DocumentReference postRef = Firestore.instance
    //                         .collection('companies')
    //                         .document(widget.document["company"]);
    //                     postRef.get().then((string) {
    //                       setState(() {
    //                         widget.companyName = string["name"];
    //                       });
    //                     });
    //                   }

    //                   if (widget.countryName == "-") {
    //                     DocumentReference postRef = Firestore.instance
    //                         .collection('countries')
    //                         .document(widget.document["country"]);
    //                     postRef.get().then((string) {
    //                       setState(() {
    //                         widget.countryName = string["name"];
    //                       });
    //                     });
    //                   }
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        //App Bar
        appBar: new IMAppBar(
          title: "POLICY VIEW",
          context: context,
        ),

        //Content of tabs
        body: new Stack(
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
              child:Column(
                        children: <Widget>[
                          Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.atlassian.com/dam/jcr:13a574c1-390b-4bfb-956b-6b6d114bf98c/max-rehkopf.png'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 7.0, color: Colors.black)
                                ]),
                          ),
                          SizedBox(height: 35.0),
                          Text(
                            widget.document["name"] ,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            widget.document["policyname"],
                            style: TextStyle(
                              fontSize: 17.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 40.0,
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 10.0),
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
                                    widget.document["policyno"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                  child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.only(
                                          top: 15.0, left: 10.0),
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
                                        widget.document["commenceddate"],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17.0,
                                        ),
                                      ))),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 40.0,
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
                                    widget.document["proposalno"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                height: 40.0,
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
                                  widget.document["premium"],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17.0,
                                  ),
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
                                      fontSize: 17.0,
                                    ),
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
                                    fontSize: 17.0,
                                  ),
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
                                    widget.document["paid"].toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17.0,
                                    ),
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
                                  widget.document["due"],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17.0,
                                  ),
                                ),
                              )),
                            ],
                          ),
                          SizedBox(height: 25.0),
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
                                    'Edit Policy',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                    )
                
                    
            )
          ],
        ),
                
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
