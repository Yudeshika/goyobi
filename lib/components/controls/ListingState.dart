import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/IM.dart';
import '../../components/entities/IMObject.dart';

class ListingState<T extends StatefulWidget> extends State<T> {

  String title;
  String table;
  List columns;
  ListingState(){
    this.title = "ENTITIES";
    this.table = "tables";
    this.columns = new List();
  }

  ListingState.more(String title, String table, List columns){
    this.title = title;
    this.table = table;
    this.columns = columns;

  }

  TextEditingController controller = new TextEditingController();
  String filter = "";
  int sort = 0;

  @override
  initState() { 
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSortChanged(){
    setState(() {
        filter = controller.text;
        sort++;
        if(sort>2){
          sort=0;
        }
        
    });
  }

  var map = new Map<String, dynamic>();

  @override
  Widget build(BuildContext context) => new Scaffold(
        //App Bar
        appBar: new IMAppBar(
          title: this.title,
          context: context,
        ),
        floatingActionButton: new IMButton(
          title: "",
          icon:new Icon(Icons.add),
          context: context,
          onPressed: () {
            Navigator.of(context).pushNamed('/'+table.substring(0, table.length-1)+'create');
          },
          type: ButtonTypes.danger,
        ),

        //Content of tabs
        body: 
        new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    //onChanged: onSearchTextChanged,
                  ),
                  trailing: new Container(
                    width: 100.0,
                    child: 
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    controller.clear();
                  },),
                  new IconButton(

                    icon: new Icon(
                      (sort==0)?Icons.sort:Icons.sort_by_alpha
                      ), 
                      onPressed: () {
                    onSortChanged();
                  },)],
                      )
                    
                  )
                  
                  ,
                ),
          
        
          new Expanded(
            //alignment: Alignment.topCenter,
            child: StreamBuilder(
              stream: 
              (sort==1)?Firestore.instance.collection(this.table).orderBy(this.columns[0]).snapshots():
              (sort==2)?Firestore.instance.collection(this.table).orderBy(this.columns[0], descending:true).snapshots():
              Firestore.instance.collection(this.table).snapshots()
              
              
              ,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');
                return new ListView(
                  children: 
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    //bool done = document["done"];
                    //map[document.documentID] = document["done"];
                    String name = document[this.columns[0]];
                    if(name.toLowerCase().contains(filter.toLowerCase())){
                      return Dismissible(
                        key: new Key(document.documentID),
                        onDismissed: (direction){
                          Firestore.instance.document(this.table+'/${document.documentID}').delete();
                          snapshot.data.documents.remove(document);
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text("Removed!"),
                          ));
                        },
                        child: IMListTile(
                      obj: IMObject(
                        key: document[this.columns[0]],
                        title: document[this.columns[0]],
                        subtitle: document[this.columns[1]].toString()+ ( (this.columns.length>2)?" - "+document[this.columns[2]].toString():""),

                      )
                      ),)
                      ;
                    }else{
                      return new Container();
                    }
                    
                  }).toList(),
                  
                );
              },
            ),
          ),
          

  ],

  )

      );
}