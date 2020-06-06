import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBag extends StatefulWidget {
  @override
  _CheckBagState createState() => _CheckBagState();
}

class _CheckBagState extends State<CheckBag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
            children: <Widget>[
//              FlatButton(
//                child: Text("билет"),
//                onPressed: () {
//                  Navigator.of(context).pushNamed('/checkticket');
//                },
//              ),
//              FlatButton(
//                child: Text("карту"),
//                onPressed: () {
//                  Navigator.of(context).pushNamed('/сheckсard');
//                },
//              )
            ],
          ),
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
                                  child: Text("билет"),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/checkticket');
                                  },
                                ),
                                FlatButton(
                                  child: Text("карту"),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/сheckсard');
                                  },
                                ),
                                myGradientButton(context,
                                  btnText: "Домой",
                                  funk: () {
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
    throw UnimplementedError();
  }
}
