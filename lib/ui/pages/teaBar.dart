import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeaBar extends StatefulWidget {
  @override
  _TeaBarState createState() => _TeaBarState();
}

class _TeaBarState extends State<TeaBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FlatButton(
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      ),
      body: Column(
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