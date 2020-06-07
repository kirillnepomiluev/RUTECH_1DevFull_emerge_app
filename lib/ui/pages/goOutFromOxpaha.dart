import 'package:flutter/material.dart';

class GoOutPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center (child:  FlatButton(
        onPressed: () {

          Navigator.pushNamed(context, "/enterpage");
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Вас выгнали из клуба!!!", style: TextStyle( fontSize: 35.0, color: Colors.white),),
        ),
      ) ,) ,

    );


  }

}