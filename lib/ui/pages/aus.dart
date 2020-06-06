

import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            myGradientButton(context,
              btnText: "Google",
              funk: (){
              Navigator.of(context).pushNamed('/ausgoogle');
              }
            ),
            myGradientButton(context,
                btnText: 'Facebook',
                funk: (){
                  Navigator.of(context).pushNamed('/ausfacebok');
                }
            ),
            myGradientButton(context,
                btnText: "Number",
                funk: (){
                  Navigator.of(context).pushNamed('/ausnumber');
                }
            )
          ],
        ),
      ),
    );
  }
}