import 'dart:core';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:emerge/ControlTabPage.dart';
import 'package:emerge/MyScaffold.dart';
import 'package:emerge/main.dart';
import 'package:emerge/ui/widgets/topTabBarSilver.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

import 'ChartsTabPage.dart';
import 'ImagesTabPage.dart';
import 'InfoTabPage.dart';

class DeviceInfoPage extends StatefulWidget {
  String idDevice;
  DeviceInfoPage(this.idDevice, 
     );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DeviceInfoPageState();
  }
}

class _DeviceInfoPageState extends State<DeviceInfoPage> with SingleTickerProviderStateMixin {

  _DeviceInfoPageState();
  DataSnapshot snapshot;
  TabController tabController;
  MainCollapsingToolbar mainCollapsingToolbar;
  String imageOnDeviceInfo= isDarkTheme? prefs.getString("OnDeviceInfoDark"): prefs.getString("OnDeviceInfoLight");
  
  @override
  void initState() {
    firestore
        .collection("stylephotos").document(isDarkTheme? "OnDeviceInfoDark" :"OnDeviceInfoLight" ).get().then((snap) {
      String imageUrl = snap.data["image"];
      setState(() {
        imageOnDeviceInfo= imageUrl;
        prefs.setString(isDarkTheme? "OnDeviceInfoDark" :"OnDeviceInfoLight", imageUrl);
      });
    });

    mainCollapsingToolbar = MainCollapsingToolbar(
      centerTitile: true,
      expandleHeight: 400,
      pages: <Widget>[
        InfoTabPage(tabcontroller: tabController, deviceID: widget.idDevice),
        ControllTabPage(tabcontroller: tabController, deviceID: widget.idDevice),
        ChartsPage(tabcontroller: tabController, deviceID: widget.idDevice),
        ImagesPage(tabcontroller: tabController, deviceID: widget.idDevice)
      ],
      titleMain: "GreenBar",
      ligthTitlemode: true,
      headers: ["Информация","Управление", "График", "Изображния"],
      isTabs: true,
      tabs: [Tab( icon: Icon( Icons.info_outline)), Tab( icon: Icon( Icons.settings)), Tab( icon: Icon( Icons.show_chart)), Tab( icon: Icon( Icons.image))],

      imageHeader: Image(
          image:  imageOnDeviceInfo==null?  AssetImage("assets/greenbar.jpeg") : FirebaseImage(imageOnDeviceInfo),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter),
    );
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildMyScaffold(
        context,
        mainCollapsingToolbar,
        "GreenBar",
        isNeedBottomMenu: false,
        isAppbar: false,
        indexdrawer: 2);
  }


}
