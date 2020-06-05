import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:emerge/DeviceInfoPage.dart';
import 'package:emerge/ui/widgets/MyCard.dart';
import 'package:emerge/ui/widgets/PlayerBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:emerge/ui/widgets/myChangeButton.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'core/funcs.dart';
import 'core/textFormaters.dart';
import 'locale/app_translations.dart';
import 'main.dart';
import 'ui/widgets/TextFieldPadding.dart';

final amountValidator =
    RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

class ControllTabPage extends StatefulWidget {
  final TabController tabcontroller;
  String deviceID;

  ControllTabPage({this.tabcontroller, this.deviceID});

  @override
  _ControllTabPageState createState() => _ControllTabPageState();
}

class _ControllTabPageState extends State<ControllTabPage>
    with AutomaticKeepAliveClientMixin<ControllTabPage> {
  DataSnapshot snapshotDevice;
  String image1url1;
  String image1url2;
  int timeSnapshot1;
  int currentRack = 0;

  @override
  void initState() {
    database
        .reference()
        .child('devices')
        .child(widget.deviceID)
        .onValue
        .listen((event) {
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
                icon: Icon(Icons.dns),
                title: Text(AppTranslations.of(context).text("top")),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dns),
                title: Text(AppTranslations.of(context).text("bottom")),
              ),
            ],
            currentIndex: currentRack,
            onTap: (int index) {
              setState(() {
                currentRack = index;
              });
            }),
        body: StreamBuilder(
          stream: database
              .reference()
              .child('devices')
              .child(widget.deviceID)
              .child("dataandconfig/config")
              .onValue,
          builder: (BuildContext context, snap) {
            if (snap.hasError) return new Text('Error: ');
            if (snap.data.snapshot.value != null) {
              //taking the data snapshot.
              DataSnapshot snapshot = snap.data.snapshot;
              List item = [];
              Map _list = Map();
//it gives all the documents in this list.
              _list = snapshot.value;
              _list.forEach((key, value) {
                item.add(key);
              });
//Now we're just checking if document is not null then add it to another list called "item".
//I faced this problem it works fine without null check until you remove a document and then your stream reads data including the removed one with a null value(if you have some better approach let me know).
              String r0presset = snapshot.value["presets"][0];
              String r1presset = snapshot.value["presets"][1];
              List<String> presset = [r0presset, r1presset];
              double airTemp = notNullInt(
                  snapshot.value["chamberparams"][0]["airtargettemp"]);
              double airHum = notNullInt(
                  snapshot.value["chamberparams"][0]["airtargethum"]);
              double waterPH =
                  notNullInt(snapshot.value["chamberparams"][0]["targetph"]);
              int fanenableduration =
                  snapshot.value["chamberparams"][0]["fanenableduration"];
              int fanenableperiod =
                  snapshot.value["chamberparams"][0]["fanenableperiod"];
              int fanpwm = snapshot.value["chamberparams"][0]["fanpwm"];
              int flooddisabletime0 =
                  snapshot.value["rackparams"][0]["floodtime"][1];
              int floodduration0 =
                  snapshot.value["rackparams"][0]["floodduration"];
              int floodenabletime0 =
                  snapshot.value["rackparams"][0]["floodtime"][0];
              int floodperiod0 = snapshot.value["rackparams"][0]["floodperiod"];
              int phytolampdisabletime0 =
                  snapshot.value["rackparams"][0]["phytolamptime"][1];
              int phytolampenabletime0 =
                  snapshot.value["rackparams"][0]["phytolamptime"][0];
              int phytolamppwm0 =
                  snapshot.value["rackparams"][0]["phytolamppwm"];

              int flooddisabletime1 =
                  snapshot.value["rackparams"][1]["floodtime"][1];
              int floodduration1 =
                  snapshot.value["rackparams"][1]["floodduration"];
              int floodenabletime1 =
                  snapshot.value["rackparams"][1]["floodtime"][0];
              int floodperiod1 = snapshot.value["rackparams"][1]["floodperiod"];
              int phytolampdisabletime1 =
                  snapshot.value["rackparams"][1]["phytolamptime"][1];
              int phytolampenabletime1 =
                  snapshot.value["rackparams"][1]["phytolamptime"][0];
              int phytolamppwm1 =
                  snapshot.value["rackparams"][1]["phytolamppwm"];
              List<int> flooddisabletime = [
                flooddisabletime0,
                flooddisabletime1
              ];
              List<int> floodduration = [floodduration0, floodduration1];
              List<int> floodenabletime = [floodenabletime0, floodenabletime1];
              List<int> floodperiod = [floodperiod0, floodperiod1];
              List<int> phytolampdisabletime = [
                phytolampdisabletime0,
                phytolampdisabletime1
              ];
              List<int> phytolampenabletime = [
                phytolampenabletime0,
                phytolampenabletime1
              ];
              List<int> phytolamppwm = [phytolamppwm0, phytolamppwm1];

              Widget rackData({bool appRack = true}) {
                return Column(
                  children: <Widget>[
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(appRack
                          ? AppTranslations.of(context).text("top_rack")
                          : AppTranslations.of(context).text("bottom_rack")),
                    )),
                    Container(
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(AppTranslations.of(context).text("preset") +
                            ": ${presset[currentRack]}"),
                      )),
                    ),
                    Divider(
                      height: 10.0,
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(AppTranslations.of(context)
                          .text("irrigation_settings")),
                    )),
                    myChangeButton("rackparams/$currentRack/floodduration",
                        attribute: AppTranslations.of(context).text("min"),
                        value: floodduration[currentRack],
                        title: AppTranslations.of(context)
                                .text("change_irrigation_duration") +
                            (appRack
                                ? AppTranslations.of(context).text("top_rack")
                                : AppTranslations.of(context)
                                    .text("bottom_rack")),
                        decimal: false,
                        minValue: 0,
                        maxValue: 120,
                        description:
                            AppTranslations.of(context).text("duration"),
                        isItHourMinuteFormat: true),
                    myChangeButton("rackparams/$currentRack/floodtime/0",
                        attribute: AppTranslations.of(context).text("min"),
                        value: floodenabletime[currentRack],
                        title: AppTranslations.of(context)
                                .text("changing_irrigation_switch-on_time") +
                            (appRack
                                ? AppTranslations.of(context).text("top_rack")
                                : AppTranslations.of(context)
                                    .text("bottom_rack")),
                        description:
                            AppTranslations.of(context).text("switch-on"),
                        decimal: false,
                        minValue: 0,
                        maxValue: 720,
                        isDayTime: true),
                    myChangeButton("rackparams/$currentRack/floodtime/1",
                        attribute: AppTranslations.of(context).text("min"),
                        value: flooddisabletime[currentRack],
                        title: AppTranslations.of(context)
                                .text("changing_irrigation_switch-off_time") +
                            (appRack
                                ? AppTranslations.of(context).text("top_rack")
                                : AppTranslations.of(context)
                                    .text("bottom_rack")),
                        description:
                            AppTranslations.of(context).text("switch-off"),
                        decimal: false,
                        minValue: 720,
                        maxValue: 1440,
                        isDayTime: true),
                    myChangeButton("rackparams/$currentRack/floodperiod",
                        attribute: AppTranslations.of(context).text("min"),
                        value: floodperiod[currentRack],
                        title: AppTranslations.of(context)
                                .text("Changing_irrigation_period") +
                            (appRack
                                ? AppTranslations.of(context).text("top_rack")
                                : AppTranslations.of(context)
                                    .text("bottom_rack")),
                        description: AppTranslations.of(context).text("period"),
                        decimal: false,
                        minValue: 10,
                        maxValue: 720,
                        isItHourMinuteFormat: true),
                    Divider(
                      height: 10.0,
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(AppTranslations.of(context)
                          .text("phytolamp_settings")),
                    )),
                    myChangeButton("rackparams/$currentRack/phytolamptime/0",
                        attribute: AppTranslations.of(context).text("min"),
                        value: phytolampenabletime[currentRack],
                        title: AppTranslations.of(context)
                                .text("changing_phytolamp_switch-on_time") +
                            (appRack
                                ? AppTranslations.of(context).text("top_rack")
                                : AppTranslations.of(context)
                                    .text("bottom_rack")),
                        description:
                            AppTranslations.of(context).text("switch-on"),
                        decimal: false,
                        minValue: 0,
                        maxValue: 720,
                        isDayTime: true),
                    myChangeButton("rackparams/$currentRack/phytolamptime/1",
                        attribute: AppTranslations.of(context).text("min"),
                        value: phytolampdisabletime[currentRack],
                        title: AppTranslations.of(context)
                                .text("changing_phytolamp_switch-on_time") +
                            (appRack
                                ? AppTranslations.of(context).text("top_rack")
                                : AppTranslations.of(context)
                                    .text("bottom_rack")),
                        description:
                            AppTranslations.of(context).text("switch-off"),
                        decimal: false,
                        minValue: 720,
                        maxValue: 1440,
                        isDayTime: true),
                    myChangeButton("rackparams/$currentRack/phytolamppwm",
                        decimal: false,
                        minValue: 0,
                        divisions: 100,
                        maxValue: 100,
                        attribute: "%",
                        value: phytolamppwm[currentRack],
                        title: AppTranslations.of(context)
                                .text("changing_phytolamp_pwm") +
                            (appRack
                                ? AppTranslations.of(context).text("top_rack")
                                : AppTranslations.of(context)
                                    .text("bottom_rack")),
                        description: AppTranslations.of(context).text("power")),
                  ],
                );
              }

              return snap.data.snapshot.value == null
