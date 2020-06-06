

import 'package:emerge/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reseptions extends StatefulWidget {
  @override
  _ReseptionsState createState() => _ReseptionsState();
}

class _ReseptionsState extends State<Reseptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
//            child: Text('Бассейн'),
//            onPressed: () {
//              Navigator.of(context).pushNamed('/swimmingpool');
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
                                FlatButton(
                                  child: Text('Лаундж комната'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/loungeRoom');
                                  },
                                ),
                                FlatButton(
                                  child: Text('Балкон'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/balcony');
                                  },
                                ),
                                FlatButton(
                                  child: Text('Бассейн'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/swimmingpool');
                                  },
                                ),
                                FlatButton(
                                  child: Text('Алкогольный бар'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/alcobar');
                                  },
                                ),
                                FlatButton(
                                  child: Text('Чайный бар'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/teabar');
                                  },
                                ),
                                FlatButton(
                                  child: Text('Домой'),
                                  onPressed: () {
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