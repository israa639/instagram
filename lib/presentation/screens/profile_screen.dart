import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bloc/auth/auth_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../bloc/user_profile_image/profile_image_bloc.dart';
import '../../data/repository/auth_repository.dart';

class ProfileScreen extends StatefulWidget {



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


 @override
  Widget build(BuildContext context) {
    final _bottom_nav_Bloc=BlocProvider.of<BottomNavBarBloc>(context);
    final posts_number=  _bottom_nav_Bloc.authRepository.current_user.posts==null?0: _bottom_nav_Bloc.authRepository.current_user.posts?.length;
    final followers_number=  _bottom_nav_Bloc.authRepository.current_user.followers==null?0:_bottom_nav_Bloc.authRepository.current_user.followers?.length;
    final following_number=  _bottom_nav_Bloc.authRepository.current_user.following==null?0: _bottom_nav_Bloc.authRepository.current_user.following?.length;
    final _profileImg_bloc= BlocProvider.of<ProfileImageBloc>(context);

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
              InkWell(
                onTap: (){},
            child:BlocBuilder< ProfileImageBloc, ProfileImageState>(
   bloc:_profileImg_bloc,
   builder: (BuildContext context, ProfileImageState state) {
   if (state is loadingUpdatedProfileImage) {
   return  CircularProgressIndicator();
   }
   if(state is ProfileImageInitial)
     {
       return  FutureBuilder(future:state.profile_img_url,
           builder: (context,snapshot){
             if(snapshot.connectionState==ConnectionState.done)
             { if (snapshot.hasData) {
               return CircleAvatar(radius:60,

                 backgroundImage: NetworkImage("${snapshot.data.toString()}"),
               );}

             }return CircleAvatar(radius:60,
               backgroundColor: Colors.grey,);

           });
     }
   if (state is failedUpdateProfileImage) {
      ScaffoldMessenger.of(context)
       .showSnackBar(SnackBar(content: Text(state.error)));






      return CircleAvatar(radius:60,
       backgroundColor: Colors.grey.shade400,);
   }
   if (state is ProfileImageUpdatedSuccessfully) {
   return CircleAvatar(radius:60,
   backgroundColor: Colors.grey.shade400,

   backgroundImage :FileImage( state.profile_img)); }
   else
     return Container();

   }),),

            SizedBox(width: 1,),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                getImage(source: ImageSource.camera);
              },),
            SizedBox(width: 3,),
      Container(

          alignment: Alignment.center,
        child:ElevatedButton(
          style:ElevatedButton.styleFrom(minimumSize:Size(160,45),
            primary: Colors.white,
            onPrimary: Colors.black,


            // Colors.grey,
          ),
          child: Text('edit profile',),


          onPressed: (){ Navigator.of(context).pushNamed('editProfile');},
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

    SizedBox(width:MediaQuery.of(context).size.width * 0.15,),
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

    SizedBox(width:MediaQuery.of(context).size.width * 0.15,),
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
      BlocProvider.of<ProfileImageBloc>(context).add(RequestUpdateProfileImageEvent(File(file!.path)));

    }
  }
}
