import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/models/post.dart';

 class user{
   String username;
   //String password;
   String? name;
   Future<String>? profile_img_downloaded_url;

   String? profile_img_url;
   List<Object>?followers_id;//array to store user followers
   List<Object>?following_id=[];//array to store  followings of user
   List<Object>? posts_id=[];// array to store posts
   List<Object>? other_posts_id=[];//array to stores the posts that user was tagged in
   String? userId;
   List<post>?posts;

  user({required this.username, this.followers_id, this.following_id, this.profile_img_url, this.posts_id, this.other_posts_id, this.userId,this.name});
   //user({required this.username,  this.userId,this.name});
  void set_profile_img_url(String url)
  {
    this.profile_img_url=url;
  }

   Map<String, dynamic> toDocument() {

     return {

       "username" : username,
       "name":name,
       "userId":userId,
       "profileURL":profile_img_url,
       "followers":followers_id,
       "following":following_id,
       "posts":posts_id,
       "other_posts":other_posts_id,
     };

   }

   factory user.fromSnapshot( DocumentSnapshot<Map<String, dynamic>> snap) {
     return user(
      username: snap["username"] ,
      followers_id:snap["followers"]!=null?List<Object>.from(snap["followers"]): [],
      following_id: snap["following"]!=null?List<Object>.from(snap["following"]):[],
      profile_img_url: snap["profileURL"]==null?'':snap["profileURL"],
       posts_id:snap["posts"]!=null?List<Object>.from(snap["posts"]):[],
      other_posts_id:snap["other_posts"]!=null? List<Object>.from(snap["other_posts"]):[],

       userId:snap["userId"],
       name: snap["name"]==null?'':snap["name"],
     );

   }








}