import 'package:flutter/material.dart';
import '../components/IM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/user/auth.dart';

class Profile extends StatefulWidget {
  String uid;
  String companyName =" - ";
  Profile() {
    new Auth().currentUser().then((userId) {
      uid = userId;
    });
  }
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        //App Bar
        appBar: new IMAppBar(
          title: "MY PROFILE",
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
                               print("s="+document.toString());

                              //  final DocumentReference postRef = Firestore.instance.document('companies/'+document["company"]);
// Firestore.instance.runTransaction((Transaction tx) async {
//   DocumentSnapshot postSnapshot = await tx.get(postRef);
//   if (postSnapshot.exists) {
//     print("sss="+widget.companyName);
//     widget.companyName = postSnapshot.data['name'];
//   }
// });

                      

                      return new Column(
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
                            document["first_name"] +
                                " " +
                                document["last_name"],
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            document["email"],
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
                                    document["nic"],
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
                                        widget.companyName,
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
                                    '0774587452',
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
                                  '0117889547',
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
                                    'Sri Lanka',
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
                                    'Office - 0117458745',
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
                                  '1988-12-07',
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
                                    'Edit Profile',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
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
