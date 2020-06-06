import 'package:emerge/core/funcs.dart';
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class SwimmingPool extends StatefulWidget {
  @override
  _SwimmingPoolState createState() => _SwimmingPoolState();
}

class _SwimmingPoolState extends State<SwimmingPool> {
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
    enterToRoom("swimmingpool");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: mirror,
      appBar: AppBar(title: FlatButton(
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      ),
      body: Column(
        children: <Widget>[
//          FlatButton(
//            child: Text('Лаундж комната'),
//            onPressed: () {
//              Navigator.of(context).pushNamed('/loungeRoom');
//            },
//          ),
//          FlatButton(
//            child: Text('Балкон'),
//            onPressed: () {
//              Navigator.of(context).pushNamed('/balcony');
//            },
//          ),
//          FlatButton(
//            child: Text('Алкогольный бар'),
//            onPressed: () {
//              Navigator.of(context).pushNamed('/alcobar');
//            },
//          ),
//          FlatButton(
//            child: Text('Чайный бар'),
//            onPressed: () {
//              Navigator.of(context).pushNamed('/teabar');
//            },
//          )
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
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               myGradientButton(context,
                                 btnText: 'Лаундж комната',
                                 funk: () {
                                   Navigator.of(context).pushNamed('/loungeRoom');
                                   exitFromRoom("swimmingpool");
                                 },
                               ),
                               myGradientButton(context,
                                 btnText: 'Балкон',
                                 funk: () {
                                   Navigator.of(context).pushNamed('/balcony');
                                   exitFromRoom("swimmingpool");
                                 },
                               ),
                               myGradientButton(context,
                                 btnText: 'Алкогольный бар',
                                 funk: () {
                                   Navigator.of(context).pushNamed('/alcobar');
                                   exitFromRoom("swimmingpool");
                                 },
                               ),
                               myGradientButton(context,
                                 btnText: 'Чайный бар',
                                 funk: () {
                                   Navigator.of(context).pushNamed('/teabar');
                                   exitFromRoom("swimmingpool");
                                 },
                               ),
                               myGradientButton(context,
                                 btnText: 'На ресепшн',
                                 funk: () {
                                   Navigator.of(context).pushNamed('/reseptions');
                                   exitFromRoom("swimmingpool");
                                 },
                               ),
                               myGradientButton(context,
                                 btnText: 'Домой',
                                 funk: () {
                                   Navigator.of(context).pushNamed('/inhotel');
                                   exitFromRoom("swimmingpool");
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