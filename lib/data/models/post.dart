import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class post{
 final String profile_img_url;
  String? profile_img_downloaded_url;

 final DateTime publish_date;

  String? caption;
  List<Object>? comments;
 List<Object>? likers;
 String? postId;


  post({required this.profile_img_url,this.comments,this.likers,required this.publish_date, this.caption,this.postId});
 Map<String, dynamic> toDocument() {

  return {

   "caption" : caption,
   "comments":comments,
   "imgURL":profile_img_url,
   "likers":likers,
   "publish_date":publish_date,

  };

 }

 factory post.fromSnapshot( DocumentSnapshot<Map<String, dynamic>> snap) {
  return post(
   caption: snap["caption"] ,
   comments:snap["comments"]!=null?List<Object>.from(snap["comments"]): [],
   likers: snap["likers"]!=null?List<Object>.from(snap["likers"]):[],
   profile_img_url: snap["imgURL"]==null?'':snap["imgURL"],
   publish_date:snap["publish_date"],

  );

 }







}