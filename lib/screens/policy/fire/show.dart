import 'package:flutter/material.dart';
import '../../../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../screens/user/auth.dart';

class PolicyFireView extends StatefulWidget {
  DocumentSnapshot document;
  String companyName = "-";
  String countryName = "-";

  PolicyFireView(doc) {
    this.document = doc;
  }
  @override
  _PolicyFireViewState createState() => new _PolicyFireViewState();
}

class _PolicyFireViewState extends State<PolicyFireView> {

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
        body: 
        //---------------------------------
        //Tabbed Pane Start
                new Container(
                  child: DefaultTabController(
        length: 2,
        child: Scaffold(
          
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.assignment),
                text: "POLICY DETAILS",
                ),
                Tab(icon: Icon(Icons.attach_money),
                text: "PAYMENT DETAILS",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              
             
               new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                // color: Colors.black.withOpacity(0.8),
              ),
              // clipper: getClipper(),
            ),
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
                                    "SUM",
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
                                    widget.document["sum"].toString(),
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
                                        widget.document["start"],
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
                                        "RENEWAL DATE",
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
                                        widget.document["renewal"],
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
                                    "DUE AMOUNT",
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
                                    "POLICY LOCATION ADDRESS",
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
                                        "ITEM NAME",
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
                                    widget.document["location"],
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
                                        widget.document["itemname"],
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
                                    "SERIAL NO",
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
                                        "MODEL",
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
                                    widget.document["serialno"],
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
                                        widget.document["model"],
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
                                    "MANUFACTURED YEAR",
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
                                        "VALUATION",
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
                                    widget.document["yearofmake"].toString(),
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
                                        widget.document["value"].toString(),
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17.0,
                                        ),
                                      ))),
                            ],
                          ),
                
                        ],
                    )
                
                    
            )
          ],
        ),
                
              new SingleChildScrollView(
                child:Text("test")
              )
              
            ],
          ),
        )
                  )
            )
        //--------------------------------
        
                
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
