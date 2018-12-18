import 'package:flutter/material.dart';
import '../../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../screens/user/auth.dart';

class CustomerView extends StatefulWidget {
  DocumentSnapshot document;
  String companyName = "-";
  String countryName = "-";

  CustomerView(doc) {
    this.document = doc;
  }
  @override
  _CustomerViewState createState() => new _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {

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
          title: "CUSTOMER PROFILE",
          context: context,
        ),

        //Content of tabs
        body:  new SingleChildScrollView(
          child: 
          new Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
          child:
          new Stack(
        children: <Widget>[
            ClipPath(
              child: Container(
          //       decoration: new BoxDecoration(
          // image: new DecorationImage(
          //   image: new NetworkImage("https://images.pexels.com/photos/952670/pexels-photo-952670.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
          //   fit: BoxFit.cover,
          //),
        //),
                // color: Colors.black.withOpacity(0.8),
              ),
              // clipper: getClipper(),
            ),

            Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  <Widget>[
                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width/3,
                  child:RaisedButton(
                    onPressed: (){
                       launch("tel://" +
                        widget.document[
                          'mobile']);
                    },
                    // textColor: Colors.white,
                    color: Colors.black.withOpacity(0.8),
                    padding: const EdgeInsets.all(8.0),
                    child:  Icon(
                    Icons.add_call, size: 30.0, color: Colors.amberAccent,
                  ),
                  ),
                ),
                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width/3,
                  child:RaisedButton(
                    onPressed: (){
                      launch("sms:" +
                        widget.document[
                          'mobile']);
                    },
                    // textColor: Colors.white,
                    color: Colors.black.withOpacity(0.8),
                    padding: const EdgeInsets.all(8.0),
                    child:  Icon(
                    Icons.chat, size: 30.0, color: Colors.greenAccent,
                  ),
                  ),
                ),
                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width/3,
                  child:RaisedButton(
                    onPressed: (){},
                    // textColor: Colors.white,
                    color: Colors.black.withOpacity(0.8),
                    padding: const EdgeInsets.all(8.0),
                    child:  Icon(
                    Icons.add_a_photo, size: 30.0, color: Colors.blueAccent,
                  ),
                  ),
                ),
              
              ],
            ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height / 12,
              child:Column(
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                          SizedBox(width: 20.0),
                              Container(
                            width: 80.0,
                            height: 80.0,
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
                          )
                          ,
                          SizedBox(width: 20.0),
                          Text(
                            widget.document["name"] ,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                            ],
                          ),
                        
                          
                          SizedBox(height: 0.0),
                          Text(
                            widget.document["mobile"],
                            style: TextStyle(
                              fontSize: 17.0,
                              fontStyle: FontStyle.italic,
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
                                    "SOCIAL SECURITY NO / NIC",
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
                                        "PERSONAL EMAIL",
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
                                    widget.document["nic"],
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
                                        widget.document["email"],
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 17.0,
                                        ),
                                      ))),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 10.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "CONTACT NO - HOME",
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
                                        "HOME / REGISTER ADDRESS",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
                                        ),
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
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["mobile"],
                                    style: TextStyle(
                                      color: Colors.grey[700],
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
                                    border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                child: Text(
                                  widget.document["address"],
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 17.0,
                                  ),
                                ),
                              )),
                            ],
                          ),

                          
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
                                    "BIRTHDAY",
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
                                        "GENDER",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
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
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["bday"],
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
                                    top: 15.0, left: 10.0, right: 15.0),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                child: Text(
                                  (widget.document["gender"]==1)?"Male":"Female",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 17.0,
                                  ),
                                ),
                              )),
                            ],
                          ),

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
                                    "HEIGHT (cm)",
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
                                        "WEIGHT (Kg)",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
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
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    widget.document["height"],
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
                                    top: 15.0, left: 10.0, right: 15.0),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                child: Text(
                                  widget.document["weight"],
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 17.0,
                                  ),
                                ),
                              )),
                            ],
                          ),

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
                                    "MARITAL STATUS",
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
                                        "CHILDREN",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
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
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                    (widget.document["status"]==1)?"Married":"Unmarried",
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
                                    top: 15.0, left: 10.0, right: 15.0),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                child: Text(
                                  widget.document["children"],
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 17.0,
                                  ),
                                ),
                              )),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 10.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "OCCUPATION",
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
                                          top: 5.0, left: 10.0),
                                      padding: EdgeInsets.all(2.0)
                                      ,
                                      child: Text(
                                        "CONTACT NO - OFFICE",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 11.0,
                                        ),
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
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                     widget.document["occupation"],
                                    style: TextStyle(
                                      color: Colors.grey[700],
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
                                    border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                child: Text(
                                  widget.document["income"],
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 17.0,
                                  ),
                                ),
                              )),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 5.0,
                                  margin:
                                      EdgeInsets.only(top: 10.0, left: 10.0),
                                  padding: EdgeInsets.all(2.0),
                                  
                                  child: Text(
                                    "HOME / REGISTER ADDRESS",
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
                                          top: 5.0, left: 10.0),
                                      padding: EdgeInsets.all(2.0)
                                      ,
                                      child: Text(
                                        "WORK ADDRESS",
                                        style: TextStyle(
                                          color: Colors.blueGrey[200],
                                          fontSize: 12.0,
                                        ),
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
                                      border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  child: Text(
                                     widget.document["worktelephone"].toString(),
                                    style: TextStyle(
                                      color: Colors.grey[700],
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
                                    border: Border.all(color: Colors.grey[200]),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                child: Text(
                                  widget.document["workaddress"],
                                  style: TextStyle(
                                    color: Colors.grey[700],
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
                                    'Edit Profile',
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
          )
        )       
      );
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, 50.0);
    path.lineTo(size.width , 50.0);
    path.lineTo(size.width , 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
