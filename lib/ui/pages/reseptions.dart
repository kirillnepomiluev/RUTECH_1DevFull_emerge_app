

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/pages/pamoramawidget.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reseptions extends StatefulWidget {
  @override
  _ReseptionsState createState() => _ReseptionsState();
}

class _ReseptionsState extends State<Reseptions> {

  List<List<PeoplesInRoom>> peoplesInRoom = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPeoplesInRoom();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("peoplesInRoom" + peoplesInRoom.toString());
    return Scaffold(
      body: PanoramaWidget(photoUrl: "assets/central.jpg",),
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
                              children: <Widget>[
                                myGradientButton(context,
                                  btnText: 'Лаундж комната',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/loungeRoom');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Балкон',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/balcony');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Бассейн',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/swimmingpool');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Алкогольный бар',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/alcobar');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Чайный бар',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/teabar');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Домой',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/inhotel');
                                  },
                                )
                              ],
                            ),
                          ),
                          backgroundColor: prozrachniy,
                        );
                      });};
//                  break;
//                case 1:
//                  _routeName = '/checkbag';
//                  break;
//                case 2:
//                  _routeName = '/reseptions';
//                  break;
              }
              Navigator.pushNamed(context, _routeName);
            })

    );
  }

  void getPeoplesInRoom() async {
    List<List<dynamic>> peoples = new List();
    List<List<PeoplesInRoom>> groupPeoplesInRoom = new List();
    Firestore.instance.collection("rooms").document("reception").collection("peoples").snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((people) {
        debugPrint("PEOPLE1" + people.toString());
        peoples.add(
            List.from(people["peoples"])
        );
      });
      peoples.forEach((element) {
        List<PeoplesInRoom> peoplesInRoom = new List();
        debugPrint("PEOPLE2" + element.toString());
        element.forEach((e) {
          debugPrint("PEOPLE3" + e.toString());
          peoplesInRoom.add(
              PeoplesInRoom(e["id"], e["name"], e["stream"]));
        });
        groupPeoplesInRoom.add(peoplesInRoom);
      });
      setState(() {
        peoplesInRoom = groupPeoplesInRoom;
      });
    });
  }

}