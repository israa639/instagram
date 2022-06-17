import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/comment_bloc/comment_bloc.dart';
import '../../data/models/post.dart';
import '../../data/models/user.dart';
import 'package:quiver/collection.dart';
class commentsScreen extends StatefulWidget {
  post  Post;
user CurrentUser;
  final _commentBloc;
  commentsScreen(this.Post,this.CurrentUser,this._commentBloc);

  @override
  State<commentsScreen> createState() => _commentsScreenState(this.Post,this.CurrentUser,this._commentBloc);
}

class _commentsScreenState extends State<commentsScreen> {

  post  Post;
  user CurrentUser;
  final _commentBloc;
  _commentsScreenState(this.Post,this.CurrentUser,this._commentBloc);

  var CommentController= TextEditingController() ;
  // addPostScreen(this.post_image);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    CommentController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
   // final _commentBloc=BlocProvider.of<CommentBloc>(context);
    //_commentBloc.add(viewcommentEvent(Post));
    return Scaffold(

      body:


      Column(children:<Widget>[SizedBox(height: 30,),
        Container(
          //height: 10,
            alignment: Alignment.topLeft,
            child:IconButton(
                color: Colors.blue,
                icon: Icon(EvaIcons.arrowBack,size: 30,color: Colors.black,), onPressed: (){Navigator.pop(context);}
            )

        ),
        Expanded(child:
            BlocConsumer<CommentBloc,CommentState>(
    listener: (context, state) {
      if(state is failedAddComment )
        {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      if( state is failedloadComment){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }

    },

    builder: (BuildContext context, CommentState state) {
    if (state is loadingAddComment||state is LoadingGetComments) {
    return Center(child: CircularProgressIndicator());
    }
    if(state is CommentsLoaded  )
       {return Expanded(child:  ListView.builder(

    itemCount:state.UserComment.length,

    itemBuilder: (contex, index) {
      return Container(

        child: Row(
          children: [
            FutureBuilder(future:state.UserComment.keys.elementAt(index).profile_img_downloaded_url,
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.done)
                  { if (snapshot.hasData) {
                    return CircleAvatar(radius:20,

                      backgroundImage: NetworkImage("${snapshot.data.toString()}"),
                    );}

                  }return CircleAvatar(radius:20,
                    backgroundColor: Colors.grey,);

                }),
            TextButton(
                child:Text(state.UserComment.keys.elementAt(index).username,style:TextStyle(fontSize:20,color: Colors.black ),),
                onPressed:() {


                }),
            Text(state.UserComment.values.elementAt(index),style:TextStyle(fontSize:15,color: Colors.black )),
            // Text(state.search_result[index].username,),
          ],


        ),
      );
    }

    ));
       return Container();
       }
    if(state is commentAddedSuccessfully )
    {return   Container(child:ListView.builder(

        itemCount:state.UserComment.length,

        itemBuilder: (contex, index) {
          return Container(

            child: Row(
              children: [
                FutureBuilder(future:state.UserComment.keys.elementAt(index).profile_img_downloaded_url,
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.done)
                      { if (snapshot.hasData) {
                        return CircleAvatar(radius:20,

                          backgroundImage: NetworkImage("${snapshot.data.toString()}"),
                        );}

                      }return CircleAvatar(radius:20,
                        backgroundColor: Colors.grey,);

                    }),
                TextButton(
                    child:Text(state.UserComment.keys.elementAt(index).username,style:TextStyle(fontSize:20,color: Colors.black ),),
                    onPressed:() {


                    }),
                Text(state.UserComment.values.elementAt(index),style:TextStyle(fontSize:15,color: Colors.black )),
                // Text(state.search_result[index].username,),
              ],


            ),
          );
        }

    ));
    return Container();
    }
    else{
    return Container();}
    },)),


       Container(
            alignment: Alignment.bottomLeft,
            child:
            TextField(
                controller:CommentController,

                decoration:InputDecoration(fillColor:Colors.blueGrey.shade50,hintText: "  Write a comment...",
                  hintStyle: TextStyle(fontSize: 20),
                  border: InputBorder.none ,
                  suffixIcon:
                      InkWell(
                    onTap: () {
                      _commentBloc.add(addcommentEvent(CommentController.text, CurrentUser.userId, Post));
                    CommentController.clear(); },
                    child:  Icon(Icons.send,size: 20,color: Colors.black,)
                  ),

                ))),



















      ]),);
  }
}