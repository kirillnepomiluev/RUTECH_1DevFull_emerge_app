import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            FlatButton(
              child: Text("Основы программирования"),
            ),
            FlatButton(
              child: Text("Расписание"),
            ),
            FlatButton(
              child: Text("Мои успехи"),
            ),
            FlatButton(
              child: Text("Наш мир"),
            ),
            FlatButton(
              child: Text("Настройки"),
            ),
            Text("ФИО")
          ],
        ),
      ),
      body: Center(
        child: AlertDialog(
          title: Text("Приветсвую тебя, дорогой Друг!"),
          content: Text("Сегодня мы отправляемся в увлекательное путешествие в мир программирования!"),
        backgroundColor: Colors.lightBlueAccent,


        )

       ),

    );
  }
}