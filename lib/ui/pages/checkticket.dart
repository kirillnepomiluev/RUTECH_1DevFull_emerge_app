
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CheckTicket extends StatefulWidget{
  @override
  _CheckTicketState createState() => _CheckTicketState();
}

class _CheckTicketState extends State<CheckTicket> {
  List<PeoplesInRoom> peoplesInRoom = new List();
  List<Widget> routesWidget = new List();

  void getPeoplesInRoom() async {
    List<PeoplesInRoom> peoples = new List();

    firestore.collection("rooms").document("reseptions").collection("peoples").snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((people) {
        peoples.add(
            PeoplesInRoom.fromMap(people.data)
        );
      });

      setState(() {
        getPeoplesInRoom();
        peoplesInRoom = peoples;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: mirror,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 26,
            unselectedItemColor:
            Theme
                .of(context)
                .tabBarTheme
                .unselectedLabelColor,
            selectedItemColor: Theme
                .of(context)
                .tabBarTheme
                .labelColor,
            selectedLabelStyle: Theme
                .of(context)
                .tabBarTheme
                .labelStyle,
            unselectedLabelStyle:
            Theme
                .of(context)
                .tabBarTheme
                .unselectedLabelStyle,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                myGradientButton(context,
                                  btnText: 'Зеркало',
                                  funk: () {
                                    Navigator.of(context)
                                        .pushNamed('/mirror');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Дверь',
                                  funk: () {
                                    Navigator.of(context)
                                        .pushNamed('/enterpage');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Проверить сумку',
                                  funk: () {
                                    Navigator.of(context)
                                        .pushNamed('/checkbag');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: "На расепшн",
                                  funk: () {
                                    Navigator.of(context).pushNamed('/reseptions');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: "Домой",
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
}