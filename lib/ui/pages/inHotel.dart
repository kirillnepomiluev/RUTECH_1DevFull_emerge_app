import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:emerge/chart/line_chart.dart';
import 'package:emerge/core/funcs.dart';
import 'package:emerge/locale/app_translations.dart';
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/widgets/Biedgikpage.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:emerge/videocalls/pages/call.dart';
import 'package:emerge/videocalls/pages/helloCallAcceptor.dart';
import 'package:flutter/material.dart';
import 'package:emerge/ui/pages/pamoramawidget.dart';

import '../../main.dart';

class InHotel extends StatefulWidget {

  @override
  _InHotelState createState() => _InHotelState();
}


class _InHotelState extends State<InHotel> {

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
  void initState() {
    // TODO: implement initState
    super.initState();
    enterToRoom("hotel");
    getPeoplesInRoom();
  }

  @override
  void dispose() {
    exitFromRoom("hotel");
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: mirror,
        body:  Stack(
          children: [
            PanoramaWidget(photoUrl: "assets/inhotel.jpg",),
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                              return CallPage(channelName:  callData["ids"][0].substring(0,7), role: ClientRole.Audience);
                            }));
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
                                    exitFromRoom("hotel");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Дверь',
                                  funk: () {
                                    Navigator.of(context)
                                        .pushNamed('/enterpage');
                                    exitFromRoom("hotel");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Проверить сумку',
                                  funk: () {
                                    Navigator.of(context)
                                        .pushNamed('/checkbag');
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