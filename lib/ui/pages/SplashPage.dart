
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart' as MobFirebaseFirestore;
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:firebase_auth/firebase_auth.dart' as MobFirebaseAuth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;

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