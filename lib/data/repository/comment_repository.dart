import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/comment.dart';

class commentRepository{

  final _firestore=FirebaseFirestore.instance;

  Future<String> AddComment(String commentText,String userId,String postId)
  async {
    comment newComment=comment(commentText:commentText,userId: userId );
   try {
     String commentId = await _firestore
         .collection('comments')
         .doc()
         .id;
     var result = await _firestore
         .collection("comments")
         .doc(commentId)
         .set(newComment.toDocument());
     _firestore.collection("posts").doc(postId).update({'comments': FieldValue.arrayUnion([commentId])});
return commentId;

   }
   catch(e)
    {
      throw Exception(e.toString());
    }
  }

void DeleteComment()
{

}







}