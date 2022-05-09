//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bloc/auth/auth_bloc.dart';
import '../../data/repository/auth_repository.dart';

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
    final _authBloc=BlocProvider.of<AuthBloc>(context);
    final posts_number=  _authBloc.current_user.posts==null?0: _authBloc.current_user.posts?.length;
    final followers_number=  _authBloc.current_user.followers==null?0: _authBloc.current_user.followers?.length;
    final following_number=  _authBloc.current_user.following==null?0: _authBloc.current_user.following?.length;

    return  Scaffold(





      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {

          },
        ),
        centerTitle: true,
        title: Text(_authBloc.current_user.username),
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
        Container(
          child: Column(
            children: [
              TextButton(
                  child:Text(posts_number.toString()
                  ),
                  onPressed:() {
                  }),

              Text('posts',),

            ],
          ),
        ),

        SizedBox(width: 15,),
        Container(
          child: Column(
            children: [
              TextButton(
                  child:Text(followers_number.toString()
                  ),
                  onPressed:() {
                  }),

              Text('followers',),

            ],
          ),
        ),

        SizedBox(width: 15,),
        Container(
          child: Column(
            children: [
              TextButton(
                  child:Text(following_number.toString()
                  ),
                  onPressed:() {
                  }),

              Text('following',),

            ],
          ),
        ),


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
