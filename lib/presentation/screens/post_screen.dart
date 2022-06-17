import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/comment_bloc/comment_bloc.dart';
import '../../data/models/post.dart';
import '../../data/models/user.dart';
import 'Comments_screen.dart';
class postScreen extends StatefulWidget {
  post  Post;
  user CurrentUser;
  postScreen(this.Post,this.CurrentUser);

  @override
  State<postScreen> createState() => _postScreenState(this.Post,this.CurrentUser);
}

class _postScreenState extends State<postScreen> {
  user CurrentUser;
  post  Post;

  _postScreenState(this.Post,this.CurrentUser);

  var captionController= TextEditingController() ;
  // addPostScreen(this.post_image);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    captionController.dispose();
    super.dispose();

  }

/*ListView.builder(

        itemCount: (this._poses.length),

        itemBuilder: (contex, index) =>
            Custom_pose_widget(pose:this._poses[index],selectedIndex:_selectedIndex ,),

      ),*/
  @override
  Widget build(BuildContext context) {
    final _commentBloc=BlocProvider.of<CommentBloc>(context);
    return Scaffold(

        body:Column(children:<Widget>[//SizedBox(height: 5,),

          Container(
              //height: 10,
              alignment: Alignment.topLeft,
              child:IconButton(
                  color: Colors.blue,
                  icon: Icon(EvaIcons.arrowBack,size: 30,color: Colors.black,), onPressed: (){Navigator.pop(context);}
              )

          ),
  Container(
    height: 1,
    alignment: Alignment.topRight,
    child:IconButton(
    color: Colors.blue,
    icon: Icon(Icons.more_horiz,size: 25,color: Colors.black,), onPressed: (){}
    )),
SizedBox(height: 8,),

                FutureBuilder(future:Post.post_img_downloaded_url,
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.done)
                      { if (snapshot.hasData) {

                        return Container(
                            height:MediaQuery.of(context).size.height*0.8 ,
                            width:MediaQuery.of(context).size.width ,child:  Image.network(snapshot.data.toString()),
                        );}

                      }return Container();

                    }),

              Row(
                children: [
                  IconButton(
                      color: Colors.blue,
                      icon: Icon(EvaIcons.heartOutline,size: 50,color: Colors.black,), onPressed: () {  }),
                  IconButton(
                      color: Colors.blue,
                      icon: Icon(EvaIcons.messageCircleOutline,size: 50,color: Colors.black,), onPressed: () {

                    _commentBloc.add(viewcommentEvent(Post));
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>
                            commentsScreen(this.Post,this.CurrentUser,_commentBloc)
                        ));
                  })


                ],),





















        ]),);
  }
}