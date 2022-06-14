import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bloc/auth/auth_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../bloc/user_profile_image/profile_image_bloc.dart';
import '../../data/repository/auth_repository.dart';
import '../widgets/post_widget.dart';

class ProfileScreen extends StatefulWidget {



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


 @override
  Widget build(BuildContext context) {
    final _bottom_nav_Bloc=BlocProvider.of<BottomNavBarBloc>(context);
    final posts_number=  _bottom_nav_Bloc.authRepository.current_user.posts_id==null?0: _bottom_nav_Bloc.authRepository.current_user.posts_id?.length;
    final followers_number=  _bottom_nav_Bloc.authRepository.current_user.followers_id==null?0:_bottom_nav_Bloc.authRepository.current_user.followers_id?.length;
    final following_number=  _bottom_nav_Bloc.authRepository.current_user.following_id==null?0: _bottom_nav_Bloc.authRepository.current_user.following_id?.length;
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
                onTap: (){
                  getImage(source: ImageSource.camera);
                },
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

             }return InkWell( onTap: (){
               getImage(source: ImageSource.camera);
             },
             child:CircleAvatar(radius:60,
               backgroundColor: Colors.grey,));

           });
     }
   if (state is failedUpdateProfileImage) {
      ScaffoldMessenger.of(context)
       .showSnackBar(SnackBar(content: Text(state.error)));

      return  InkWell( onTap: (){
        getImage(source: ImageSource.camera);
      },
          child:CircleAvatar(radius:60,
            backgroundColor: Colors.grey,));

   }
   if (state is ProfileImageUpdatedSuccessfully) {
   return CircleAvatar(radius:60,
   backgroundColor: Colors.grey.shade400,

   backgroundImage :FileImage( state.profile_img)); }
   else
     return Container();

   }),),

            SizedBox(width:MediaQuery.of(context).size.width * 0.15,),


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
  child:Text(_bottom_nav_Bloc.authRepository.current_user.name,style: TextStyle(fontSize: 25),),

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

          Text("Followers",style: TextStyle(fontSize: 19),),

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
          Divider(
              color: Colors.grey
          ),
Expanded(child:
    GridView.count(
   crossAxisCount: 3,
   padding: EdgeInsets.all(4.0),
   childAspectRatio: 8.0 / 9.0,
   children:  new List<Widget>.generate(posts_number!, (index) {
   return Custom_post_widget(_bottom_nav_Bloc.authRepository.current_user.posts![index]);
   }
   )
   /*ListView.builder(
   itemCount: posts_number,

   itemBuilder: ( context, int index){
     if (index>0)
       {
         setState(()=>index+=2);
       }
   return Container(

   child: Row(
   children: [
     postWidget(index , _bottom_nav_Bloc ,posts_number),
     postWidget(index+1 , _bottom_nav_Bloc ,posts_number),
     postWidget(index+2 , _bottom_nav_Bloc ,posts_number),

   //  Custom_post_widget(_bottom_nav_Bloc.authRepository.current_user.posts![index+2]),

]));}

   ),*/),


























        )

         ] ),
          //SizedBox(width: 100,),



           );
 }
  void getImage({required ImageSource source} )async{
    final file=await ImagePicker().pickImage(source: source);
    if(file?.path!=null){
      BlocProvider.of<ProfileImageBloc>(context).add(RequestUpdateProfileImageEvent(File(file!.path)));

    }
  }
  Widget postWidget(int index ,var _bottom_nav_Bloc ,int? size)
  {
    if(index<size!)
    return Custom_post_widget(_bottom_nav_Bloc.authRepository.current_user.posts![index]);
    else
      return Container();
  }
}
