import 'package:emerge/core/funcs.dart';
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/pages/pamoramawidget.dart';
import 'package:emerge/ui/pages/peoplesList.dart';
import 'package:emerge/ui/widgets/Biedgikpage.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:emerge/videocalls/pages/helloCallAcceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class loungeRoom extends StatefulWidget {
  @override
  _loungeRoomState createState() => _loungeRoomState();
}

class _loungeRoomState extends State<loungeRoom> {
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
    enterToRoom("lounge");
    getPeoplesInRoom();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: mirror,
      body: Stack(
        children: [
          PanoramaWidget(photoUrl: "assets/laungh.jpg",),
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
                          showDialog(context: context, child: Dialog(
                            backgroundColor: prozrachniy,
                            child: HelloCallAcceptorWidget(callData["ids"][0]),));
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
                                  btnText: 'Балкон',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/balcony');
                                    exitFromRoom("lounge");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Бассейн',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/swimmingpool');
                                    exitFromRoom("lounge");
                                  },
                                ),
                                myGradientButton(context,
                                    btnText: 'Алкогольный бар',
                                    funk: () {
                                    Navigator.of(context).pushNamed('/alcobar');
                                    exitFromRoom("lounge");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Чайный бар',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/teabar');
                                    exitFromRoom("lounge");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'На ресепшн',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/reseptions');
                                    exitFromRoom("lounge");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Домой',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/inhotel');
                                    exitFromRoom("lounge");
                                  },
                                )
                              ],
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
}