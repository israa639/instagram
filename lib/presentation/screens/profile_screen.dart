//import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String title = 'israaezzat';
  File ProfileImage=File('');
  String imagePath='';


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {

          },
        ),
        centerTitle: true,
        title: Text(title,),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,

      ),

      body:Column(children:<Widget>[
      Row(children:<Widget>[

    CircleAvatar(radius:60,
        backgroundColor: Colors.grey.shade400,

        backgroundImage :ProfileImage == null?null:FileImage( ProfileImage),),
        SizedBox(width: 1,),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            getImage(source: ImageSource.camera);
          },),

        Text('posts',),
        SizedBox(width: 20,),
        Text('followers',),
        SizedBox(width: 20,),
        Text('following',),

      ]
    ),
   //SizedBox(width: 100,),
   Container(
      alignment: Alignment.center,
        child:ElevatedButton(
          style:ElevatedButton.styleFrom(minimumSize:Size(200,50),
           primary: Colors.grey.shade400,
           onPrimary: Colors.black,


           // Colors.grey,
    ),
         child: Text('edit profile',),


          onPressed: (){ Navigator.of(context).pushNamed('editProfile');},
        ),


   )]) );
  }
  void getImage({required ImageSource source} )async{
       final file=await ImagePicker().pickImage(source: source);
         if(file?.path!=null){
setState(() {
  imagePath=file!.path;
  ProfileImage=File(file!.path);
});
              }
  }
}
