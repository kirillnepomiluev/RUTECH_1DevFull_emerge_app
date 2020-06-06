
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget myGradientButton(BuildContext context,
    {String btnText = " ",
      void Function() funk,
      double width,
      double radiusCorner = 5.0,
      Icon icon}) {
  return Container(
    width: width,
    child: RaisedButton(
      color:Theme.of(context).textTheme.headline6.color,
      onPressed: funk,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCorner)),
      padding: const EdgeInsets.all(0),
      child: Ink(
        color: Theme.of(context).textTheme.headline6.color,
        child: Container(
          height: 54,
          padding:  EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              icon == null ? Container() :
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: icon,
              ),
              Text(btnText,
                  textAlign: icon == null ? TextAlign.center : TextAlign.start,
                  style: Theme.of(context).textTheme.headline5)
            ],
          ),
        ),
      ),
    ),
  );
}
