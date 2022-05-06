
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  String title='instagram';


  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextField make_textField(String textContent)
  {
    return TextField(
      decoration:InputDecoration(fillColor:Colors.blueGrey.shade50,filled: true,hintText: textContent,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(2))) ,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body:
      Column(children:<Widget>[
        Padding(padding: EdgeInsets.only(left:380,top:50,)),


       // SizedBox(height: 40,),
        make_textField('update email'),

        SizedBox(height: 20,),
        // Padding(padding: EdgeInsets.only(left:380,top:100,)),

        make_textField('enter current password'),

        SizedBox(height: 20,),
        make_textField('enter new password'),

        SizedBox(height: 20,),
        make_textField('confirm-new-password'),

        SizedBox(height: 20,),

        make_textField('enter new userName'),

        SizedBox(height: 20,),
        make_textField('enter new password'),

        SizedBox(height: 40,),


        Container(
          alignment: Alignment.center,
          child:ElevatedButton(
            style:ElevatedButton.styleFrom(minimumSize:Size(500,50),
              //primary: Colors.grey.shade300,
              onPrimary: Colors.black,


              // Colors.grey,
            ),
            child: Text('Update',),


            onPressed: (){
              Navigator.of(context).pushNamed('home');
            },
          ),


        )
      ],



      ),


    );

  }
}
