

import 'package:emerge/model/peoplesInRoom.dart';
import 'package:flutter/cupertino.dart';

class PeoplesList extends StatefulWidget {

  PeoplesList(this.peoplesInRoom);

  List<List<PeoplesInRoom>> peoplesInRoom = new List();

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
        itemCount:  widget.peoplesInRoom.length,
        itemBuilder: (BuildContext ctx, int index) {
          return  GestureDetector(
            child: Text(widget.peoplesInRoom[index].toString()),
            onTap:() {
              // подойти к человеку или компании
            },
          );
        });
  }

}