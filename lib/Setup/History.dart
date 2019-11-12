import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

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
    item = Item("", "", "", "","",);
    _initDB();

  }

  void _initDB() async {
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
    if (itemRef == null) {
      return Text('ไม่พบข้อมูล....',
        style: TextStyle(fontSize: 40.0, color: Colors.white),);
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('ประวัติการวิเคราะห์'),
        ),
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
                              Image.network(items[index].Picture, width: 200.0,
                                height: 150.0,),
                              SizedBox(height: 10.0),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(items[index].Date),
                              Text(items[index].Detail1),
                            ],
                          )
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
}

class Item {
  String key;
  String Picture;
  String Detail1;
  String Date;
  String _userId;
  String value1;

  Item(this.Picture, this.Detail1, this.Date, this._userId,this.value1);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Picture = snapshot.value["Url_Picture"],
        Detail1 = snapshot.value["category"],
        Date = snapshot.value["Date"],
        _userId = snapshot.value["UID"];

  toJson() {
    return {
      "Url_Picture": Picture,
      "category": Detail1,
      "Date": Date,
      "UID": _userId,
    };
  }
}