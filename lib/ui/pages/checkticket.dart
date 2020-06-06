import 'dart:io';

import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/widgets/MyTexts.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CheckTicket extends StatefulWidget {
  @override
  _CheckTicketState createState() => _CheckTicketState();
}

class _CheckTicketState extends State<CheckTicket> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSuName = TextEditingController();
  TextEditingController controllerNumberTicket = TextEditingController();
  bool exception = false;

  @override
  void initState() {
    controllerName.addListener(() {
      setState(() {
        exception = false;
      });
    });

    controllerSuName.addListener(() {
      setState(() {
        exception = false;
      });
    });

    controllerNumberTicket.addListener(() {
      setState(() {
        exception = false;
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Center(child: Text('Билет')),
            Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)),
            ),
            buildTextForm(controllerName, label: 'Введите имя'),
            buildTextForm(controllerSuName, label: 'Введите Фамилию'),
            buildTextForm(controllerNumberTicket, label: 'Введите номер билета'),
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
                  {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  myGradientButton(
                                    context,
                                    btnText: 'Зеркало',
                                    funk: () {
                                      Navigator.of(context)
                                          .pushNamed('/mirror');
                                    },
                                  ),
                                  myGradientButton(
                                    context,
                                    btnText: 'Дверь',
                                    funk: () {
                                      Navigator.of(context)
                                          .pushNamed('/enterpage');
                                    },
                                  ),
                                  myGradientButton(
                                    context,
                                    btnText: 'Проверить сумку',
                                    funk: () {
                                      Navigator.of(context)
                                          .pushNamed('/checkbag');
                                    },
                                  ),
                                  myGradientButton(
                                    context,
                                    btnText: "На расепшн",
                                    funk: () {
                                      Navigator.of(context)
                                          .pushNamed('/reseptions');
                                    },
                                  ),
                                  myGradientButton(
                                    context,
                                    btnText: "Домой",
                                    funk: () {
                                      Navigator.of(context)
                                          .pushNamed('/inhotel');
                                    },
                                  )
                                ],
                              ),
                            ),
                            backgroundColor: prozrachniy,
                          );
                        });
                  }
                  ;
//                  break;
//                case 1:
//                  _routeName = '/checkbag';
//                  break;
//                case 2:
//                  _routeName = '/reseptions';
//                  break;
              }
              Navigator.pushNamed(context, _routeName);
            }));
  }
}
