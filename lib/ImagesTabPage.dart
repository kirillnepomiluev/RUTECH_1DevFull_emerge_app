import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:emerge/DeviceInfoPage.dart';
import 'package:emerge/ui/widgets/MyCard.dart';
import 'package:emerge/ui/widgets/PlayerBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'locale/app_translations.dart';
import 'main.dart';

class ImagesPage extends StatefulWidget {
  final TabController tabcontroller;
  String deviceID;

  ImagesPage({this.tabcontroller, this.deviceID});

  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage>
    with AutomaticKeepAliveClientMixin<ImagesPage> {

  int currentCamera =0;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return buildTeamPageBody(context);
  }

  void _handleTap(String name, String photo, String country, String amplua,
      String number, String bio, String interview, String stats) {

  }


  Widget buildTeamPageBody(BuildContext context) {
    return Scaffold(
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
                icon: Icon(Icons.camera_alt),
                title: Text(AppTranslations.of(context).text("top_cam")),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                title: Text(AppTranslations.of(context).text("bottom_cam")),
              ),

            ],
            currentIndex: currentCamera,
            onTap: (int index) {
             setState(() {
               currentCamera = index;
             });

            }),
        body:
        StreamBuilder(
          stream: database.reference().child('shots').child(widget.deviceID).child("$currentCamera").orderByChild("time").onValue,
          builder: (BuildContext context,  snap) {
            if (snap.hasError)
              return new Text('Error: ');
            if (snap.data.snapshot.value!=null) {
              //taking the data snapshot.
              DataSnapshot snapshot = snap.data.snapshot;
              List item=[];
              Map _list=Map();
//it gives all the documents in this list.
              _list=snapshot.value;
              _list.forEach((key, value) {item.add(key); });//Now we're just checking if document is not null then add it to another list called "item".
//I faced this problem it works fine without null check until you remove a document and then your stream reads data including the removed one with a null value(if you have some better approach let me know).
              item.sort();
              item = item.reversed.toList();


              return snap.data.snapshot.value == null
//return sizedbox if there's nothing in database.
                  ? SizedBox()
//otherwise return a list of widgets.
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.length,
                itemBuilder: (context, index) {
                  String  image1url = snapshot.value[item[index]]['signedurl'];
                  int timesnap =  snapshot.value[item[index]]['time'];
                  DateTime datatime = DateTime.fromMillisecondsSinceEpoch(timesnap*1000);

                  var formatter =  AppTranslations.of(context).currentLanguage =="ru"? new DateFormat('HH:mm dd.MM.yyyy')
                      : DateFormat.yMd().add_jm();

                  String formattedTime = formatter.format(datatime);

                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(

                      children: <Widget>[
                        image1url==null? Container() :  Container(
                          child: Image(
                              image: NetworkImage(image1url),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.bottomCenter),
                        ),
                        timesnap==null? Container() :
                            Text("$formattedTime",

                              style: TextStyle(backgroundColor: isDarkTheme? Colors.black : Colors.white, fontFamily: "exo",
                                color: isDarkTheme? Colors.white : Colors.black ,

                              ) ,),

                      ],
                    ),
                  );

                },
              );
            }
            else {
              return   Center(child: Text (AppTranslations.of(context).text("loading"), style: Theme.of(context).textTheme.headline3));
            }
          },
        )
    );
  }

    double notNulldata (String data) {
      if (data ==null) return null;

      return int.parse(data)/10;
   }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


