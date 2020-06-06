import 'package:cloud_firestore/cloud_firestore.dart' as MobFirebaseFirestore;
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:flutter/cupertino.dart';

class CommentModel {
  String id;
  String comment;
  String author;
  String date;
  String avatar;
  List<Widget> subcommentsWidgets = new List();
  List<Map> subcomments = new List();



  CommentModel.fromMap(Map snapshot)
      :
        comment = snapshot['comment'] ?? '',
        date = snapshot['date'] ?? '',
        author = snapshot['author'] ?? '',
        avatar = snapshot['avatar'] ?? '',
        subcomments = snapshot.containsKey('subcomms') ? List.from(snapshot['subcomms']) : List();


  toJson() {
    return {
      "comment": comment,
      "author": author,
      "date": date,
      "avatar" : avatar
    };
  }

  @override
  String toString() {
    return 'CommentModel{comment: $comment, author: $author, date: $date, avatar: $avatar, subcommentsWidgets: $subcommentsWidgets}';
  }


}