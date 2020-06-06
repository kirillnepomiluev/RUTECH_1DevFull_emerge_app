
import 'package:emerge/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckTicket extends StatefulWidget{
  @override
  _CheckTicketState createState() => _CheckTicketState();
}

class _CheckTicketState extends State<CheckTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                FlatButton(
                                  child: Text('Зеркало'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/mirror');
                                  },
                                ),
                                FlatButton(
                                  child: Text('Дверь'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/enterpage');
                                  },
                                ),
                                FlatButton(
                                  child: Text('Проверить сумку'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/checkbag');
                                  },
                                ),
                                FlatButton(
                                  child: Text('На ресепшн'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/reseptions');
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