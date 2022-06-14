import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/post_bloc/post_bloc.dart';
class addPostScreen extends StatefulWidget {


  @override
  State<addPostScreen> createState() => _addPostScreenState();
}

class _addPostScreenState extends State<addPostScreen> {
  // File post_image;
    File? imageFile;
    String postCaption='';
    var captionController= TextEditingController() ;
 // addPostScreen(this.post_image);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    captionController.dispose();
    super.dispose();

  }
   void getImage({required ImageSource source}) async {
      await ImagePicker().pickImage(source: source).then((file) => setState(() => imageFile = File(file!.path)));

     /* if(file?.path!=null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>addPostScreen(imageFile)),
      );
    }*/

   }
  @override
  Widget build(BuildContext context) {
    final _post_Bloc=BlocProvider.of<PostBloc>(context);
    return Scaffold(

      body: BlocConsumer<PostBloc, PostState>(
   listener: (context, state)
    {
      if (state is PostAddedSuccessfully) {
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
        _post_Bloc.add(postAddedFinished());


        // _post_Bloc.add( postAddedFinished());


      }

      if (state is PostAddedFailed) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    },

   builder: (context, state) {
    if (state is Loading) {
    return const Center(child: CircularProgressIndicator());
    }
    if (state is NoImageSelected) {
      getImage(source: ImageSource.camera,);
      if (imageFile != null) {
        _post_Bloc.add(selectImageEvent());
      }
    }

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
    _post_Bloc.add(addPostEvent(captionController.text, imageFile));
    },),),
    Row(
    children: [
    Container(
    child:CircleAvatar(radius:60,
    backgroundColor: Colors.grey.shade400,

    backgroundImage :FileImage( imageFile!))
    ),
    Expanded(child:
    TextField(
    controller:captionController,
    onChanged: (caption) {
      setState(() =>postCaption= caption);

    },
    decoration:InputDecoration(fillColor:Colors.blueGrey.shade50,hintText: "Write a caption..",

    border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)) ,


    )))
    ],
    ),]
    );}
    return Container();

    },
    ), );










}}
