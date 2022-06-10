
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addPostScreen extends StatelessWidget {
  final File post_image;


  addPostScreen(this.post_image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(children:[
        SizedBox(height: 30,),
        Container(
          alignment: Alignment.topRight,
          child:
        IconButton(
color: Colors.blue,
            icon: Icon(Icons.check)
          ,
            onPressed: () {

            },),),
      Row(
        children: [
          Container(
            child:CircleAvatar(radius:60,
                backgroundColor: Colors.grey.shade400,

                backgroundImage :FileImage( post_image))
          ),
         Expanded(child:
          TextField(
            decoration:InputDecoration(fillColor:Colors.blueGrey.shade50,filled: false,hintText: "Write a caption..",

                border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)) ,

          )))
        ],
      ),]
      )

    );

  }
}
