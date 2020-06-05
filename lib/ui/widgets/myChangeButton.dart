import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greenbar/locale/app_translations.dart';

import '../../ControlTabPage.dart';
import '../../main.dart';
import 'RaisedGradientButton.dart';

class MyChangeButtonDialog extends StatefulWidget {
  bool isItHourMinuteFormat;

  var hours;
  var minutes;
  bool isDayTime;
  var value;
  String deviceID;
  String title;
  var label;
  var q10;
  String child;
  double minValue;
  double maxValue;
  int divisions;
  bool decimal;

  MyChangeButtonDialog(
      {this.value,
      this.isDayTime = false,
      this.isItHourMinuteFormat = false,
      this.minutes,
      this.hours,
      this.title,
      this.child,
      this.deviceID,
      this.label,
      this.q10,
      this.maxValue = 100,
      this.minValue = 0,
      this.divisions = 100,
      this.decimal = false});

  @override
  _MyChangeButtonDialogState createState() => _MyChangeButtonDialogState();
}

class _MyChangeButtonDialogState extends State<MyChangeButtonDialog> {
  TextEditingController controller;
  TextEditingController controllermin;
  int hours;
  int minutes;
  int maxHours;
  int maxMinutes;
  int minHours;
  int minMinutes;
  double newdataValue;

  @override
  void initState() {
    controller = TextEditingController();
    controllermin = TextEditingController();
    if (widget.isItHourMinuteFormat || widget.isDayTime) {
      hours = widget.hours;
      minutes = widget.minutes;
      maxHours = (widget.maxValue / 60).floor();
      minHours = (widget.minValue / 60).floor();

      controller.text = widget.hours.toString();
      controllermin.text = widget.minutes.toString();
    } else {
      controller.text = "${widget.value}";
    }
    newdataValue = widget.value / 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (newdataValue < widget.minValue) {
      newdataValue = widget.minValue;
    }
    if (newdataValue > widget.maxValue) {
      newdataValue = widget.maxValue;
    }

    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        margin: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ),
            (widget.isItHourMinuteFormat || widget.isDayTime)
                ? Row(
                    children: <Widget>[
                      (widget.maxValue > 60)
                          ? Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.15, 5,4,5 ),
                                child:
                              TextFormField(
                                textAlign: TextAlign.center,
                                inputFormatters: [amountValidator],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: widget.decimal,
                                  signed: false,
                                ),
                                onChanged: (v) {
                                  if (int.parse(v) > maxHours) {
                                    newdataValue = widget.maxValue -
                                        60 +
                                        int.parse(controllermin.text);
                                    controller.text = maxHours.toString();
                                  }
                                  if (int.parse(v) < minHours) {
                                    newdataValue = widget.minValue +
                                        int.parse(controllermin.text);
                                    controller.text = minHours.toString();
                                  }
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText:
                                      AppTranslations.of(context).text("hour"),
                                  alignLabelWithHint: true,
                                ),
                                controller: controller,
                              ),
                            ) )
                          : Container(),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(2, 5,
                              MediaQuery.of(context).size.width*0.15
                              ,5 ),
                          child:
                        TextFormField(
                          textAlign: TextAlign.center,
                          inputFormatters: [amountValidator],
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: widget.decimal,
                            signed: false,
                          ),
                          maxLines: 1,
                          onChanged: (v) {
                            if (int.parse(v) > 59) {
                              newdataValue =
                                  (double.parse(controller.text)) * 60 + 59;
                              controllermin.text = 59.toString();
                            }
                            if (int.parse(v) < 0) {
                              newdataValue =
                                  (double.parse(controller.text)) * 60;
                              controllermin.text = 0.toString();
                            }
                            if ((int.parse(v) +
                                    int.parse(controller.text) * 60) >
                                widget.maxValue) {
                              newdataValue = widget.maxValue;
                              controllermin.text = (widget.maxValue -
                                      int.parse(controller.text) * 60)
                                  .toString();
                            }
                            if ((int.parse(v) +
                                    int.parse(controller.text) * 60) <
                                widget.minValue) {
                              newdataValue = widget.minValue;
                              controllermin.text = (widget.minValue -
                                      int.parse(controller.text) * 60)
                                  .toString();
                            }
                          },
                          decoration: InputDecoration(
                            labelText: AppTranslations.of(context).text("min"),
                            alignLabelWithHint: true,
                          ),
                          controller: controllermin,
                        ), )
                      ),
                    ],
                  )
                : TextFormField(
                    textAlign: TextAlign.center,
                    inputFormatters: [amountValidator],
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: widget.decimal,
                      signed: false,
                    ),
                    decoration: InputDecoration(
                      labelText: widget.label,
                      alignLabelWithHint: true,
                    ),
                    maxLines: 1,
                    onChanged: (v) {
                      double newdataValue = double.parse(v);
                      if (newdataValue < widget.minValue) {
                        newdataValue = widget.minValue;
                        controller.text = newdataValue
                            .toStringAsFixed(widget.decimal ? 1 : 0);
                      }
                      if (newdataValue > widget.maxValue) {
                        newdataValue = widget.maxValue;
                        controller.text = newdataValue
                            .toStringAsFixed(widget.decimal ? 1 : 0);
                      }
                    },
                    controller: controller,
                  ),
            Slider.adaptive(
                value: newdataValue,
                max: widget.maxValue,
                min: widget.minValue,
                divisions: widget.divisions,
                onChanged: (value) {
                  if (widget.isDayTime || widget.isItHourMinuteFormat) {
                    hours = (value.round() / 60).floor();
                    minutes = value.round() - hours * 60;
                    controllermin.text = minutes.toString();
                    controller.text = hours.toString();
                  } else {
                    controller.text =
                        value.toStringAsFixed(widget.decimal ? 1 : 0);
                  }
                  setState(() {
                    newdataValue = value;
                  });
                }),
            myGradientButton(context,
                btnText: AppTranslations.of(context).text("save"), funk: () {
              String newValueToSave = controller.text;
              if (widget.isItHourMinuteFormat || widget.isDayTime) {
                newValueToSave = (int.parse(controller.text) * 60 +
                        int.parse(controllermin.text))
                    .toString();
              }
              saveNewConfig(widget.child, newValueToSave, q10: widget.q10);
            })
          ],
        ),
      ),
    );
  }

  void saveNewConfig(String child, String data, {bool q10 = false}) {
    double value = double.parse(data);
    if (q10) {
      value = value * 10;
    }
    database
        .reference()
        .child('devices')
        .child(widget.deviceID)
        .child("commands")
        .push()
        .child("modconfig")
        .child(child)
        .set(value)
        .then((value) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: AppTranslations.of(context).text("changes_saved_successfully"),
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.green,
          fontSize: 16.0);
    });
  }
}
