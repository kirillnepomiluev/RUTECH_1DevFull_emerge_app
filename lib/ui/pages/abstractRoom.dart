

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/pages/pamoramawidget.dart';
import 'package:emerge/ui/pages/peoplesList.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
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
  List<List<PeoplesInRoom>> peoplesInRoom = new List();
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
                      });};
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
    List<List<dynamic>> peoples = new List();
    List<List<PeoplesInRoom>> groupPeoplesInRoom = new List();
    Firestore.instance.collection("rooms").document(widget.roomPath).collection("peoples").snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((people) {
        peoples.add(
            List.from(people["peoples"])
        );
      });
      peoples.forEach((element) {
        List<PeoplesInRoom> peoplesInRoom = new List();
        element.forEach((e) {
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