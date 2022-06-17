import 'package:cloud_firestore/cloud_firestore.dart';

class comment{


  String? commentId;
  String commentText;
  String userId;

  comment({required this.commentText,required this.userId});
  Map<String, dynamic> toDocument() {

    return {

      "commentText" : commentText,
      "userId":userId,

    };

  }

  factory comment.fromSnapshot( DocumentSnapshot<Map<String, dynamic>> snap) {
    return comment(
      commentText: snap["commentText"]! ,
      userId:snap["userId"]!,


    );

  }



}