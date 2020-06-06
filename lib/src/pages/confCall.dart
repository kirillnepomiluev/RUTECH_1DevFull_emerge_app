
import 'package:emerge/src/pages/call.dart';
import 'package:flutter/cupertino.dart';

class ConfCallPage extends StatefulWidget {

  ConfCallPage(this.members);
  List<CallPage> members = new List();

  @override
  _ConfCallPageState createState() => _ConfCallPageState();
}

class _ConfCallPageState extends State<ConfCallPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: widget.members,
    );
  }

}