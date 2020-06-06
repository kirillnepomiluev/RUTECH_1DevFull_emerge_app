

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerge/core/funcs.dart';
import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/pages/pamoramawidget.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Reseptions extends StatefulWidget {
  @override
  _ReseptionsState createState() => _ReseptionsState();
}

class _ReseptionsState extends State<Reseptions> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enterToRoom("reseptions");
  }

  @override
  void dispose() {
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: mirror,
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
                                    exitFromRoom("reseptions");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Балкон',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/balcony');
                                    exitFromRoom("reseptions");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Бассейн',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/swimmingpool');
                                    exitFromRoom("reseptions");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Алкогольный бар',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/alcobar');
                                    exitFromRoom("reseptions");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Чайный бар',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/teabar');
                                    exitFromRoom("reseptions");
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: 'Домой',
                                  funk: () {
                                    Navigator.of(context).pushNamed('/inhotel');
                                    exitFromRoom("reseptions");
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