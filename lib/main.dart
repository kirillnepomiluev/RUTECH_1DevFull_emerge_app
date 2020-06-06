

import 'dart:io';

import 'package:emerge/router.dart';
import 'package:emerge/themes/custom_theme.dart';
import 'package:emerge/themes/themes.dart';
import 'package:firebase/firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase/firebase.dart' as WebFirebase;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locale/app_translations_delegate.dart';
import 'locale/application.dart';


Firestore firestore = Firestore.getInstance();
SharedPreferences prefs;
WebFirebase.User user;

Map<String, Object> userdata;
bool isDarkTheme;
String currentDeviceId;



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
      initialRoute: '/aus',
      title: 'Product App',
      theme: CustomTheme.of(context),
      onGenerateRoute: Router.generateRoute,
    );
  }
}