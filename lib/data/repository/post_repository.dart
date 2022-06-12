import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/post.dart';

class PostRepository{

  final _firestore=FirebaseFirestore.instance;

  Future<String> loadImage(String img_url1,String folderName)async {

    try{
      final String url= await FirebaseStorage.instance.ref("/${folderName}").child(img_url1).getDownloadURL();
      return url;
    }
    catch(e){
      throw Exception(e.toString());
    }

  }

  Future<void>AddPost(String postCaption,File File_image,String userName,int postNo)
  async {
    try {
      post newPost=post(profile_img_url:userName,publish_date: DateTime.now(),caption: postCaption,comments: [],likers: [] );
      final reference = await FirebaseStorage.instance.ref().child("${userName}/${postNo}");
      final uploadTask = reference.putFile(File_image);
      await _firestore
          .collection("posts")
          .doc()
          .set(newPost.toDocument());

    }
    catch(e){
      throw Exception(e.toString());
    }







  }











}