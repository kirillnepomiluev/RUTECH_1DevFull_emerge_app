import 'package:flutter/material.dart';

class BiedgikPage extends StatelessWidget {
  Map<String,dynamic> visitCardData;
  BiedgikPage(this.visitCardData);

  @override
  Widget build(BuildContext context) {
      return Container (
        height: 150,
        width:  100,
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child:  Column(
          children: <Widget>[
          Padding (padding: EdgeInsets.all(8.0),
            child: Text(" Emerge global"),

          ),
            Container(
              child: Text(visitCardData['name']),
            )
        ], )

      );
  }


}