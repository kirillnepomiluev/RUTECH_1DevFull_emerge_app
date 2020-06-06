

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/pages/pamoramawidget.dart';
import 'package:emerge/ui/pages/peoplesList.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AbstractRoom extends StatefulWidget {
  String roomPath;
  String panoramaUrl;

  AbstractRoom(this.roomPath, this.panoramaUrl);

  @override
  _AbstractRoomState createState() => _AbstractRoomState();
}

class _AbstractRoomState extends State<AbstractRoom> {
  List<PeoplesInRoom> peoplesInRoom = new List();
  List<Widget> routesWidget = new List();

  static const List<Map<String, String>> routes = [{'Лаунж-зона' : 'loungeRoom'}, {'Балкон' : 'balcony'},
    {'Бассейн' : 'swimmingpool'}, {'Алко-бар' : 'alcobar'}, {'Чайный бар' : 'teabar'},
    {'В номер' : 'inhotel'}, {'Ресепшн' : 'reseptions'}];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPeoplesInRoom();
    setRoutes();
    enterToRoom();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("peoplesInRoom" + peoplesInRoom.toString());
    return Scaffold(
        body: Stack(
          children: [

            PanoramaWidget(photoUrl: widget.panoramaUrl),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 26,
            unselectedItemColor:
            Theme.of(context).tabBarTheme.unselectedLabelColor,
            selectedItemColor: Theme.of(context).tabBarTheme.labelColor,
            selectedLabelStyle: Theme.of(context).tabBarTheme.labelStyle,
            unselectedLabelStyle:
            Theme.of(context).tabBarTheme.unselectedLabelStyle,
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text('Главная'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                title: Text('Команда'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text('Билеты'),
              ),
            ],
            onTap: (int index) {
              String _routeName;
              switch (index) {
                case 0:
                  {showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: routesWidget,
                            ),
                          ),
                          backgroundColor: prozrachniy,
                        );
                      });
                  };
                  break;
                case 1:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PeoplesList(peoplesInRoom),
                      ),
                    );
                  }
                  break;
//                case 2:
//                  _routeName = '/reseptions';
//                  break;
              }
              Navigator.pushNamed(context, _routeName);
            })

    );
  }

  List<Widget> setRoutes() {
    routes.forEach((element) {
      if (element.values.first != widget.roomPath) {
        routesWidget.add(
            myGradientButton(context,
              btnText: element.keys.first,
              funk: () {
                Navigator.of(context).pushNamed('/' + element.values.first);
              },
            )
        );
      }
    });
  }

  void getPeoplesInRoom() async {
    List<PeoplesInRoom> groupPeoplesInRoom = new List();
    Firestore.instance.collection("rooms").document(widget.roomPath).collection("peoples").snapshots()
        .listen((snapshot) {
      if (snapshot.documents.length != 0) {
        snapshot.documents.forEach((people) {
          groupPeoplesInRoom.add(PeoplesInRoom.fromMap(people.data));
          }
        );
      }
    });
      setState(() {
        peoplesInRoom = groupPeoplesInRoom;
      });
  }

  void enterToRoom() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await firebaseAuth.currentUser();
    String uid = user != null ? user.uid : "id" + Random(44).nextInt(67054).toString();
    var dataToSet = {
      "id" : uid,
      "name" : "UserName" + Random(44).nextInt(67054).toString()
    };

    await Firestore.instance
        .collection("rooms")
        .document(widget.roomPath)
        .collection("peoples")
        .document(uid)
        .setData(dataToSet);

    setState(() {
      peoplesInRoom.add(PeoplesInRoom.fromMap(dataToSet));
    });

  }

}