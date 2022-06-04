//import 'dart:html';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bloc/auth/auth_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../data/repository/auth_repository.dart';

class users_ProfileScreen extends StatefulWidget {



  @override
  State<users_ProfileScreen> createState() => _users_ProfileScreenState();
}

class _users_ProfileScreenState extends State<users_ProfileScreen> {

  File ProfileImage=File('');
  String imagePath='';
  @override
  Widget build(BuildContext context) {
    final _bottom_nav_Bloc=BlocProvider.of<BottomNavBarBloc>(context);
    final posts_number=  _bottom_nav_Bloc.authRepository.current_user.posts==null?0: _bottom_nav_Bloc.authRepository.current_user.posts?.length;
    final followers_number=  _bottom_nav_Bloc.authRepository.current_user.followers_id==null?0:_bottom_nav_Bloc.authRepository.current_user.followers_id?.length;
    final following_number=  _bottom_nav_Bloc.authRepository.current_user.following_id==null?0: _bottom_nav_Bloc.authRepository.current_user.following_id?.length;

    return  Scaffold(





      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {

          },
        ),
        centerTitle: true,
        title: Text(_bottom_nav_Bloc.authRepository.current_user.username),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,

      ),
      body:Column(children:<Widget>[
        Row(children:<Widget>[

          CircleAvatar(radius:60,
            backgroundColor: Colors.grey.shade400,

            backgroundImage :ProfileImage == null?null:FileImage( ProfileImage),),


          SizedBox(width: 6,),
          Container(

            alignment: Alignment.center,
            child:ElevatedButton(
              style:ElevatedButton.styleFrom(minimumSize:Size(160,45),
                primary: Colors.blue,
                onPrimary: Colors.black,


                // Colors.grey,
              ),
              child: Text('Follow',),


              onPressed: (){ },
            ),),],),
        SizedBox(height: 10,),
        Row(
          children:<Widget> [
            SizedBox(width: 20,),
            Container(
              alignment: Alignment.centerLeft,
              child:Text(_bottom_nav_Bloc.authRepository.current_user.username,style: TextStyle(fontSize: 25),),

            ),],),
        Divider(
            color: Colors.grey
        ),
        SizedBox(height: 5,),
        Row(
          children:<Widget> [
            SizedBox(width: 10,),
            Container(
              child: Column(
                children: [
                  TextButton(
                      child:Text(posts_number.toString(),style: TextStyle(fontSize: 19),
                      ),
                      onPressed:() {
                      }),

                  Text('posts',style: TextStyle(fontSize: 19),),

                ],
              ),
            ),

            SizedBox(width: 85,),
            Container(
              child: Column(
                children: [
                  TextButton(
                      child:Text(followers_number.toString(),style: TextStyle(fontSize: 19),
                      ),
                      onPressed:() {
                      }),

                  Text('followers',style: TextStyle(fontSize: 19),),

                ],
              ),
            ),

            SizedBox(width: 65,),
            Container(
              child: Column(
                children: [
                  TextButton(
                      child:Text(following_number.toString(),style: TextStyle(fontSize: 19),
                      ),
                      onPressed:() {
                      }),

                  Text('following',style: TextStyle(fontSize: 19)),],),),
          ],
        ),

        Divider(
          color: Colors.grey,

        ),
        SizedBox(height: 5,),
        Row(
            children: [
              SizedBox(width: 40,),
              IconButton(
                icon: Icon(Icons.grid_on_sharp,size: 50,color: Colors.grey,),
                onPressed: () {

                },),
              SizedBox(width: 195,),
              IconButton(
                icon: Icon(Icons.person_pin_outlined,size: 50,color: Colors.grey,),
                onPressed: () {

                },),
            ]),
      ]

      ),
      //SizedBox(width: 100,),



    );
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
