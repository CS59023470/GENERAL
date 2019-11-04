import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';


class HisAna extends StatefulWidget {
  @override
  _HisAnaState createState() => _HisAnaState();
}

class _HisAnaState extends State<HisAna> {
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;
  FirebaseUser currentUser;
  DatabaseReference watchRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("","");
    _initDB();

  }

  void _initDB() async{
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    currentUser = await firebaseAuth.currentUser();
    itemRef = watchRef = database.reference().
    child('UserHistory').
    child(currentUser.uid).
    reference();
    itemRef.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }


  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      itemRef.push().set(item.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text('ประวัติการวิเคราะห์'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF5DB7DE))),
      backgroundColor: Color(0xFFEBE4D6),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.network(items[index].Picture,width: 250.0,height: 150.0,),
                            SizedBox(height: 10.0),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(items[index].Date),
                          ],
                        ),
                      ],
                    ),

                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  String key;
  String Picture;
  String Date;

  Item(this.Picture, this.Date);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Picture = snapshot.value["Url_Picture"],
        Date = snapshot.value["datetime"];

  toJson() {
    return {
      "Url_Picture": Picture,
      "datetime": Date,
    };
  }
}