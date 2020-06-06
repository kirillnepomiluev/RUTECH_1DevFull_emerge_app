

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:emerge/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'call.dart';
import 'confCall.dart';

class HelloCallAcceptorWidget extends StatefulWidget {

  String interlocutorId;
  HelloCallAcceptorWidget(this.interlocutorId);


  @override
  _HelloCallAcceptorWidgetState createState() => _HelloCallAcceptorWidgetState();
}

class _HelloCallAcceptorWidgetState extends State<HelloCallAcceptorWidget> {

  bool wasAnswered;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text("Звонит ${widget.interlocutorId}"),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.call),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(context: context, child:
                    Dialog (
                      backgroundColor: prozrachniy,
                      child: ConfCallPage(
                          [
                            CallPage(channelName: user.uid, role: ClientRole.Broadcaster),
                            CallPage(channelName: widget.interlocutorId, role: ClientRole.Audience),
                          ]
                      )
                      ,)
                );
                firestore.collection("users").document(widget.interlocutorId).collection("chats").add({"name": user.displayName != null? user.displayName : "Незнакомый или Незнакомка",
                "ids" : <String>[user.uid]
                });

              },
            ),
            IconButton(
              icon: Icon(Icons.call_end),
              color: Colors.red,
              onPressed: () {
                // отклонил звонок
              },
            ),
          ],
        )
      ],
    );
  }


}