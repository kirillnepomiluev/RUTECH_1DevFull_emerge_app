import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:emerge/DeviceInfoPage.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/ui/widgets/MyCard.dart';
import 'package:emerge/ui/widgets/PlayerBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'chart/animated_line_chart.dart';
import 'chart/line_chart.dart';
import 'core/funcs.dart';
import 'locale/app_translations.dart';
import 'main.dart';

class ChartsPage extends StatefulWidget {
  final TabController tabcontroller;
  String deviceID;

  ChartsPage({this.tabcontroller, this.deviceID});

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

Map listCratsData;

class _ChartsPageState extends State<ChartsPage>
    with AutomaticKeepAliveClientMixin<ChartsPage> {
  int currentCamera = 0;
  List<Widget> lineTitles = [];
  List<Map<String, dynamic>> chartData = [
    {
      "line1": "ih",
      "line2": "oh",
      "line1Title": "внутри",
      "line2Title": "снаружи",
      'onTapText1': "влажность",
    },
    {
      "line1": "it",
      "line2": "ot",
      "line1Title": "внутри",
      "line2Title": "снаружи",
      'onTapText1': "t",
    },
    {
      "line1": "ph",
      "line1Title": "внутри",
      'onTapText1': "ph",
    },
    {
      "line1": "tl",
      "line2": "rl0",
      "line3": "rl1",
      "line1Title": "бак",
      "line2Title": "врехний лоток",
      "line3Title": "нижний лоток",
      'onTapText1': "уровень",
    }
  ];
  LineChart lineChart;
  List item = [];

  int indexChartType = 0;
  int intervalTime = 60;

  void getLineChart() {
    item = [];
    int stepEvery = 1;
    lineChart = null;

    if (intervalTime > 1000) {
      stepEvery = (intervalTime / 1000).floor();
    }
    int currentStep = 1;
    listCratsData.forEach((key, value) {
      item.add(key);
    });


    if (item != null && listCratsData != null) {
      item.sort();
      List newitem = [];
      if (stepEvery == 1) {
        newitem = item;
      } else {
        item.forEach((value) {
          if (currentStep == 1) newitem.add(value);
          currentStep++;
          if (currentStep >= stepEvery) currentStep = 1;
        });
      }



      Map<DateTime, double> line1 = Map();
      Map<DateTime, double> line2 = Map();
      Map<DateTime, double> line3 = Map();
      newitem.forEach((element) {
        String image1url = listCratsData[element]['signedurl'];
        int timesnap = listCratsData[element]['time'];
        DateTime datatime =
            DateTime.fromMillisecondsSinceEpoch(timesnap * 1000, isUtc: true);

        dynamic airHum = notNulldata(
            listCratsData[element][chartData[indexChartType]['line1']]);

        if (airHum != null && airHum != "?") {
          if (indexChartType == 3 ||indexChartType == 4 ) airHum = airHum * 10;
          line1.putIfAbsent(datatime, () => airHum);
        }
        if (chartData[indexChartType]['line2'] != null) {
          dynamic airHumOut = notNulldata(
              listCratsData[element][chartData[indexChartType]['line2']]);
          if (airHumOut != null &&airHumOut != "?") {
            if (indexChartType == 3||indexChartType == 4) airHumOut = airHumOut * 10;
            line2.putIfAbsent(datatime, () => airHumOut);
          }
        }
        if (chartData[indexChartType]['line3'] != null) {
          dynamic airHumOut2 = notNulldata(
              listCratsData[element][chartData[indexChartType]['line3']]);
          if (airHumOut2 != null && airHumOut2 != "?") {
            if (indexChartType == 3||indexChartType == 4) airHumOut2 = airHumOut2 * 10;
            line3.putIfAbsent(datatime, () => airHumOut2);
          }
        }
      });
      setState(() {
        lineTitles = [];
        lineTitles.add(Text(
          '${chartData[indexChartType]['line1Title']}',
          style: TextStyle(color: Colors.green),
        ));

        if (line3.isNotEmpty) {
          lineTitles.add(Text(
            '${chartData[indexChartType]['line2Title']}',
            style: TextStyle(color: Colors.blueAccent),
          ));
          lineTitles.add(Text(
            '${chartData[indexChartType]['line3Title']}',
            style: TextStyle(color: Colors.amber),
          ));
          lineChart = LineChart.fromDateTimeMaps([
            line1,
            line2,
            line3
          ], [
            Colors.green,
            Colors.blueAccent,
            Colors.amber
          ], [
            chartData[indexChartType]['onTapText1'],
            chartData[indexChartType]['onTapText1'],
            chartData[indexChartType]['onTapText1']
          ],
              tapTextFontWeight: FontWeight.w400,
              axisTextsStyle: Theme.of(context).textTheme.bodyText2,
              minYValue: chartData[indexChartType]['minY'] ,
              maxYValue: chartData[indexChartType]['maxY']
          );
        } else if (line2.isNotEmpty) {
          lineTitles.add(Text(
            '${chartData[indexChartType]['line2Title']}',
            style: TextStyle(color: Colors.blueAccent),
          ));
          lineChart = LineChart.fromDateTimeMaps([
            line1,
            line2
          ], [
            Colors.green,
            Colors.blueAccent
          ], [
            chartData[indexChartType]['onTapText1'],
            chartData[indexChartType]['onTapText1']
          ],
              tapTextFontWeight: FontWeight.w400,
              axisTextsStyle: Theme.of(context).textTheme.bodyText2,
            minYValue: chartData[indexChartType]['minY'] ,
            maxYValue: chartData[indexChartType]['maxY']
          );
        } else {
          lineChart = LineChart.fromDateTimeMaps([
            line1
          ], [
            Colors.green
          ], [
            chartData[indexChartType]['onTapText1'],
          ],
              tapTextFontWeight: FontWeight.w400,
              axisTextsStyle: Theme.of(context).textTheme.bodyText2,
              minYValue: chartData[indexChartType]['minY'] ,
              maxYValue: chartData[indexChartType]['maxY']
          );
        }
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    database
        .reference()
        .child('plotreadings')
        .child(widget.deviceID)
        .orderByChild("time")
        .limitToLast(intervalTime)
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        //taking the data snapshot.
        DataSnapshot snapshot = event.snapshot;
//it gives all the documents in this list.
        listCratsData = snapshot.value;
        getLineChart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    chartData = [
      {
        "line1": "ih",
        "line2": "oh",
        "line1Title": AppTranslations.of(context).text("inside"),
        "line2Title": AppTranslations.of(context).text("outside"),
        'onTapText1': "%",
        'minY' : 20.0,
        'maxY' : 80.0,
      },
      {
        "line1": "it",
        "line2": "ot",
        "line1Title": AppTranslations.of(context).text("inside"),
        "line2Title": AppTranslations.of(context).text("outside"),
        'onTapText1': "°C",
        'minY' : 10.0,
        'maxY' : 40.0
      },
      {
        "line1": "ph",
        "line1Title": "ph",
        'onTapText1': "ph",
        'minY' : 2.0,
        'maxY' : 12.0
      },
      {
        "line1": "tl",
        "line2": "rl0",
        "line3": "rl1",
        "line1Title": AppTranslations.of(context).text("tank"),
        "line2Title": AppTranslations.of(context).text("top_rack"),
        "line3Title": AppTranslations.of(context).text("bottom_rack"),
        'onTapText1': AppTranslations.of(context).text("level"),
        'minY' : 0.0,
        'maxY' : 4.0
      },
      {
        "line1": "ec",
        "line1Title": "TDS",
        'onTapText1': "ppm",
      },
    ];

    return buildTeamPageBody(context);
  }

  void _handleTap(String name, String photo, String country, String amplua,
      String number, String bio, String interview, String stats) {}

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
                icon: Icon(Icons.invert_colors),
                title: Text(AppTranslations.of(context).text("humidity")),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.toys),
                title: Text(AppTranslations.of(context).text("temp")),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.spa),
                title: Text('Ph'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                title: Text(AppTranslations.of(context).text("level")),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.gradient),
                title: Text("TDS"),
              ),
            ],
            currentIndex: indexChartType,
            onTap: (int index) {
              indexChartType = index;
              getLineChart();
            }),
        body: Container(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
                width: 200,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: lineTitles),
                )),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor),
                padding: const EdgeInsets.all(14.0),
                child: (lineChart != null)
                    ? AnimatedLineChart(lineChart, key: UniqueKey(),
                        tapText: (String prefix, double y, String unit) {
                        return """
                     $y $unit ,
                      """;
                      })
                    : Container(
                        child: Center(child: CircularProgressIndicator()
//                Text(AppTranslations.of(context).text("loading"), style: Theme.of(context).textTheme.headline3,),
                            ),
                      ),
              ),
            ),
            SizedBox(
                width: 200,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "1h",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: intervalTime == 60 ? 15 : 13,
                                color: intervalTime == 60
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            lineChart =null;
                            intervalTime = 60;
                          });
                          getData();
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            "6h",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: intervalTime == 60 * 6 ? 15 : 13,
                                color: intervalTime == 60 * 6
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            lineChart =null;
                            intervalTime = 60 * 6;
                          });
                          getData();
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            "1d",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: intervalTime == 60 * 24 ? 15 : 13,
                                color: intervalTime == 60 * 24
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            lineChart =null;
                            intervalTime = 60 * 24;
                          });
                          getData();
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            "7d",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: intervalTime == 60 * 24 * 7 ? 15 : 13,
                                color: intervalTime == 60 * 24 * 7
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            lineChart =null;
                            intervalTime = 60 * 24 * 7;
                          });
                          getData();
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            "30d",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    intervalTime == 60 * 24 * 30 ? 15 : 13,
                                color: intervalTime == 60 * 24 * 30
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            lineChart =null;
                            intervalTime = 60 * 24 * 30;
                          });
                          getData();
                        },
                      ),
                    ),
                  ],
                )),
          ],
        )));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
