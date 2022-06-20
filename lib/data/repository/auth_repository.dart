import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/data/models/user.dart';

class AuthRepository{
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore=FirebaseFirestore.instance;
  late   user   current_user;
  Future<bool> checkUserNameexistence(String username)async
  {
    final documentSnapshot =
    await _firestore.collection('user').where('username',isEqualTo:username).get();
    if(documentSnapshot.size>0)
    {
      return true;
    }
    return false;
  }
  Future<void> signUp({required String email, required String password,required String username,required String name}) async {

    //if(await checkUserNameexistence(username).then((bool flag) => flag==false)) {
      try {


        UserCredential result = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        user? new_user=user(userId:result.user?.uid,username:username,name: name);

        createUser(new_user);
        this.current_user=new_user;

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          throw Exception('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          throw Exception('The account already exists for that email.');
        }
      } catch (e) {
        throw Exception(e.toString());
      }

   /*} else{
      throw Exception("this username is already used" );
    }*/
  }
  //function to check if the username is unique or not

  Future<void> createUser(user new_user)async
  {
    try{

      await _firestore
          .collection("user")
          .doc(new_user.userId)
          .set(new_user.toDocument());
      await _firestore
          .collection("username")
          .doc(new_user.username)
          .set({"user_name":new_user.username});

    }
    catch(e){
      throw Exception(e.toString());
    }

  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await _firestore.collection('user').doc(result.user?.uid ?? '').get();


      if (documentSnapshot.exists) {

        this.current_user= user.fromSnapshot(documentSnapshot);
      }


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
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
  Future<void> delete_user(String user_id) async {

    try{
      await _firestore
          .collection("user")
          .doc(user_id)
          .delete();
    }
    catch(e){
      throw Exception(e.toString());
    }


  }

Future<void> updateProfileImg(File File_image) async {
 try {
   final reference = await FirebaseStorage.instance.ref().child("profile_images/${this.current_user.username}");
   final uploadTask = reference.putFile(File_image);
 }
 catch(e){
   throw Exception(e.toString());
 }

}

}