import 'package:emerge/core/panaramafuncLib.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';



class PanoramaTest extends StatefulWidget {
  PanoramaTest({Key key, this.title}) : super(key: key);

  final String title;
  PickedFile _image;

  @override
  _PanoramaTestState createState() => _PanoramaTestState();
}

class _PanoramaTestState extends State<PanoramaTest> with SingleTickerProviderStateMixin {
  File _imageFile;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];
  double longitude= 0;
  double latitude= 0;
  Panorama panaram;
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerY = TextEditingController();
  bool needMove=true;


  @override
  void initState() {
    super.initState();
    controller.text= longitude.toString();


    //Accelerometer events
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x > 0.6 ||event.x <-0.6) {
        longitude =  -(event.z/10);
        controllerY.text = longitude.toString();
      }
    }));



    //UserAccelerometer events
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {


//            if (event.z > 0.05 ||event.z <-0.05) {
//              longitude = longitude - (event.z)*1.1;
//              controller.text = longitude.toString();
//            }

            if (event.y > 0.05 ||event.y <-0.05) {
              latitude = latitude -(event.y*0.25);
              controller.text = latitude.toString();
            }

    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("панорама пример"),
      ),
      body: Panorama(
        animSpeed: 0.0,
        interactive: true,
        longitude: longitude,
        controllerthis: controller,
        controllerthisY: controllerY,


        child: _imageFile != null ? Image.file(_imageFile) : Image.asset('assets/panorama.jpg'),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () async {
          _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);


          setState(() {});
        },
        child: Icon(Icons.panorama),
      ),
    );
  }
}



class SensorsExample extends StatefulWidget {
  @override
  _SensorsExampleState createState() => _SensorsExampleState();
}

class _SensorsExampleState extends State<SensorsExample> {
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();

    //Accelerometer events
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));

    //UserAccelerometer events
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));

    //UserAccelerometer events
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  void dispose() {
    for (StreamSubscription<dynamic> sub in _streamSubscriptions) {
      sub.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
    _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
    _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    return Scaffold(
        appBar: AppBar(title: Text('Sensors Example')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Accelerometer: $accelerometer'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('UserAccelerometer: $userAccelerometer'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Gyroscope: $gyroscope'),
            ),
          ],
        ));
  }
}