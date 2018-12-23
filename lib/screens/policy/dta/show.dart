import 'package:flutter/material.dart';
import '../../../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../screens/user/auth.dart';

class PolicyDtaView extends StatefulWidget {
  DocumentSnapshot document;
  String companyName = "-";
  String countryName = "-";

  PolicyDtaView(doc) {
    this.document = doc;
  }
  @override
  _PolicyDtaViewState createState() => new _PolicyDtaViewState();
}

class _PolicyDtaViewState extends State<PolicyDtaView> {

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
          
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height / 22,
              child:Column(
                        children: <Widget>[
                         
                          Text(
                            widget.document["name"] ,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          

                           SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "APPLICANT NAME",
                                    style: TextStyle(
                                      color: Colors.blueGrey[200],
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 5.0,
                                      margin: EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      padding: EdgeInsets.all(2.0)
                                      ,
                                      child: Text(
                                        "APPLICANT ADDRESS",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
                                        ),
                                      ))),
                            ],
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
                                      // color: Colors.white,
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["applicantname"],
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.only(
                                          top: 15.0, left: 10.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                         border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                          ),
                                      child: Text(
                                        widget.document["applicantaddress"],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17.0,
                                        ),
                                      ))),
                            ],
                          ),

                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "POLICY NO",
                                    style: TextStyle(
                                      color: Colors.blueGrey[200],
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 5.0,
                                      margin: EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      padding: EdgeInsets.all(2.0)
                                      ,
                                      child: Text(
                                        "PROPOSAL NO",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
                                        ),
                                      ))),
                            ],
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
                                      // color: Colors.white,
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["policyno"],
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.only(
                                          top: 15.0, left: 10.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                         border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                          ),
                                      child: Text(
                                        widget.document["proposalno"],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17.0,
                                        ),
                                      ))),
                            ],
                          ),

 SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "LOAN VALUE",
                                    style: TextStyle(
                                      color: Colors.blueGrey[200],
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 5.0,
                                      margin: EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      padding: EdgeInsets.all(2.0)
                                      ,
                                      child: Text(
                                        "START DATE",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
                                        ),
                                      ))),
                            ],
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
                                      // color: Colors.white,
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["loanvalue"],
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.only(
                                          top: 15.0, left: 10.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                         border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                          ),
                                      child: Text(
                                        widget.document["startdate"],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17.0,
                                        ),
                                      ))),
                            ],
                          ),

                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "PERIOD OF POLICY",
                                    style: TextStyle(
                                      color: Colors.blueGrey[200],
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 5.0,
                                      margin: EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      padding: EdgeInsets.all(2.0)
                                      ,
                                      child: Text(
                                        "END DATE",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
                                        ),
                                      ))),
                            ],
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
                                      // color: Colors.white,
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["period"].toString(),
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.only(
                                          top: 15.0, left: 10.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                         border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                          ),
                                      child: Text(
                                        widget.document["enddate"],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17.0,
                                        ),
                                      ))),
                            ],
                          ),


                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "PREMIUM - LKR",
                                    style: TextStyle(
                                      color: Colors.blueGrey[200],
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 5.0,
                                      margin: EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      padding: EdgeInsets.all(2.0)
                                      ,
                                      child: Text(
                                        "PAID AMOUNT",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
                                        ),
                                      ))),
                            ],
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
                                      // color: Colors.white,
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["premium"].toString(),
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.only(
                                          top: 15.0, left: 10.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                         border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                          ),
                                      child: Text(
                                        widget.document["paid"].toString(),
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17.0,
                                        ),
                                      ))),
                            ],
                          ),

                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 15.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "BALANCE AMOUNT",
                                    style: TextStyle(
                                      color: Colors.blueGrey[200],
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 5.0,
                                      margin: EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      padding: EdgeInsets.all(2.0)
                                      ,
                                      child: Text(
                                        "DUE DATE",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
                                        ),
                                      ))),
                            ],
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
                                      // color: Colors.white,
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["due"].toString(),
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.only(
                                          top: 15.0, left: 10.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                         border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                          ),
                                      child: Text(
                                        widget.document["duedate"],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17.0,
                                        ),
                                      ))),
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
