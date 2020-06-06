

import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';

class Aus extends StatefulWidget {
  @override
  _AusState createState() => _AusState();
}
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
final TextEditingController _tokenController = TextEditingController();
class _AusState extends State<Aus> {
  bool _success;
  String _userID;
  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser _user =
        (await _auth.signInWithCredential(credential)).user;
    assert(_user.email != null);
    assert(_user.displayName != null);
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(_user.uid == currentUser.uid);
    setState(() {
      if (_user != null) {
        _success = true;
        _userID = _user.uid;
        user = _user;
        Navigator.of(context).pushNamed("/inhotel");
      } else {
        _success = false;
      }
    });
  }

  void _signInWithFacebook() async {
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: _tokenController.text,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _success = true;

      } else {
        _success = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: const Text('Test sign in with Google'),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _success == null
                    ? ''
                    : (_success
                    ? 'Successfully signed in, uid: ' + _userID
                    : 'Sign in failed'),
                style: TextStyle(color: Colors.red),
              ),
            ),
            myGradientButton(context,
              btnText: "Google",
              funk: (){
                _signInWithGoogle();
              }
            ),
            myGradientButton(context,
                btnText: 'Facebook',
                funk: (){
                  _signInWithFacebook();
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