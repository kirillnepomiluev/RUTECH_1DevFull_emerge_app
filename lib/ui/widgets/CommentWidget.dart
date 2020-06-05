import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerge/core/models/CommentModel.dart';
import 'package:emerge/pre/my_flutter_app_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../AddCommentPage.dart';
import 'RaisedGradientButton.dart';

class CommentWidget extends StatefulWidget {
  String _documentID;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommentWidgetState(_documentID);
  }

  CommentWidget(this._documentID);
}

class CommentWidgetState extends State<CommentWidget> {
  List<Widget> _commentWidgetList = new List();
  List<CommentModel> _commentList = new List();
  String _documentID;

  CommentWidgetState(this._documentID);

  @override
  // TODO: implement wantKeepAlive

  void initState() {
    // TODO: implement initState
    super.initState();
    setCommentsList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _commentWidgetList = new List();
    super.dispose();
  }

  void setCommentsList() async {
    List<Widget> commentWidgetList = new List();
    List<CommentModel> commentList = new List();
    Firestore.instance.collection("news").document(_documentID).collection("comments").snapshots()
        .listen((snapshot) {
          snapshot.documents.forEach((comment) {
            CommentModel commentModel = CommentModel.fromMap(comment.data);
            commentModel.id = comment.documentID;
            commentModel.subcomments.forEach((element) => commentModel.subcommentsWidgets.add(singleSubComment(context, CommentModel.fromMap(element))));
              commentWidgetList.add(singleComment(context, commentModel, false, documentId: _documentID));
              commentList.add(commentModel);
            });
          setState(() {
               _commentWidgetList = commentWidgetList;
               _commentList = commentList;
              });
        });
  }


  @override
  Widget build(BuildContext context) {
    _commentWidgetList.add(Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: myGradientButton( context,
          btnText: "Оставить комментарий",
          funk: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCommentPage(_documentID),
              ),
            );
          }),
    ));
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: _commentWidgetList,
      ),
    );
  }

}

Widget singleComment(BuildContext context, CommentModel commentModel, bool onMain, {String documentId}) {
  debugPrint("COMMMODLOG" + commentModel.toString());
  return new
  Container(
    padding: onMain ? EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0) : EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    child: Expanded(
      child: new Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                backgroundImage: FirebaseImage(commentModel.avatar),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(commentModel.author + "   ",
                          style: TextStyle(
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        Text(commentModel.date,
                          style: TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(commentModel.comment),
                    ),
                  ],
                ),
              ),
              Icon(MyFlutterApp.heart, color: Colors.red)
            ],
          ),
          commentModel.subcommentsWidgets.isNotEmpty ? Column(
            children: commentModel.subcommentsWidgets,
          ): Container(),
          context.toString().contains("CommentWidget") ? answerButton(context, btnText: "Ответить", funk: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCommentPage(documentId, commentId: commentModel.id),
              ),
            );
          }): Container(),
          Divider()
        ],
      ),
    ),
  );
}

Widget singleSubComment(BuildContext context, CommentModel commentModel) {
  debugPrint("COMMMODLOG" + commentModel.toString());
  return new
  Container(
    padding: EdgeInsets.fromLTRB(18.0, 5.0, 10.0, 5.0),
    child: Expanded(
      child: new Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundImage: FirebaseImage(commentModel.avatar),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(commentModel.author + "   ",
                          style: TextStyle(
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        Text(commentModel.date,
                          style: TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text(commentModel.comment),
                    ),
                  ],
                ),
              ),
              Icon(Icons.add,
                size: 15,
                color: Colors.red)
            ],
          ),
          Divider()
        ],
      ),
    ),

  );
}


