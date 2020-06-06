
import 'package:emerge/src/model/channel.dart';
import 'package:emerge/src/pages/call.dart';
import 'package:emerge/src/views/views.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
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
    Firestore.instance.collection("channels").snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((ch) {
        Channel channel = Channel.fromMap(ch.data);
        singleItemWidgetList.add(singleItem(channel));
      });
      setState(() {
        _singleItemWidgetList = singleItemWidgetList;
      });
    });
  }

  Future<void> onJoin(Channel channel) async {
    // await for camera and mic permissions before pushing video page
    Firestore.instance
        .collection("channels")
        .document(channel.id)
        .updateData(Map.from({
        "peoples":  FieldValue.arrayUnion(List.unmodifiable([channel.peoples]))
    }));
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