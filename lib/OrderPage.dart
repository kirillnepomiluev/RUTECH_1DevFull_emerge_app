import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerge/ui/widgets/MyCard.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:emerge/ui/widgets/TextFieldPadding.dart';
import 'package:emerge/ui/widgets/ToastWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyScaffold.dart';

class OrderPage extends StatefulWidget {
  int id;
  String group = "";
  String size = "";
  String sector = "";

  OrderPage(this.id, {this.group, this.size});

  @override
  _OrderState createState() => _OrderState(id, group, size);
}

class _OrderState extends State<OrderPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int id;
  String group = "";
  String size = "";
  String sector = "Не указан";
  TextEditingController _nameTFC = TextEditingController();
  TextEditingController _phoneTFC = TextEditingController();
  TextEditingController _addressTFC = TextEditingController();

  _OrderState(this.id, this.group, this.size);

  void saveChanges() async {
    Firestore.instance.collection("order").document().setData({
      'name': _nameTFC.text,
      'phone': _phoneTFC.text,
      'address': _addressTFC.text,
      'id': id,
      'group': group,
      'size': size,
      'sector': sector
    }).whenComplete(() {
      _nameTFC.text = '';
      _phoneTFC.text = '';
      _addressTFC.text = '';

      showCompleteToast(context, "Заявка успешно подана");
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildMyScaffold(context, buildOrderPage(context), "Билеты",
        bottomItemIndex: 2, isAppbar: false, indexdrawer: 3);
  }

  Container buildOrderPage(BuildContext context) {
    return new Container(
        child: ListView(
      children: <Widget>[
        buildMYColumn(context, "Заказ", buildSendContainer(context))
      ],
    ));
  }



  Widget getChips(String data) {
    List<String> parts = data.split("/");
    if (sector == null && parts.length > 0) {
      sector = parts[0];
    }
    return Wrap(
      children: List<Widget>.generate(
        parts.length,
        (int index) {
          return ChoiceChip(
              selectedColor: Theme.of(context).toggleableActiveColor,
              label: Text(parts[index]),
              labelStyle: Theme.of(context).textTheme.subtitle2,
              selected: sector == parts[index],
              onSelected: (bool selected) {
                setState(() {
                  sector = parts[index];
                });
              });
        },
      ).toList(),
      spacing: 12,
    );
  }

  List<Widget> sendParts(String group) {
    List<Widget> parts = <Widget>[
      Text(
        'ФИО',
        style: new TextStyle(fontSize: 16.0, fontFamily: "Roboto"),
      ),
      textFieldPadding(fieldname: 'Иванов Иван Иванович', controller: _nameTFC),
      Text(
        'Телефон',
        style: new TextStyle(fontSize: 16.0, fontFamily: "Roboto"),
      ),
      textFieldPadding(
        fieldname: 'Телефон',
        controller: _phoneTFC,
        keyboardType: TextInputType.phone,
      ),
      Text(
        'Адрес',
        style: new TextStyle(fontSize: 16.0, fontFamily: "Roboto"),
      ),
      textFieldPadding(
          fieldname: 'Улица, дом, квартира', controller: _addressTFC),
    ];
    if (group != null && group == "Комбо") {
      parts.add(Text(
        'Сектор',
        style: new TextStyle(fontSize: 16.0, fontFamily: "Roboto"),
      ));
      parts.add(getChips("А/B/C/D"));
    }
    parts.add(Padding(
      padding: EdgeInsets.all(24),
      child: myGradientButton(context, btnText: "Отправить", funk: () {
        saveChanges();
      }),
    ));
    return parts;
  }

  Container buildSendContainer(BuildContext context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: sendParts(group),
        ),
      );
}
