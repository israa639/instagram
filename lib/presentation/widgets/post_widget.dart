
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/post.dart';
import '../../data/models/user.dart';
import '../screens/post_screen.dart';

class Custom_post_widget extends StatelessWidget {
        post  Post;
        user CurrentUser;

        Custom_post_widget(this.Post,this.CurrentUser);

  @override
  Widget build(BuildContext context)  {

    return InkWell(

        onTap: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) =>
                postScreen(this.Post,this.CurrentUser)
                ));
        },
        child: FutureBuilder(future:Post.post_img_downloaded_url,
                            builder: (context,snapshot){
                              if(snapshot.connectionState==ConnectionState.done)
                              { if (snapshot.hasData) {

                                return Container(
                                   // height:MediaQuery.of(context).size.height * 0.1 ,
                                    //width:MediaQuery.of(context).size.width * 1/3,
                                  child: Expanded(

                                  child: Image.network(snapshot.data.toString()),
                                ));}

                              }return Container();

                            }),



    );
  }

}