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
  List<Object>?followers;//array to store user followers


   List<Object>?following=[];//array to store  followings of user
   List<Object>? posts=[];// array to store posts
   List<Object>? other_posts=[];//array to stores the posts that user was tagged in
   String? userId;


  user({required this.username, this.followers, this.following, this.profile_img_url, this.posts, this.other_posts, this.userId,this.name});
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
       "followers":followers,
       "following":following,
       "posts":posts,
       "other_posts":other_posts,
     };

   }

   factory user.fromSnapshot( DocumentSnapshot<Map<String, dynamic>> snap) {
     return user(
      username: snap["username"] ,
      followers:snap["followers"]!=null?List<Object>.from(snap["followers"]): [],
      following: snap["following"]!=null?List<Object>.from(snap["following"]):[],
      profile_img_url: snap["profileURL"]==null?'':snap["profileURL"],
       posts:snap["posts"]!=null?List<Object>.from(snap["posts"]):[],
      other_posts:snap["other_posts"]!=null? List<Object>.from(snap["other_posts"]):[],

       userId:snap["userId"],
       name: snap["name"]==null?'':snap["name"],
     );

   }








}