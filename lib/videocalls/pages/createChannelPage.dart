
import 'dart:math';

import 'package:emerge/videocalls/model/channel.dart';
import 'package:emerge/videocalls/pages/call.dart';
import 'package:emerge/videocalls/views/views.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateChannelPage extends StatefulWidget {

  @override
  _CreateChannelPageState createState() => _CreateChannelPageState();
}

class _CreateChannelPageState extends State<CreateChannelPage> {
  final controllerName = TextEditingController();
  final controllerDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextFormField(
          controller: controllerName,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Название канала"),
          style: new TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w200),
        ),
        TextFormField(
          controller: controllerDesc,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Описание канала"),
          style: new TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w200),
        ),
        ButtonBlueGradient(
            context,
            () {
              setState(() {
                addChannel(new Channel(
                                DateTime.now().millisecondsSinceEpoch.toString(), // id
                                controllerName.text,
                                controllerDesc.text,
                                "id" + Random(45).nextInt(45346).toString()));
              });
            },
            btnText: "Создать канал")
      ],
    );
  }

  void addChannel(Channel channel) async {
    await Firestore.instance
        .collection("channels")
        .document(channel.id)
        .setData(channel.toJson())
        .then((value) {
      controllerDesc.text = "";
      controllerName.text = "";
    });
  }

}