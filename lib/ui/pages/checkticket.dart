
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
                  _routeName = '/inhotel';
                  break;
                case 1:
                  _routeName = '/checkbag';
                  break;
                case 2:
                  _routeName = '/reseptions';
                  break;
              }
              Navigator.pushNamed(context, _routeName);
            })

    );
  }
}