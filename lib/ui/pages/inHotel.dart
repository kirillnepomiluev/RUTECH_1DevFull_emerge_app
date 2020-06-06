import 'package:emerge/chart/line_chart.dart';
import 'package:emerge/core/funcs.dart';
import 'package:emerge/locale/app_translations.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:emerge/ui/pages/pamoramawidget.dart';

class InHotel extends StatefulWidget {
  @override
  _InHotelState createState() => _InHotelState();
}


class _InHotelState extends State<InHotel> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enterToRoom("hotel");
  }

  @override
  void dispose() {
    exitFromRoom("hotel");
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body:  PanoramaWidget(photoUrl: "assets/inhotel.jpg",),
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