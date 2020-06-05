import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:emerge/core/models/newsModel.dart';
import 'package:emerge/ui/widgets/CommentWidget.dart';
import 'package:emerge/ui/widgets/MyCard.dart';
import 'package:emerge/ui/widgets/RaisedGradientButton.dart';
import 'package:emerge/ui/widgets/TextFieldPadding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


//import 'package:sticky_headers/sticky_headers.dart';

class AddCommentPage extends StatefulWidget {
  String newsId;
  String commentId = "";
  AddCommentPage (this.newsId, {this.commentId});

  @override
  _AddCommentPageState createState() => _AddCommentPageState(newsId, commentId: commentId);
}

class _AddCommentPageState extends State<AddCommentPage> {
  String newsId;
  String commentId = "";
  _AddCommentPageState (this.newsId, {this.commentId});

  TextEditingController commentController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseUser user;
  Map dBuser;
  String photoURL;


  bool isNameValid = false;
  bool isEmailValid = false;

  Future getCurrentUser() async {
    firebaseAuth.currentUser().then((_user) {
      setState(() {
        user = _user;
      });
      Firestore.instance
          .collection("users")
          .document(_user.uid)
          .snapshots()
          .listen((data) {
        setState(() {
          user = _user;
        });
      }); }
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }



  Widget commentColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        textFieldComment(fieldname: "Оставьте комментарий", controller: commentController),
        new Padding(
            padding: EdgeInsets.all(24),
            child: myGradientButton( context,
                btnText: "Написать",
                funk: () {
                    addComment(commentController.text, newsId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentWidget(newsId),
                      ),
                    );
                })
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:commentColumn(context),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Напишите комментарий",
            style: Theme.of(context).textTheme.headline6,
          ),
      )
    );
  }


  void addComment(String comment, String newsId) async {
    debugPrint("commentIdLOG= " + commentId);
    debugPrint("newsId= " + newsId);
    DocumentSnapshot documentSnapshot = await Firestore.instance.collection("users").document(user.uid).get();
    debugPrint("snData" + documentSnapshot.data.toString());
    String avatar = documentSnapshot.data["photoURL"] != null ? documentSnapshot.data["photoURL"] : "";
    String name = documentSnapshot.data["name"] != null ? documentSnapshot.data["name"] : "";
    commentId == "" ? await Firestore.instance
        .collection("news")
        .document(newsId)
        .collection("comments")
        .document(DateTime.now().millisecondsSinceEpoch.toString())
        .setData(Map.from({
      "comment" : comment,
      "author" : name,
      "avatar" : avatar,
      "date" : formatDate(DateTime.now(), [  hh, ':', mm, ':', ss, ' ', dd, '.', mm, '.', yyyy]),
        }
      )
    ) : await Firestore.instance
        .collection("news")
        .document(newsId)
        .collection("comments")
        .document(commentId)
        .updateData(Map.from({
      "subcomms" : FieldValue.arrayUnion(List.unmodifiable([Map.from({
        "comment" : comment,
        "author" : name,
        "avatar" : avatar,
        "date" : formatDate(DateTime.now(), [  hh, ':', mm, ':', ss, ' ', dd, '.', mm, '.', yyyy]
                      ),
                    }
                )
              ]
            )
          )
        })
    );
  }

  void buttonPressed() {}
}
