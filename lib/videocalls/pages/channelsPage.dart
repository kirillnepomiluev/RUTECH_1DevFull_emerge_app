import 'dart:math';

import 'package:emerge/videocalls//model/channel.dart';
import 'package:emerge/videocalls//pages/call.dart';
import 'package:emerge/videocalls//views/views.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

import 'confCall.dart';

class ChannelsPage extends StatefulWidget {

  @override
  _ChannelsPageState createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> {
  List<Widget> _singleItemWidgetList = new List();
  List<Channel> _channelsList = new List();

  @override
  void initState() {
    super.initState();
    getChannels();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: _singleItemWidgetList,
    );
  }
  Widget singleItem(Channel channel) {
    return Container(
      child: Column(
        children: [
          Text(
            channel.name,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20),
          ),
          Text(channel.description),
          ButtonBlueGradient(
              context,
                  () {
                onJoin(channel);
              },
              btnText: "Перейти в канал")
        ],
      ),
    );
  }

  void getChannels() async {
    List<Widget> singleItemWidgetList = new List();
    List<Channel> channelsList = new List();
    Firestore.instance.collection("channels").snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((ch) {
        Channel channel = Channel.fromMap(ch.data);
        singleItemWidgetList.add(singleItem(channel));
        channelsList.add(channel);
      });
      setState(() {
        _singleItemWidgetList = singleItemWidgetList;
        _channelsList = channelsList;
      });
    });
  }

  Future<void> onJoin(Channel channel) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user != null ? user.uid : "id" + Random(45).nextInt(45346).toString();
    await Firestore.instance
        .collection("channels")
        .document(channel.id)
        .collection("peoples")
        .document(uid)
        .setData(
        { "id" : uid});
    await _handleCameraAndMic();
    // push video page with given channel.dart name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfCallPage(channel.peoples),
      ),
    );
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

}