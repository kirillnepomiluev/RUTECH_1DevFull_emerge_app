
import 'package:emerge/videocalls/pages/call.dart';
import 'package:emerge/videocalls/pages/confCall.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class HelloCallWidget extends StatefulWidget {

  String interlocutorId;

  @override
  _HelloCallWidgetState createState() => _HelloCallWidgetState();
}

class _HelloCallWidgetState extends State<HelloCallWidget> {

  bool wasAnswered;
  String questionStatus = "Идет вызов";

  @override
  void initState() {
    calling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(questionStatus),
    ],
    );
  }

  Future<bool> calling() async {
    setState(() {
      // здесь await где мы ждем ответа
      wasAnswered ?
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfCallPage(
                        [
                          CallPage(channelName: user.uid, role: ClientRole.Broadcaster),
                          CallPage(channelName: widget.interlocutorId, role: ClientRole.Audience),
                        ]
                    ),
                  )
                  ) : questionStatus = "Нет ответа";
    });
    return true;
  }

}