

import 'dart:math';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as Mobfirestore;
import 'package:emerge/core/funcs.dart';
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/pages/pamoramawidget.dart';
import 'package:emerge/ui/pages/peoplesList.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:emerge/ui/widgets/Biedgikpage.dart';
import 'package:emerge/videocalls/pages/call.dart';
import 'package:emerge/videocalls/pages/confCall.dart';
import 'package:emerge/videocalls/pages/helloCallAcceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

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
    enterToRoom(widget.roomPath);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("peoplesInRoom" + peoplesInRoom.toString());
    return Scaffold(
        floatingActionButton: mirror,
        body: Stack(
          children: [
            PanoramaWidget(photoUrl: widget.panoramaUrl),
            StreamBuilder(stream: firestore.collection("users").document(user.uid).collection("chats").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Container() ;
              }

              if (snapshot.data.documents.length ==0) {
                return Container() ;
              }
              List<Map<String, dynamic>> listDialogs = [];
              snapshot.data.documents.forEach((doc) {
                listDialogs.add(doc.data);
              });
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listDialogs.length,
                  itemBuilder: (context, item) {
                   Map<String, dynamic> callData =   listDialogs[item];
                  return  Container(padding: EdgeInsets.all(20.0),
                    child: FlatButton(onPressed: () {
                      showDialog(context: context, child:
                      Dialog (
                        backgroundColor: prozrachniy,
                        child: ConfCallPage(
                            [
                              CallPage(channelName: listDialogs[item]["ids"][0], role: ClientRole.Audience),
                            ]
                        )
                        ,)
                      );
                    },
                    child: BiedgikPage({
                      "name" : callData["name"]
                    }),)

                  );
                  });


              },)
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
                   showDialog(context: context, child: Dialog( child:  PeoplesList(peoplesInRoom) ,));
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
    List<PeoplesInRoom> peoples = new List();

    firestore.collection("rooms").document(widget.roomPath).collection("peoples").snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((people) {
        peoples.add(
            PeoplesInRoom.fromMap(people.data)
        );
      });

      setState(() {
        peoplesInRoom = peoples;
      });
        });
  }



}