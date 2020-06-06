
import 'package:emerge/src/model/channel.dart';
import 'package:emerge/src/pages/call.dart';
import 'package:emerge/src/views/views.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                addChannel(new Channel(controllerName.text, controllerDesc.text, "id5345"));
              });
            },
            btnText: "Создать канал")
      ],
    );
  }

  void addChannel(Channel channel) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await Firestore.instance
        .collection("channels")
        .document(id)
        .setData(Map.from({
          "id": id,
          "name": channel.name,
          "description": channel.description,
          "adminId": channel.adminId})
    ).then((value) {
      controllerDesc.text = "";
      controllerName.text = "";
    });
  }

}