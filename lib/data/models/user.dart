import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/models/post.dart';

 class user{
   String username;
   //String password;
  // String mail;

   late  String? profile_img_url;
  List<dynamic>?followers;//array to store user followers


   List<dynamic>?following=[];//array to store  followings of user
   List<dynamic>? posts=[];// array to store posts
   List<dynamic>? other_posts=[];//array to stores the posts that user was tagged in
   String? userId;

   user({required this.username, this.followers, this.following, this.profile_img_url, this.posts, this.other_posts, this.userId});


   Map<String, dynamic> toDocument() {

     return {

       "username" : username,
       "userId":userId,
       "profileURL":profile_img_url,
       "followers":followers,
       "following":following,
       "posts":posts,
       "other_posts":other_posts,
     };

   }

   factory user.fromSnapshot( DocumentSnapshot<Map<String, dynamic>> snap) {
List<Object> user_followers=[];
List<Object> user_following=[];
List<Object> user_post=[];
List<Object> user_other_post=[];
     return user(
      username: snap["username"] ,
      followers:snap["followers"]!=null?List<Object>.from(snap["followers"]): user_followers,
      following: snap["following"]!=null?List<Object>.from(snap["following"]):user_following,
      profile_img_url: snap["profileURL"]==null?'':snap["profileURL"],
       posts:snap["posts"]!=null?List<Object>.from(snap["posts"]):user_post,
      other_posts:snap["other_posts"]!=null? List<Object>.from(snap["other_posts"]):user_other_post,

       userId:snap["userId"],
     );

   }








}