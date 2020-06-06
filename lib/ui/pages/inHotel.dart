import 'package:emerge/chart/line_chart.dart';
import 'package:emerge/locale/app_translations.dart';
import 'package:flutter/material.dart';

class InHotel extends StatefulWidget {
  @override
  _InHotelState createState() => _InHotelState();
}


class _InHotelState extends State<InHotel> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            FlatButton(
              child: Text('Зеркало'),
              onPressed: () {
                Navigator.of(context).pushNamed('/mirror');
              },
            ),
            FlatButton(
              child: Text('Дверь'),
              onPressed: () {
                Navigator.of(context).pushNamed('/enterpage');
              },
            ),
            FlatButton(
              child: Text('Проверить сумку'),
              onPressed: () {
                Navigator.of(context).pushNamed('/checkbag');
              },
            )
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