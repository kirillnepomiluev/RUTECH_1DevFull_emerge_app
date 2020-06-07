import 'package:emerge/model/peoplesInRoom.dart';
import 'package:emerge/themes/colors.dart';
import 'package:emerge/videocalls/pages/helloCallAcceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeoplesList extends StatefulWidget {
  PeoplesList(this.peoplesInRoom);

  List<PeoplesInRoom> peoplesInRoom = new List();

  @override
  _PeoplesListState createState() => _PeoplesListState();
}

class _PeoplesListState extends State<PeoplesList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.peoplesInRoom.length,
        itemBuilder: (BuildContext ctx, int index) {
          return GestureDetector(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(12.0),
                  child: Text(widget.peoplesInRoom[index].name, textAlign: TextAlign.center,)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  child: Dialog(
                    backgroundColor: prozrachniy,
                    child:
                        HelloCallAcceptorWidget(widget.peoplesInRoom[index].id),
                  ));
            },
          );
        });
  }
}
