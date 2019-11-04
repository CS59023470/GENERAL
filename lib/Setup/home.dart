import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mass/Setup/Location.dart';
import 'package:mass/Setup/ProFile.dart';
import 'package:mass/Setup/SelectFunction.dart';
import 'package:mass/Setup/camera.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFEBE4D6),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 300.0, right: 20.0, top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ProFile()));
                            },
                            child: Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      image: new AssetImage("assets/menu.png"), height: 45.0, width: 45.0)
                                ],//<Widget>[]
                              ),//Column
                            ),//Container,
                          )//GestureDetector
                      )//Padding
                    ],//<Widget>[]
                  ),//Row
                  new Text("MENU",style: new TextStyle(fontSize: 65.0)),
                  new SizedBox(
                      height: 35.0),//SizeBox
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 110.0,),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SelectFunction()));
                          },
                          child: new Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Image(
                                    image: new AssetImage("assets/camera.png"),
                                    height: 150, width: 150),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Text("CAMERA",style: new TextStyle(fontSize: 30)),
                  new SizedBox(
                      height: 50.0),//SizeBox
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 110.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LocationPage()));
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Image(
                                    image: new AssetImage("assets/position.png"),
                                    height: 150, width: 150),
                              ],//<Widget>[]
                            ),//Column
                          ),//Container
                        ),//GestureDetector
                      ),//Padding
                    ],//<Widget>[]
                  ),//Row
                  new Text("BEEF POSITION",style: new TextStyle(fontSize: 30)),
                ],//<Widget>[]
              ),//Column
            ),//Container
          ),//Padding
        ],//<Widget>[]
      ),//ListView
    );//Scaffold
  }
}