//return sizedbox if there's nothing in database.
                  ? SizedBox()
//otherwise return a list of widgets.
                  : ListView(
                      addAutomaticKeepAlives: true,
                      children: <Widget>[
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                              AppTranslations.of(context).text("air_settings")),
                        )),
                        myChangeButton("chamberparams/0/airtargettemp",
                            decimal: true,
                            maxValue: 40,
                            divisions: 80,
                            q10: true,
                            attribute: "°C",
                            value: airTemp,
                            title: AppTranslations.of(context)
                                .text("change_of_temperature"),
                            description: AppTranslations.of(context)
                                .text("temperature")),
                        myChangeButton("chamberparams/0/airtargethum",
                            decimal: false,
                            maxValue: 100,
                            divisions: 100,
                            q10: true,
                            attribute: "%",
                            value: airHum,
                            title: AppTranslations.of(context)
                                .text("change_in_humidity"),
                            description:
                                AppTranslations.of(context).text("humidity")),
                        Divider(
                          height: 10.0,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(AppTranslations.of(context)
                              .text("water_ph_settings")),
                        )),
                        myChangeButton("chamberparams/0/targetph",
                            decimal: true,
                            maxValue: 12,
                            divisions: 24,
                            q10: true,
                            attribute: "pH",
                            value: waterPH,
                            title:
                                AppTranslations.of(context).text("change_ph"),
                            description: "PH:"),
                        Divider(
                          height: 10.0,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(AppTranslations.of(context)
                              .text("fans_settings")),
                        )),
                        myChangeButton("chamberparams/0/fanpwm",
                            decimal: false,
                            minValue: 20,
                            maxValue: 100,
                            divisions: 80,
                            attribute: "%",
                            value: fanpwm,
                            title: AppTranslations.of(context)
                                .text("change_the_pwm_fan"),
                            description: AppTranslations.of(context)
                                .text("power")),
                        myChangeButton("chamberparams/0/fanenableperiod",
                            decimal: false,
                            minValue: 10,
                            maxValue: 300,
                            attribute: AppTranslations.of(context).text("min"),
                            value: fanenableperiod,
                            title: AppTranslations.of(context)
                                .text("changing_period_fan_operation"),
                            description:
                                AppTranslations.of(context).text("period"),
                            isItHourMinuteFormat: true),
                        myChangeButton("chamberparams/0/fanenableduration",
                            decimal: false,
                            minValue: 0,
                            maxValue: 300,

                            attribute: AppTranslations.of(context).text("min"),
                            value: fanenableduration,
                            title: AppTranslations.of(context)
                                .text("duration_of_work_of_fans"),
                            description:
                                AppTranslations.of(context).text("duration"),
                            isItHourMinuteFormat: true),
                        Divider(
                          height: 10.0,
                        ),
                        rackData(appRack: currentRack == 0)
                      ],
                    );
            } else {
              return Center(
                  child: Text(AppTranslations.of(context)
                      .text("loading"), style: Theme.of(context).textTheme.headline3));
            }
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void saveNewConfig(String child, String data, {bool q10 = false}) {
    double value = double.parse(data);
    if (q10) {
      value = value * 10;
    }
    database
        .reference()
        .child('devices')
        .child(widget.deviceID)
        .child("commands")
        .push()
        .child("modconfig")
        .child(child)
        .set(value)
        .then((value) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: AppTranslations.of(context).text("changes_saved_successfully"),
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.green,
          fontSize: 16.0);
    });
  }

  Widget myChangeButton(String child,
      {dynamic value = 0,
      bool q10 = false,
      String attribute = "",
      String label,
      String title,
      String description = "",
      bool isDayTime = false,
      bool isItHourMinuteFormat = false,
      int divisions = 100,
      double minValue = 0,
      double maxValue = 100,
      bool decimal = false
      }) {
    if ( isDayTime) {
      decimal = false;
      maxValue=  60*24/1;
      divisions = ((60*24)/30).round();
    } else if (isItHourMinuteFormat) {
      decimal = false;
      divisions = ((maxValue.round() - minValue.round())/5).round();

    }

    if (label == null)
      label = AppTranslations.of(context).text("enter_new_value") +"$minValue < X < $maxValue";
    if (title == null)
      title = AppTranslations.of(context).text("change_of_parameters");
    int hours;
    int minutes;
    int newvalue;
    String textValue;
    if (isItHourMinuteFormat) {
      newvalue = value;
      hours = (value / 60).floor();
      minutes = value - hours * 60;
      if (hours == 0) {
        textValue = description +
            " " +
            minutes.toString() +
            " " +
            AppTranslations.of(context).text("min_m");
      } else {
        textValue = description +
            " " +
            hours.toString() +
            " " +
            AppTranslations.of(context).text("hour_m") +
            " " +
            minutes.toString() +
            " " +
            AppTranslations.of(context).text("min_m");
      }
    } else if (isDayTime) {
      newvalue = value;
      hours = (value / 60).floor();
      minutes = value - hours * 60;
      DateTime datatime = DateTime(2000, 1, 1, hours, minutes);
      var formatter = AppTranslations.of(context).currentLanguage == "ru"
          ? new DateFormat('HH:mm')
          : DateFormat.jm();

      String formattedTime = formatter.format(datatime);
      textValue = description + " " + formattedTime;
    } else {
      textValue = "$description $value $attribute";
    }

    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return MyChangeButtonDialog(
                title: title,
                child: child,
                deviceID: widget.deviceID,
                hours: hours,
                isDayTime: isDayTime,
                isItHourMinuteFormat: isItHourMinuteFormat,
                label: label,
                minutes: minutes,
                q10: q10,
                value: value,
                divisions: divisions,
                decimal: decimal,
                maxValue: maxValue,
                minValue: minValue,
              );
            });
      },
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(textValue),
      )),
    );
  }
}
