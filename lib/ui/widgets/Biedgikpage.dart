import 'package:emerge/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BiedgikPage extends StatelessWidget {
  Map<String, dynamic> visitCardData;

  BiedgikPage(this.visitCardData);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 180,
        padding: EdgeInsets.all(2.0),
        color: vGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: vDarkGrey,
                    child: Text(
                      " Emerge global",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white

// image: new DecorationImage(
// image: ,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('телефон'),
                        Text('почта'),
                        Text('телеграм'),
                      ],
                    ),
                  ),
                ),
// Expanded(
// child: Padding(
// padding: const EdgeInsets.all(2.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(visitCardData['phone']),
// Text(visitCardData['mail']),
// Text(visitCardData['telegram']),
// ],
// ),
// ),
// ),
              ],
            ),
            Expanded(
              child: Container(
                child: Text(visitCardData['name']),
              ),
            )
          ],
        ));
  }
}