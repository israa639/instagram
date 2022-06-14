
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/post.dart';

class Custom_post_widget extends StatelessWidget {
        post  Post;


        Custom_post_widget(this.Post);

  @override
  Widget build(BuildContext context)  {

    return InkWell(
        onLongPress: (){
        },
        onTap: () {

          /* Navigator.push(
            context,
            MaterialPageRoute(
                ));*/
        },
        child:

                  Stack(
                      children:<Widget> [

                        Container(
                          height:80,
                          width:80,
                          decoration: BoxDecoration(

                              //borderRadius:BorderRadius.all(Radius.circular(5.0)),

                              color: Colors.white,
                             //s boxShadow:[ BoxShadow(color: Colors.grey,blurRadius: 5.0),]
                          ),
                        ),
                        FutureBuilder(future:Post.post_img_downloaded_url,
                            builder: (context,snapshot){
                              if(snapshot.connectionState==ConnectionState.done)
                              { if (snapshot.hasData) {

                                return Container(
                                    height: 150,
                                    width:100,child: Expanded(

                                  child: Image.network(snapshot.data.toString()),
                                ));}

                              }return Container();

                            }),

                      ]),

    );
  }

}