
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchScreen extends StatefulWidget {
  String title='instagram';


  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white70,
      body: Column(children:<Widget>[
      Padding(padding: EdgeInsets.only(top:40,)),


      TextField(
        decoration:InputDecoration(fillColor:Colors.blueGrey.shade50,filled: true,hintText: 'search by username ',

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))) ,

      ),])




    );

  }
}
