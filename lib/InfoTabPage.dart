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
import 'package:sticky_headers/sticky_headers.dart';

import 'core/funcs.dart';
import 'locale/app_translations.dart';
import 'main.dart';

class InfoTabPage extends StatefulWidget {
  final TabController tabcontroller;
  String deviceID;

  InfoTabPage({this.tabcontroller, this.deviceID});

  @override
  _InfoTabPageState createState() => _InfoTabPageState();
}

class _InfoTabPageState extends State<InfoTabPage>
    with AutomaticKeepAliveClientMixin<InfoTabPage> {

  DataSnapshot snapshotDevice;
  String image1url1;
  String image1url2;
  int timeSnapshot1;

  @override
  void initState() {
    database.reference().child('devices').child(widget.deviceID).onValue.listen((event) {
      setState(() {
        snapshotDevice = event.snapshot;
        image1url1 = snapshotDevice.value["lastshot0"]["signedurl"];
        image1url2 = snapshotDevice.value["lastshot1"]["signedurl"];
      });
    });
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
    return Container(
        child:
        StreamBuilder(
          stream: database.reference().child('devices').child(widget.deviceID).child("dataandconfig/data").onValue,
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
              _list.forEach((key, value) {item.add(key); });
//Now we're just checking if document is not null then add it to another list called "item".
//I faced this problem it works fine without null check until you remove a document and then your stream reads data including the removed one with a null value(if you have some better approach let me know).
              dynamic airTemp = notNulldata(snapshot.value["insidetemp"][0]);
              dynamic airHum = notNulldata(snapshot.value["insidehum"][0]);
              dynamic airTempOut = notNulldata(snapshot.value["outsidetemp"]);
              dynamic airHumOut = notNulldata(snapshot.value["outsidehum"]);
              dynamic waterTemp = notNulldata(snapshot.value["tanktemp"][0]);
              dynamic waterPH = notNulldata(snapshot.value["tankph"][0]);
              dynamic waterTDS = notNulldata(snapshot.value["tankec"][0], needQ10: false);
              dynamic levelTank = notNulldata(snapshot.value["tanklevel"][0], needQ10: false, needRound: true);
              dynamic levelUp = notNulldata(snapshot.value["racklevel"][0], needQ10: false, needRound: true);
              dynamic levelDown= notNulldata(snapshot.value["racklevel"][1], needQ10: false, needRound: true);




              return snap.data.snapshot.value == null
//return sizedbox if there's nothing in database.
                  ? SizedBox()
//otherwise return a list of widgets.
                  : Center(
                    child: ListView(
                      addAutomaticKeepAlives: true,
                children: <Widget>[
                    Center(child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(AppTranslations.of(context).text("air") + " " +AppTranslations.of(context).text("inside")+"/"+AppTranslations.of(context).text("outside")),
                    )),
                  Center(child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("$airTemp°C / $airTempOut°C    $airHum% / $airHumOut%"),
                  )),
                    Divider(height: 10.0,),
                    Center(child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(AppTranslations.of(context).text("water")),
                    )),
                  Center(child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("$waterTemp °C   $waterPH pH  $waterTDS ppm"),
                  )),
                  Divider(height: 10.0,),
                    Center(child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(AppTranslations.of(context).text("level")),
                    )),
                    Center(child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(AppTranslations.of(context).text("tank")+": $levelTank/4  "+AppTranslations.of(context).text("top_rack")
                          +": $levelUp/4 " +AppTranslations.of(context).text("bottom_rack")+": $levelDown/4 "),
                    )),

                  Divider(height: 15.0,),

                  image1url1==null? Container() :  Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppTranslations.of(context).text("last_images")),
                    )),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: image1url1==null? Container() :  Container(
                       child: Image(
                           image: NetworkImage(image1url1),
                           fit: BoxFit.fitWidth,
                           alignment: Alignment.bottomCenter),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: image1url2==null? Container() :  Container(
                      child: Image(
                          image: NetworkImage(image1url2),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter),
                    ),
                  ),






                ],

              ),
                  );
            }
            else {
              return   Center(child: Text (AppTranslations.of(context).text("loading"), style: Theme.of(context).textTheme.headline3));
            }
          },
        )
    );
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


