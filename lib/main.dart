

import 'dart:io';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as Mobfirestore;
import 'package:emerge/router.dart';
import 'package:emerge/themes/custom_theme.dart';
import 'package:emerge/themes/themes.dart';
import 'package:emerge/ui/pages/aus.dart';
import 'package:emerge/ui/widgets/Circle.dart';
import 'package:emerge/videocalls/pages/call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locale/app_translations_delegate.dart';
import 'locale/application.dart';


Mobfirestore.Firestore firestore = Mobfirestore.Firestore.instance;
SharedPreferences prefs;
FirebaseUser user;
FirebaseDatabase database;
Map<String, Object> userdata;
bool isDarkTheme;
String currentDeviceId;
final FirebaseMessaging fcm = FirebaseMessaging();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
      googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
      gcmSenderID: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : const FirebaseOptions(
      googleAppID: '1:53994373947:android:c43f8bc5d0763490b76d1e',
      apiKey: 'AIzaSyA6bt__ymJedW_zde-nW4WxiqNrZ2Jukpk',
      databaseURL: 'https://fbproj-62d34.firebaseio.com/',
    ),
  );
  database = FirebaseDatabase(app: app);
  await SharedPreferences.getInstance().then((value) {
    prefs = value;
    if (prefs != null && prefs.get("isDarkTeme") != null) {
      isDarkTheme = prefs.get("isDarkTeme");
    }
  });

  isDarkTheme = isDarkTheme == null ? false : isDarkTheme;
//  await initializeDateFormatting();
  runApp(
    CustomTheme(
      initialThemeKey: isDarkTheme ? MyThemeKeys.DARKFC : MyThemeKeys.LIGHTFC,
      child: MyApp(),
    ),
  );
}
State mainState;
Widget mirror = MyMirror();
class MyMirror extends StatefulWidget {


  @override
  MyMirrorState createState() {
    mainState = MyMirrorState();
   return mainState;
  }
}
class MyMirrorState extends State<MyMirror> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  FloatingActionButton(onPressed: () {  },
          child: Container( child: (user==null)? Container() : CallPage(channelName: user.uid, role: ClientRole.Broadcaster)) ,
        );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale;

    if (prefs != null && prefs.get("currenLocale") != null) {
      currentLocale = Locale(prefs.get("currenLocale"));
    }
    _newLocaleDelegate = AppTranslationsDelegate(
      newLocale: currentLocale,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("ru", ""),
      ],
      initialRoute: '/inhotel',
      title: 'Product App',
      theme: CustomTheme.of(context),
      onGenerateRoute: Router.generateRoute,
    );
  }
}