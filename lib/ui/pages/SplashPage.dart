
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as MobFirebaseFirestore;

import '../../main.dart';





class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
      (currentUser == null)?
        {}
      :
        {

          Firestore.instance
              .collection("users")
              .document(currentUser.uid)
              .get()
              .then((DocumentSnapshot result) {
            if (currentUser.displayName != null) {
              user = currentUser;
              userdata= result.data;

            } else {

            }
          }
          )
              .catchError((err) => print(err))
        }
    })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}