import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerge/locale/app_translations.dart';
import 'package:emerge/ui/widgets/MyCard.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emerge/pre/my_flutter_app_icons.dart' as custicon;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emerge/core/funcs.dart';

import '../../main.dart';

class mainDrawer extends StatefulWidget {
  mainDrawer({Key key, this.index}) : super(key: key);

  int index;



  @override
  State<StatefulWidget> createState() => _mainDrawerState(index);
}

class _mainDrawerState extends State<mainDrawer> with  AutomaticKeepAliveClientMixin<mainDrawer> {

  int index = 0;
  String imageOnDrawerTop= isDarkTheme? prefs.getString("onDrawerTopDark"): prefs.getString("onDrawerTopLight");

  String imageOnDrawerDown = isDarkTheme? prefs.getString("onDrawerDownDark") :  prefs.getString("onDrawerDownLight");
  String url;

  Map _photos;

  _mainDrawerState(int index) {
    this.index = index;
  }

  @override
   initState() {
    super.initState();
    Firestore.instance
        .collection("stylephotos").document(isDarkTheme? "onDrawerTopDark" :"onDrawerTopLight" ).get().then((snap) {
      String _imageOnDrawerTop = snap.data["image"];
      setState(() {
        url =  snap.data["link"];
        imageOnDrawerTop= _imageOnDrawerTop;
        prefs.setString(isDarkTheme? "onDrawerTopDark" :"onDrawerTopLight", _imageOnDrawerTop);
      });
    });
    Firestore.instance
        .collection("stylephotos").document(isDarkTheme? "onDrawerDownDark": "onDrawerDownLight").get().then((snap) {
      String _imageOnDrawerDown = snap.data["image"];
      setState(() {
        imageOnDrawerDown= _imageOnDrawerDown;
        prefs.setString(isDarkTheme? "onDrawerDownDark": "onDrawerDownLight", _imageOnDrawerDown);
      });
    });
  }

  ListTile buildListTile(BuildContext context,
      {indexnumber = 0, direction = '/', IconData mIcon, title = "Главная"}) {
    bool selected = index == indexnumber ? true : false;
    Color _iconColor = selected
        ? Theme.of(context).textTheme.headline3.color
        : Theme.of(context).textTheme.headline4.color;
    TextStyle _textStyle = selected
        ? Theme.of(context).textTheme.headline3
        : Theme.of(context).textTheme.headline4;

    return ListTile(
      selected: selected,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Icon(
                  mIcon,
                  color: _iconColor,
                )),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text(
                  title,
                  style: _textStyle,
                ),
              ),
            )
          ]),
      onTap: () {
        Navigator.pushNamed(context, direction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(

            flex: 4,
            child: imageOnDrawerTop==null ? Text(AppTranslations.of(context).text("loading")) :
            DrawerHeader(
              decoration: new BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    image: FirebaseImage(imageOnDrawerTop)), //
              ),
              child: Container(),
            ),
          ),
          Expanded(flex: 8 ,child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildListTile(context,
                  title: AppTranslations.of(context).text("tab_home"),
                  direction: "/",
                  mIcon: Icons.label_outline,
                  indexnumber: 0),
//              buildListTile(context,
//                  title: "Параметры устройства",
//                  direction: "/",
//                  mIcon: Icons.label_outline,
//                  indexnumber: 0),

              buildListTile(context,
                  title: AppTranslations.of(context).text("settings"),
                  direction: "/settings",
                  mIcon: Icons.settings,
                  indexnumber: 6),
//              buildListTile(context,
//                  title: "О приложении",
//                  direction: "/about",
//                  mIcon: Icons.info,
//                  indexnumber: 7),

             
            ],
          ),),
          Expanded(flex: 3,
              child: imageOnDrawerDown==null? Container() : FlatButton(
                onPressed: () {
                  if (url!=null) {
                    launchUrl(url);
                  }
                },
                child: Center(
                  child: buildMyCardWithPadding(
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: FirebaseImage(imageOnDrawerDown)), //
                            ),
                          ),
                    onTapFunc: () {
                      if (url!=null) {
                        launchUrl(url);
                      }
                    },
                  ),
                ),
              ) )
        ],
      ),
    );
  }

  Future<Map<String, String>> _getMenuPhotos() async {
    Map<String, String> result = new Map();
    DocumentSnapshot documentSnapshot = await firestore
        .collection("stylephotos")
        .document("onDrawerDown")
        .get();
    String imageOnDrawerDown = documentSnapshot.data["image"].toString();
    documentSnapshot =
        await firestore.collection("stylephotos").document("onDrawerTop").get();
    String imageOnDrawerTop = documentSnapshot.data["image"].toString();
    result.putIfAbsent("imageOnDrawerDown", () => imageOnDrawerDown);
    result.putIfAbsent("imageOnDrawerTop", () => imageOnDrawerTop);
    debugPrint("getDrawerPhotos result: " + result.toString());
    return result;
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}
