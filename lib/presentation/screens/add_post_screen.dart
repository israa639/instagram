import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post_bloc/post_bloc.dart';

class addPostScreen extends StatelessWidget {
   File post_image;

  final captionController = TextEditingController();
  addPostScreen(this.post_image);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    captionController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final _post_Bloc=BlocProvider.of<PostBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white70,
      body: BlocBuilder<PostBloc, PostState>(
        bloc: _post_Bloc,
        builder: (BuildContext context, PostState state) {
      if (state is ImageSelected){
     return Column(children:[
        SizedBox(height: 30,),
        Container(
          alignment: Alignment.topRight,
          child:
        IconButton(
        color: Colors.blue,
            icon: Icon(Icons.check)
          ,
            onPressed: () {
              _post_Bloc.add(addPostEvent(captionController.text, post_image));
            },),),
      Row(
        children: [
          Container(
            child:CircleAvatar(radius:60,
                backgroundColor: Colors.grey.shade400,

                backgroundImage :FileImage( post_image))
          ),
         Expanded(child:
          TextField(
         controller:captionController,
            decoration:InputDecoration(fillColor:Colors.blueGrey.shade50,filled: false,hintText: "Write a caption..",

                border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)) ,


          )))
        ],
      ),]
      );}
      if (state is Loading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is PostAddedSuccessfully){
        //Navigator.pop(context);

             /* return AlertDialog(
                // contentPadding:  EdgeInsets.fromLTRB(50.0, 70.0, 24.0, 24.0),
                  content: Column(

                      children: [
                        Icon(Icons.check, size: 60,),
                        Text("post added successfully"),

                      ])
              );*/
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("post added successfully")));






      }
      if (state is PostAddedFailed){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));

      }
      return Container( child:Text("issss"));



      })

    );

  }
}
