import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bloc/auth/auth_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';
import '../../bloc/user_profile_image/profile_image_bloc.dart';
import '../../data/models/user.dart';
import '../../data/repository/auth_repository.dart';
import '../widgets/post_widget.dart';
import 'login_screen.dart';

class SearchProfileScreen extends StatefulWidget {

  user CurrentUser;
final _ProfileBloc;
  SearchProfileScreen(this.CurrentUser,this._ProfileBloc);

  @override
  State<SearchProfileScreen> createState() => _SearchProfileScreenState(this.CurrentUser,this._ProfileBloc);
}

class _SearchProfileScreenState extends State<SearchProfileScreen> {
  final _ProfileBloc;
  user CurrentUser;

  _SearchProfileScreenState(this.CurrentUser,this._ProfileBloc);

  @override
  Widget build(BuildContext context) {
   // final _ProfileBloc=BlocProvider.of<ProfileBloc>(context);
    final posts_number=  CurrentUser.posts_id==null?0: CurrentUser.posts_id?.length;
    final followers_number=  CurrentUser.followers_id==null?0:CurrentUser.followers_id?.length;
    final following_number=  CurrentUser.following_id==null?0: CurrentUser.following_id?.length;
    final _profileImg_bloc= BlocProvider.of<ProfileImageBloc>(context);
   // _ProfileBloc.add(RequestLoadPosts(this.CurrentUser));

    return  Scaffold(





      appBar: AppBar(

        centerTitle: true,
        title: Text(CurrentUser.username),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,

      ),
      body:Column(children:<Widget>[
        Row(children:<Widget>[

             FutureBuilder(future:this.CurrentUser.profile_img_downloaded_url,
                        builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.done)
                          { if (snapshot.hasData) {
                            return CircleAvatar(radius:60,

                              backgroundImage: NetworkImage("${snapshot.data.toString()}"),
                            );}

                          }return CircleAvatar(radius:60,
                                backgroundColor: Colors.grey,);

                        }),





          SizedBox(width:MediaQuery.of(context).size.width * 0.15,),


          Container(

            alignment: Alignment.center,
            child:ElevatedButton(
              style:ElevatedButton.styleFrom(minimumSize:Size(160,45),
                primary: Colors.white,
                onPrimary: Colors.black,


                // Colors.grey,
              ),
              child: Text('folllow',),


              onPressed: (){ },
            ),),],),
        SizedBox(height: 10,),
        Row(
          children:<Widget> [
            SizedBox(width: 20,),
            Container(
              alignment: Alignment.centerLeft,
              child:Text(CurrentUser.name,style: TextStyle(fontSize: 25),),

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

    BlocBuilder<ProfileBloc , ProfileState>(
    bloc:_ProfileBloc,
    builder: (BuildContext context, ProfileState state) {
if(state is loading_Posts)
  {
    return  Center(child: CircularProgressIndicator());

  }
    if(state is loaded_PostsSuccessfully)
    {
      return   Expanded(child:GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0.2,
          crossAxisCount: 3,
        ),
        itemCount: posts_number!,
        itemBuilder: (context, index) {
          return Custom_post_widget(CurrentUser.posts![index],CurrentUser);
          //
        },

    ) );}
return Container();
    }),





      ] ),
      //SizedBox(width: 100,),

    );
  }


}
