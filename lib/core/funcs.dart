


import 'dart:math';

import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as Mobfirestore;

import '../main.dart';

Future<void> launchUrl (String url, ) async {
  if (await canLaunch(url)) {
  await launch(url);
  } else {
  throw 'Could not launch $url';
  }
}
dynamic notNulldata (String data, {bool needQ10 =true, bool needRound =false}) {
  if (data ==null) return null;
  if (int.parse(data)==65535) return "?";
  if (needRound)  return (int.parse(data)/(needQ10?10:1)).round();
  return int.parse(data)/(needQ10?10:1);
}

double notNullInt(int data) {
  if (data ==null) return 0;

  return data/10;
}

void enterToRoom(String room) async {
  String uid = user != null ? user.uid : "id" + Random(44).nextInt(67054).toString();
  var dataToSet = {
    "id" : uid,
    "name" : (user.displayName != null)?  user.displayName : ("user " + Random(44).nextInt(67054).toString())
  };

  await Mobfirestore.Firestore.instance
      .collection("rooms")
      .document(room)
      .collection("peoples")
      .document(uid)
      .setData(dataToSet);


}