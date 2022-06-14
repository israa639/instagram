import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class post{
 final String post_img_url;
  Future<String>? post_img_downloaded_url;

  DateTime? publish_date;

  String? caption;
  List<Object>? comments;
 List<Object>? likers;
 String? postId;


  post({required this.post_img_url,this.comments,this.likers, this.publish_date, this.caption,this.postId});
 void set_post_img_downloaded_url(Future<String> url)
 {
  this.post_img_downloaded_url=url;
 }


  Map<String, dynamic> toDocument() {

  return {

   "caption" : caption,
   "comments":comments,
   "imgURL":post_img_url,
   "likers":likers,
   "publish_date":Timestamp.fromDate(publish_date!),

  };

 }

 factory post.fromSnapshot( DocumentSnapshot<Map<String, dynamic>> snap) {
  return post(
   caption: snap["caption"] ,
   comments:snap["comments"]!=null?List<Object>.from(snap["comments"]): [],
   likers: snap["likers"]!=null?List<Object>.from(snap["likers"]):[],
   post_img_url: snap["imgURL"]==null?'':snap["imgURL"],
  // publish_date:DateTime.fromMillisecondsSinceEpoch(snap["publish_date"]),

  );

 }







}