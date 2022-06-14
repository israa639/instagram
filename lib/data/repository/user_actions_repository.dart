import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/data/models/user.dart';

import '../models/post.dart';

class UserActivitiesRepository{
  final _firestore=FirebaseFirestore.instance;
  late user  current_user;

  //UserActivitiesRepository(this.current_user);
void setUser(user Current)
{
  this.current_user=Current;
}
  Future<void> addPost(String newPostId)
  async {
    _firestore.collection('user').doc(current_user?.userId).update({'posts': FieldValue.arrayUnion([newPostId])});

  }
  Future<void> Follow(String friendId)
  async {

  }



  Future<String> loadImage(String img_url1)async {

    try{
      final String url= await FirebaseStorage.instance.ref("/profile_images").child(img_url1).getDownloadURL();
      return url;
    }
    catch(e){
      throw Exception(e.toString());
    }

  }




}
